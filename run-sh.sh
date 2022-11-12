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
echo -e "[i] This script ${Green}locates${EC} and ${Green}stores${EC} the ${Purple}path${EC} of each ${Yellow}.${Blue}jpg${EC} file it ${Green}finds${EC} and then uses ${Yellow}each"
echo -e "    match${EC} to ${Green}create${EC} a set of ${Blue}temporary cache files${EC} ${Red}(${Green}stored in ${Blue}/tmp${Red})${EC}."
echo
echo -e "[i] Both ${Pink}temporary ${Purple}cache ${Blue}files are ${Yellow}utilized${EC} using an ${Orange}advanced ${Purple}algorithm that"
echo -e "    compiles the data from each file and outputs a highly optimized version of the original file."
echo
read -p '[i] Press Enter to continue.'
clear

# get user input
echo -e "[i] Input a number to make a selection\\n"
echo -e "[1] Overwrite orignal files"
echo -e "[2] Don't overwrite original files\\n"
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
DEL_FILES=( /tmp/o.sh /tmp/ow.sh ${0:2} )
for i in ${DEL_FILES[@]}; do rm "$i"; done

# unset variables
unset dimension
