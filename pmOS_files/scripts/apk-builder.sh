#!/bin/bash
# By Pytel
# Script to build an APK package for pmOS

APP_NAME="empty"
APP_VERSION="1.0.0"
APP_ARCH="armv7"

PKGINFO_SRC=".PKGINFO"

# colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Blue='\033[0;34m'         # Blue
NC='\033[0m'    # No Color

function Help() {
    echo "Usage: $0 [options]"
    echo "This script builds an APK package for pmOS."
    echo "It requires a binary file and a .PKGINFO file in the current directory."
    echo "If the application name is not set, it will be taken from the .PKGINFO file."
    echo
    echo "Options:"
    echo -e "\t -h, --help              Show this help message"
    echo -e "\t -n, --name <name>       Name of the application"
    echo -e "\t -v, --version <version> Version of the application (default: 1.0.0)"
    echo -e "\t -c, --clean             Clean up the build directory"
}

function clean() {
    echo -e "${Green}Cleaning up...${NC}"
    if [ ! -d "$APP_NAME-apk" ]; then
        echo -e "${Red}Error:${NC} Build directory $APP_NAME-apk does not exist."
        exit 1
    fi
    rm -r $APP_NAME-apk
    echo -e "${Green}Done.${NC}"
    exit 0
}

while getopts "n:v:ch" flag
do
	case "${flag}" in
		n) APP_NAME=${OPTARG};;
        v) APP_VERSION=${OPTARG};;
        c) clean;;
		h) Help
		   exit;;
	esac
done

# Check if .PKGINFO file exists in the current directory
if [ ! -f "$PKGINFO_SRC" ]; then
    echo -e "${Red}Error:${NC} Source .PKGINFO file not found."
    echo "Please create a .PKGINFO file in the current directory."
    echo "Example content:"
    echo -e "name = ${Blue}$APP_NAME${NC}"
    echo -e "version = ${Blue}$APP_VERSION${NC}"
    echo "description = Your application description"
    echo "url = https://example.com"
    echo "license = MIT"
    exit 1
fi

# load pkgname from .PKGINFO if not set
if [ "$APP_NAME" == "empty" ]; then
    APP_NAME=$(grep -E '^pkgname =' "$PKGINFO_SRC" | cut -d'=' -f2 | xargs)
    if [ -z "$APP_NAME" ]; then
        echo -e "${Red}Error:${NC} Application name not set and could not be found in .PKGINFO."
        exit 1
    else 
        echo -e "Using application name from .PKGINFO: ${Blue}$APP_NAME${NC}"
    fi
fi

# Optionally load version from .PKGINFO if not set
if [ "$APP_VERSION" == "1.0.0" ]; then
    PKGINFO_VER=$(grep -E '^pkgver =' "$PKGINFO_SRC" | cut -d'=' -f2 | xargs)
    if [ -n "$PKGINFO_VER" ]; then
        APP_VERSION="$PKGINFO_VER"
        echo -e "Using application version from .PKGINFO: ${Blue}$APP_VERSION${NC}"
    fi
fi

# Test if app binary exists in the current directory
if [ ! -f "$APP_NAME" ]; then
    echo -e "${Red}Error:${NC} $APP_NAME binary not found in the current directory."
    echo "Are you sure you have built it?"
    echo " - move to the directory with project files"
    echo " - run 'make' to build the project"
    exit 1
fi

PKGINFO_DST="$APP_NAME-apk/.PKGINFO"
echo -e "Building APK package for ${Blue}$APP_NAME${NC}..."

echo -e "Creating directories..."
mkdir -p $APP_NAME-apk/usr/bin
mkdir -p $APP_NAME-apk/var/db/apk

echo -e "Copy binary to the package directory..."
cp $APP_NAME $APP_NAME-apk/usr/bin/

echo -e "Creating .PKGINFO metadata..."
cp "$PKGINFO_SRC" "$PKGINFO_DST"

# Append additional metadata to .PKGINFO
echo -e "Adding additional metadata to .PKGINFO..."

cat >> "$PKGINFO_DST" <<EOF
builddate = $(date +%s)
packager = $(whoami)
size = $(stat -c %s $APP_NAME)
arch = $APP_ARCH
EOF

echo -e "Creating fake signature files..."
touch $APP_NAME-apk/.SIGN.RSA.fakesign

echo -e "Changing permissions and ownership..."
chmod 755 $APP_NAME-apk/usr/bin/$APP_NAME
chmod 644 $APP_NAME-apk/.PKGINFO
chmod 644 $APP_NAME-apk/.SIGN.RSA.fakesign
chown -R root:root $APP_NAME-apk

echo -e "Packing APK..."
tar -czf $APP_NAME-$APP_VERSION.apk -C $APP_NAME-apk .

echo -e "${Green}APK package created: $APP_NAME-$APP_VERSION.apk${NC}"
echo "Done."
echo -e "${Blue}To install the package, use:${NC}"
echo -e "${Green}sudo apk add --allow-untrusted $APP_NAME-$APP_VERSION.apk${NC}"