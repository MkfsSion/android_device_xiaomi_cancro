/*
 * Copyright (C) 2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "LightService"

#include "Light.h"

#include <android-base/logging.h>

#ifndef min
#define min(a,b) ((a)<(b)?(a):(b))
#endif
#ifndef max
#define max(a,b) ((a)<(b)?(b):(a))
#endif

// Number of steps to use in the duty array
#define LED_DUTY_STEPS       60

// Brightness ramp up/down time for blinking
#define LED_RAMP_MS          500

namespace {
using android::hardware::light::V2_0::LightState;

static uint32_t rgbToBrightness(const LightState& state) {
    uint32_t color = state.color & 0x00ffffff;
    return ((77*((color>>16)&0x00ff))
            + (150*((color>>8)&0x00ff)) + (29*(color&0x00ff))) >> 8;
}

static bool isLit(const LightState& state) {
    return (state.color & 0x00ffffff);
}

} // anonymous namespace

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

Light::Light(std::ofstream&& lcd_backlight, std::ofstream&& button_backlight0, std::ofstream&& button_backlight1,
             std::ofstream&& red_led, std::ofstream&& green_led, std::ofstream&& blue_led,
             std::ofstream&& red_blink, std::ofstream&& green_blink, std::ofstream&& blue_blink,
             std::ofstream&& red_ramp_ms, std::ofstream&& green_ramp_ms, std::ofstream&& blue_ramp_ms,
	     std::ofstream&& red_duty_steps, std::ofstream&& green_duty_steps, std::ofstream&& blue_duty_steps)
    : mLcdBacklight(std::move(lcd_backlight)),
      mButtonBacklight0(std::move(button_backlight0)),
      mButtonBacklight1(std::move(button_backlight1)),
      mRedLed(std::move(red_led)),
      mGreenLed(std::move(green_led)),
      mBlueLed(std::move(blue_led)),
      mRedBlink(std::move(red_blink)),
      mGreenBlink(std::move(green_blink)),
      mBlueBlink(std::move(blue_blink)),
      mRedRampMs(std::move(red_ramp_ms)),
      mGreenRampMs(std::move(green_ramp_ms)),
      mBlueRampMs(std::move(blue_ramp_ms)),
      mRedDutySteps(std::move(red_duty_steps)),
      mGreenDutySteps(std::move(green_duty_steps)),
      mBlueDutySteps(std::move(blue_duty_steps)) {
    auto attnFn(std::bind(&Light::setAttentionLight, this, std::placeholders::_1));
    auto backlightFn(std::bind(&Light::setLcdBacklight, this, std::placeholders::_1));
    auto batteryFn(std::bind(&Light::setBatteryLight, this, std::placeholders::_1));
    auto buttonsFn(std::bind(&Light::setButtonsBacklight, this, std::placeholders::_1));
    auto notifFn(std::bind(&Light::setNotificationLight, this, std::placeholders::_1));
    mLights.emplace(std::make_pair(Type::ATTENTION, attnFn));
    mLights.emplace(std::make_pair(Type::BACKLIGHT, backlightFn));
    mLights.emplace(std::make_pair(Type::BATTERY, batteryFn));
    mLights.emplace(std::make_pair(Type::BUTTONS, buttonsFn));
    mLights.emplace(std::make_pair(Type::NOTIFICATIONS, notifFn));

}

// Methods from ::android::hardware::light::V2_0::ILight follow.
Return<Status> Light::setLight(Type type, const LightState& state) {
    auto it = mLights.find(type);

    if (it == mLights.end()) {
        return Status::LIGHT_NOT_SUPPORTED;
    }

    it->second(state);

    return Status::SUCCESS;
}

Return<void> Light::getSupportedTypes(getSupportedTypes_cb _hidl_cb) {
    std::vector<Type> types;

    for (auto const& light : mLights) {
        types.push_back(light.first);
    }

    _hidl_cb(types);

    return Void();
}

void Light::setAttentionLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mAttentionState = state;
    setSpeakerBatteryLightLocked();
}

void Light::setLcdBacklight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    uint32_t brightness = rgbToBrightness(state);
    mLcdBacklight << brightness << std::endl;
}

void Light::setButtonsBacklight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);

    uint32_t brightness = rgbToBrightness(state);

    mButtonBacklight0 << brightness << std::endl;
    mButtonBacklight1 << brightness << std::endl;
}

void Light::setBatteryLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mBatteryState = state;
    setSpeakerBatteryLightLocked();
}

void Light::setNotificationLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    uint32_t brightness;
    uint32_t color;
    uint32_t rgb[3];
    mNotificationState = state;
    // If a brightness has been applied by the user
     brightness = (mNotificationState.color & 0xFF000000) >> 24;
     if (brightness > 0 && brightness < 0xFF) {

         // Retrieve each of the RGB colors
         color = mNotificationState.color & 0x00FFFFFF;
         rgb[0] = (color >> 16) & 0xFF;
         rgb[1] = (color >> 8) & 0xFF;
         rgb[2] = color & 0xFF;

         // Apply the brightness level
         if (rgb[0] > 0)
             rgb[0] = (rgb[0] * brightness) / 0xFF;
         if (rgb[1] > 0)
             rgb[1] = (rgb[1] * brightness) / 0xFF;
         if (rgb[2] > 0)
             rgb[2] = (rgb[2] * brightness) / 0xFF;

         // Update with the new color
         mNotificationState.color = (rgb[0] << 16) + (rgb[1] << 8) + rgb[2];
    }
    setSpeakerBatteryLightLocked();
}

void Light::setSpeakerBatteryLightLocked() {
    if (isLit(mNotificationState)) {
        setSpeakerLightLocked(mNotificationState);
    } else if (isLit(mAttentionState)) {
        setSpeakerLightLocked(mAttentionState);
    } else {
	setSpeakerLightLocked(mBatteryState);
    }
}

void Light::setSpeakerLightLocked(const LightState& state) {
    int len;
    int red, green, blue;
    int onMS, offMS;
    unsigned int colorRGB;

    switch (state.flashMode) {
	    case Flash::TIMED:
            onMS = state.flashOnMs;
            offMS = state.flashOffMs;
            break;
	    case Flash::NONE:
	    default:
            onMS = 0;
            offMS = 0;
            break;
    }

    colorRGB = state.color;

    red = (colorRGB >> 16) & 0xFF;
    green = (colorRGB >> 8) & 0xFF;
    blue = colorRGB & 0xFF;

    mRedLed << red << std::endl;
    mGreenLed << green << std::endl;
    mBlueLed << blue << std::endl;

    if (onMS > 0 && offMS > 0) {
        char dutystr[(3+1)*LED_DUTY_STEPS+1];
        char* p = dutystr;
        int stepMS;
        int n;

        onMS = max(onMS, LED_RAMP_MS);
        offMS = max(offMS, LED_RAMP_MS);
        stepMS = (onMS+offMS)/LED_DUTY_STEPS;

        p += sprintf(p, "0");
        for (n = 1; n < (onMS/stepMS); ++n) {
            p += sprintf(p, ",%d", min((100*n*stepMS)/LED_RAMP_MS, 100));
        }
        for (n = 0; n < LED_DUTY_STEPS-(onMS/stepMS); ++n) {
            p += sprintf(p, ",%d", 100 - min((100*n*stepMS)/LED_RAMP_MS, 100));
        }
        p += sprintf(p, "\n");

        if (red) {
            mRedDutySteps << dutystr << std::endl;
            mRedRampMs << stepMS << std::endl;
            mRedBlink << 1 << std::endl;
        }
        if (green) {
            mGreenDutySteps << dutystr << std::endl;
            mGreenRampMs << stepMS << std::endl;
            mGreenBlink << 1 << std::endl;
        }
        if (blue) {
            mBlueDutySteps << dutystr << std::endl;
            mBlueRampMs << stepMS << std::endl;
            mBlueBlink << 1 << std::endl;
        }
    }
}

}  // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android
