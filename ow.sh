#!/bin/bash

clear

echo 'finds all jpg files and converts them to a set of temporary cache'
echo 'files (file-name.cache and file-name.mpc). It then combines both'
echo 'files and outputs a highly optimized (AND OVERWRITTEN) verson of the original images.'
echo
read -p 'Press [Enter] to CONFIRM that you UNDERSTAND this script WILL OVERWRITE the ORIGINAL FILES!'
clear

PARENT_DIR="$(echo "$PWD")"

for i in *.jpg; do
    echo -e "\\nCreating two temporary cache files: ${i%%.jpg}.mpc + ${i%%.jpg}.cache\\n"
    dimension="$(identify -format '%wx%h' "$i")"
    convert "$i" -monitor -filter Triangle -define filter:support=2 -thumbnail $dimension -strip \
    -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off \
    -auto-level -enhance -interlace none -colorspace sRGB "/tmp/${i%%.jpg}.mpc"
    clear
    for i in /tmp/*.mpc; do
        if [ -f "$i" ]; then
            echo -e "\\nOverwriting orignal file with optimized self: $i >> ${i%%.mpc}.jpg\\n"
            convert "$i" -monitor "${i%%.mpc}.jpg"
            if [ -f "${i%%.mpc}.jpg" ]; then
                mv "${i%%.mpc}.jpg" "$PARENT_DIR"
                rm "${i%%.mpc}.cache"
                rm "$i"
                clear
            fi
        fi
    done
done

unset dimension
