LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := atomic.cpp \
                   dso_handle.cpp
LOCAL_MODULE := libshims_vendor
LOCAL_SHARED_LIBRARIES := libcutils
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_VENDOR_MODULE := true
include $(BUILD_SHARED_LIBRARY)
