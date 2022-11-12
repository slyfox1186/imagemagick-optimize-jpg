#!/bin/bash

clear

# delete any useless files
if [ -f index.html ]; then rm index.html; fi
if [ -f urls-sh.txt ]; then rm urls-sh.txt; fi

# move scripts to /tmp directory
if [ -f o.sh ]; then mv -f o.sh /tmp; fi
if [ -f ow.sh ]; then mv -f ow.sh /tmp; fi

# get user input
clear
echo -e "[i] Input a number to make a selection\\n"
echo '[1] Overwrite orignal files'
echo -e "[2] Do not overwrite original files\\n"
read uChoice
clear

# compare user input to get the correct next step
if [ "$uChoice" = "1" ]; then . /tmp/ow.sh
elif [ "$uChoice" = "2" ]; then . /tmp/o.sh
else
    echo -e "You must press either the number 1 or 2 key.\\n"
    read -p 'Press Enter to start over.'
    clear
    bash "$0"
    exit 1
fi

# delete all scripts from pc
DEL_FILES=( /tmp/o.sh /tmp/ow.sh $0 )
for i in ${DEL_FILES[@]}; do rm "$i"; done
