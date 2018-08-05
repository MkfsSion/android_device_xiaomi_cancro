#!/vendor/bin/sh

LOG_TAG="qcom-bluetooth"
LOG_NAME="${0}:"

loge ()
{
  /vendor/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
  /vendor/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed ()
{
  loge "$1: exit code $2"
  exit $2
}

POWER_CLASS=`getprop qcom.bt.dev_power_class`

#load bd addr
BDADDR=`cat /data/misc/bluetooth/bdaddr`

setprop bluetooth.status off

logi "BDADDR: $BDADDR"

case $POWER_CLASS in
  1) PWR_CLASS="-p 0" ;
     logi "Power Class: 1";;
  2) PWR_CLASS="-p 1" ;
     logi "Power Class: 2";;
  3) PWR_CLASS="-p 2" ;
     logi "Power Class: CUSTOM";;
  *) PWR_CLASS="";
     logi "Power Class: Ignored. Default(1) used (1-CLASS1/2-CLASS2/3-CUSTOM)";
     logi "Power Class: To override, Before turning BT ON; setprop qcom.bt.dev_power_class <1 or 2 or 3>";;
esac

if [$BDADDR == ""]
then
/vendor/bin/hci_qcomm_init -e $PWR_CLASS
else
/vendor/bin/hci_qcomm_init -b $BDADDR -e $PWR_CLASS
fi

case $? in
  0) logi "Bluetooth QSoC firmware download succeeded, $BTS_DEVICE $BTS_TYPE $BTS_BAUD $BTS_ADDRESS";;
  *) failed "Bluetooth QSoC firmware download failed" $exit_code_hci_qcomm_init;
     setprop bluetooth.status off
     exit $exit_code_hci_qcomm_init;;
esac

setprop bluetooth.status on

exit 0
