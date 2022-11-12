#!/bin/bash

clear

# Delete any unwanted/useless files or folders
if [ -f index.html ]; then rm index.html; fi
if [ -f urls-sh.txt ]; then rm urls-sh.txt; fi

# define variables
FILES='o.sh ow.sh run-sh.sh'

# execute all scripts in pihole-regex
for i in ${FILES[@]}
do
    if [ -f $i ]; then . $i; fi
done
