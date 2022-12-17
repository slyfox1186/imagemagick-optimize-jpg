#!/bin/bash

##############################################################################################################
##
##  Script purpose
##
##  This script locates and stores the path of each .jpg file it finds and then uses each
##  match to create a set of temporary cache files (stored in /tmp).
##
##  Both temporary cache files (.mpc and .cache) are utilized using an advanced algorithm that
##  compiles the data from each file and outputs a highly optimized version of the original.
##

clear

# delete any useless files
if [ -f 'index.html' ]; then rm 'index.html'; fi
if [ -f 'urls-sh.txt' ]; then rm 'urls-sh.txt'; fi

# move scripts to /tmp directory
if [ -f 'o.sh' ]; then mv -f 'o.sh' '/tmp'; fi
if [ -f 'ow.sh' ]; then mv -f 'ow.sh' '/tmp'; fi

# get user input
echo '[i] Input a number'
echo
echo '[1] Overwrite orignal files'
echo '[2] Create new files'
echo
read -p 'Please enter your selection: ' uChoice
clear

# compare user input to get the correct next step
if [ "${uChoice}" = "1" ]; then bash '/tmp/ow.sh'
elif [ "${uChoice}" = "2" ]; then bash '/tmp/o.sh'
else
    clear
    read -p 'Input Error: Press enter to start over.'
    unset uChoice
    bash "${0}"
fi

# delete all scripts from pc
TMP_FILES='/tmp/o.sh /tmp/ow.sh'
DEL_FILES=( ${TMP_FILES} ${0} )

for i in ${DEL_FILES[@]}; do rm "${i}"; done
