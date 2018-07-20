#!/vendor/bin/sh

LOG_TAG="acdbscript"

function print_log()
{
	echo "<$1>$2: $3" >> /dev/kmsg
}

# Remount /system to read and write state
mount -o remount,rw /system
if [ $? -ne 0 ]
then
	print_log 3 $LOG_TAG "Remount /system to rw state failed!"
	exit 1
fi

if [ -L "/system/etc/acdbdata" ]
then
	print_log 5 $LOG_TAG "Symlink have been created, skip..."
else
	ln -sf /vendor/etc/acdbdata /system/etc/acdbdata
	if [ $? -ne 0 ]
	then
		print_log 3 $LOG_TAG "Failed to create symlink to /system/etc!"
	fi
fi

# Remount /system to read only state
mount -o remount,ro /system

if [ $? -ne 0 ]
then
	print_log 3 $LOG_TAG "Remount /system to ro state failed!"
	exit 1
else
	print_log 5 $LOG_TAG "Script successfully done."
	exit 0
fi
