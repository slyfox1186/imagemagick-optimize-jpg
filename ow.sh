#!/bin/bash

clear

# find all jpg files and convert them to cache and mpc file format then combine both files and output the optimized images
for i in *.jpg; do
    echo -e "\\nCreating cache files: .mpc + .cache\\n"
    dimension="$(identify -format '%wx%h' "$i")"
    convert "$i" -monitor -filter Triangle -define filter:support=2 -thumbnail $dimension -strip \
    -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off \
    -auto-level -enhance -interlace none -colorspace sRGB "$(basename -- "$i" .jpg).mpc"
    clear
    for i in *.mpc; do
        if [ -f "$i" ]; then
            echo -e "\\nConverting: $i\\n"
            convert "$i" -monitor "$(basename -- "$i" .mpc).jpg"
            rm *.cache
            rm *.mpc
            clear
        fi
    done
done

unset dimension
