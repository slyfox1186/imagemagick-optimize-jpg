#!/bin/bash

clear

# Delete any useless files
if [ -f urls-sh.txt ]; then rm urls-sh.txt; fi

# move scripts to /tmp directory
if [ -f o.sh ]; then mv -f o.sh /tmp; fi
if [ -f ow.sh ]; then mv -f ow.sh /tmp; fi

clear
echo -e "[i] User input required regarding the original files\\n"
echo '[1] Overwrite orignal files'
echo -e "[2] Do not overwrite original files\\n"
read -p 'To make a choice please press [1] or [2]: ' uChoice
clear

if [ "$uChoice" = "1" ]; then source /tmp/ow.sh
elif [ "$uChoice" = "2" ]; then source /tmp/o.sh
else
    echo -e "You must press either the number 1 or 2 key.\\n"
    read -p 'Press Enter to start over.'
    clear
    bash "$0"
    exit 1
fi

# delete this script from pc
# if [ -f "$0" ]; then rm -- "$0"; fi
