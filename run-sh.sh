#!/bin/bash

clear

# delete any useless files
if [ -f index.html ]; then rm index.html; fi
if [ -f urls-sh.txt ]; then rm urls-sh.txt; fi

# move scripts to /tmp directory
if [ -f o.sh ]; then mv -f o.sh /tmp; fi
if [ -f ow.sh ]; then mv -f ow.sh /tmp; fi

# explain purpose of script to user
clear
echo "[i] This script locates and stores the paths of each jpg file found in the script's directory, and"
echo '    from each match ImageMagick creates a set of temporary cache files (outputs to /tmp).'
echo
echo '[i] ImageMagick then utilizes each temporary cache file by running an advanced algorithm that'
echo '    combines the two files data and outputs a highly optimized version of the original file.'
echo
read -p '[i] Press Enter to continue.'
clear

# get user input
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

# unset variables
unset dimension
