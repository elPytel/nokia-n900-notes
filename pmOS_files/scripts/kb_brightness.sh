#!/bin/sh

# Script to control the brightness of the keypad backlight LEDs
# Accepts an offset to change the current value

if ! [ -n "$1" ]; then
	echo "Pass the number to increase or decrease"
	exit 1
fi

if [ $1 -eq 0 ]; then
	echo "A value of zero is not allowed"
	exit 1
fi

TARGET="/sys/class/leds/lp5523"

CURRENT=`cat $TARGET\:kb1/brightness`
if [[ $CURRENT -eq 255 && $1 -gt 0 ]] || [[ $CURRENT -eq 0 && $1 -lt 0 ]]; then
	echo $CURRENT
	exit 0
fi

NEW_VAL=$(( $CURRENT + $1 ))
if [ $NEW_VAL -gt 256 ]
then
	NEW_VAL=255
elif [ $NEW_VAL -lt 0 ]
then
	NEW_VAL=0
fi

for i in $(seq 1 6);
	do echo $NEW_VAL > $TARGET\:kb$i/brightness
done
echo $NEW_VAL
