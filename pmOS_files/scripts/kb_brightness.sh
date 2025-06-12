#!/bin/bash

# Script to control the brightness of the keypad backlight LEDs
# Accepts an offset to change the current value

TARGET="/sys/class/leds/lp5523"

function usage () {
	echo "Usage: $0 <offset>"
	echo "Example: $0 10"
	echo "This will increase the brightness by 10."
	echo "Example: $0 -10"
	echo "This will decrease the brightness by 10."
}

function get_current_brightness () {
	local current
	current=$(cat "$TARGET:kb1/brightness")
	echo $current
}

function update_backlight () { # ( offset )
	local offset=$1
    local current_brightness=$(get_current_brightness)
    if ! [[ "$offset" =~ ^-?[0-9]+$ ]]; then
        echo "Offset must be a number."
        exit 1
    fi
    if [ "$offset" -eq 0 ]; then
        echo "A value of zero is not allowed"
        exit 1
    fi
    local new_val=$(( current_brightness + offset ))
    if [ "$new_val" -gt 255 ]; then
        new_val=255
    elif [ "$new_val" -lt 0 ]; then
        new_val=0
    fi
    echo $new_val
}

if [ -z "$1" ]; then
    usage
    echo ""
    echo "Pass the number to increase or decrease"
    exit 1
fi

new_val=$(update_backlight $1)

for i in $(seq 1 6); do
	echo $new_val > "$TARGET:kb$i/brightness"
	if [ $? -ne 0 ]; then
		echo "Failed to set brightness for kb$i"
	fi
done
echo "Brightness set to: $new_val"
