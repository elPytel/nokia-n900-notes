#!/bin/sh

# Battery protection for the nokia n900
# When battery level falls below 15% gives led notification.
# When battery level falls below 8% powers off the device.
#
# To use it, place the script in `/sbin`, make it executable 
# `sudo chmod +x /sbin/n900-battery-monitor`, then add
# `::respawn:/sbin/n900-battery-monitor` to /etc/inittab, 
# or create a service for it.

# Disable battery charger's status pin
echo 0 > /sys/class/power_supply/bq24150a-0/stat_pin_enable
echo "[$(date +'%d-%m-%Y %H:%M')] Start Service" >> /var/log/critical_battery.log

function alert_low_bat {
	LED="/sys/class/leds/lp5523:r/brightness"
	while true; do
		echo 50 > $LED 
		sleep 0.4

		echo 0 > $LED 
		sleep 0.4

		echo 50 > $LED 
		sleep 1

		echo 0 > $LED 
		sleep 1
	done
}

ALERT_PID=""

while true; do

	CAPACITY=$(cat /sys/class/power_supply/bq27200-0/capacity)
	STATUS=$(cat /sys/class/power_supply/bq27200-0/status)
	# echo "[$(date +'%d-%m-%Y %H:%M')] Level: $CAPACITY% | Status: $STATUS" >> /var/log/critical_battery.log

	if [ $CAPACITY -le 15 ] && 
	   [ "$STATUS" = "Discharging" ] &&
	   [ "$ALERT_PID" = "" ];
	then
		echo "[$(date +'%d-%m-%Y %H:%M')] Level: $CAPACITY% | Status: $STATUS > LED Alarm Enable" >> /var/log/critical_battery.log
		alert_low_bat &
		ALERT_PID=$!
	elif [ $CAPACITY -gt 10 ] ||
		 [ "$STATUS" = "Charging" ] && 
		 [ "$ALERT_PID" != "" ];
	then
		kill $ALERT_PID
		ALERT_PID=""
		LED="/sys/class/leds/lp5523:r/brightness"
		echo 0 > $LED
	elif [ $CAPACITY -le 8 ] &&
	     [ "$STATUS" = "Discharging" ];
	then
		echo "[$(date +'%d-%m-%Y %H:%M')] Level: $CAPACITY% | Status: $STATUS > POWEROFF" >> /var/log/critical_battery.log
		/sbin/poweroff
	fi

	sleep 60

done
