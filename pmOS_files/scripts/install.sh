#!/bin/bash
# By Pytel
# Script to install scipts to the system
# set symbolic links for all the scripts in this dir (except this one)
# to /usr/bin

# colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Blue='\033[0;34m'         # Blue
NC='\033[0m'    # No Color

DESTINATION="/usr/local/bin/"  # Default destination for scripts

THIS_SCRIPT=$(basename "$0")
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

if [[ ! -d $DESTINATION ]]; then
    echo -e "${Red}Error:${NC} Destination directory $DESTINATION does not exist."
    exit 1
fi
if [[ ! -w $DESTINATION ]]; then
    echo -e "${Red}Error:${NC} You do not have write permissions to $DESTINATION."
    echo "Please run this script with sudo or as root."
    exit 1
fi
echo -e "Installing scripts to ${Blue}$DESTINATION${NC}..."


for script in "$SCRIPT_DIR"/*.sh; do
    # Skip if no .sh files are found (globbing returns the pattern itself)
    [[ ! -e "$script" ]] && continue
    script_name=$(basename "$script")
    if [[ ! -x "$script" ]]; then
        echo -e "${Red}Error:${NC} Script $script_name is not executable."
        echo "Please make sure the script is executable with 'chmod +x $script_name'."
        continue
    fi
    if [[ "$script_name" != "$THIS_SCRIPT" ]]; then
        echo -e "Installing script: ${Blue}$script${NC}"
        ln -sf "$script" "$DESTINATION$(basename "$script")"
    fi
done

echo -e "All scripts installed to ${Blue}$DESTINATION${NC}"
echo -e "${Green}Done${NC}"