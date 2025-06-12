#!/bin/bash

SC_DIR="Screenshots"

Help()
{
	echo "Creating screenshots with scrot"
	echo "Without the parameters -p, take a screenshot and place it in the SC folder in the user's home folder."
	echo "If this folder does not exist, it will create it."
	echo
	echo "Usage: $0 [options] [arguments]"
	echo
	echo "Options:"
	echo "-d server         X server to contact"
	echo "-p path           Еhe directory in which you want to place the screenshot"
	echo "-h                Description of the script operation"
}

while getopts d:p:h flag
do
	case "${flag}" in
		d) display=${OPTARG};;
		p) DIR=${OPTARG};;
		h) Help
		   exit;;
	esac
done

if [ -n "$display" ]
then
	DISPLAY_ARG="-display $display"
else
	DISPLAY_ARG=""
fi

if [ ! -n "$DIR" ]; then
	USER_DIR=`eval echo "~$USER"`
	DIR=/$USER_DIR/$SC_DIR/
fi

if [ ! -d "$DIR" ]; then
	mkdir -p $DIR
fi

import $DISPLAY_ARG -window root $DIR/$(date +'%d-%m-%Y_%H-%M-%S').png
