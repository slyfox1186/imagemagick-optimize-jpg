#!/bin/bash

clear

echo 'finds all jpg files and converts them to a .cache and .mpc cache'
echo 'format. then combines both files and outputs a highly optimized'
echo 'overwritten verson of the original images.'
echo
read -p 'Press Enter to confirm that you understand this will overwrite the original files!'
clear
for i in *.jpg; do
    echo -e "\\nCreating cache files: .mpc + .cache\\n"
    dimension="$(identify -format '%wx%h' "$i")"
    convert "$i" -monitor -filter Triangle -define filter:support=2 -thumbnail $dimension -strip \
    -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off \
    -auto-level -enhance -interlace none -colorspace sRGB "${i%%.jpg}.mpc"
    clear
    for i in *.mpc; do
        if [ -f "$i" ]; then
            echo -e "\\nConverting: $i\\n"
            convert "$i" -monitor "${i%%.mpc}.jpg"
            rm *.cache
            rm *.mpc
            clear
        fi
    done
done

unset dimension
