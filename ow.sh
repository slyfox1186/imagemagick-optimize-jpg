#!/bin/bash

clear

# find all jpg files and create temporary cache files from them
for i in *.jpg; do
    echo -e "\\nCreating two temporary cache files: ${i%%.jpg}.mpc + ${i%%.jpg}.cache\\n"
    dimension="$(identify -format '%wx%h' "$i")"
    convert "$i" -monitor -filter Triangle -define filter:support=2 -thumbnail $dimension -strip \
    -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off \
    -auto-level -enhance -interlace none -colorspace sRGB "/tmp/${i%%.jpg}.mpc"
    clear
    for i in /tmp/*.mpc; do
    # find the temporary cache files created above and output optimized jpg files
        if [ -f "$i" ]; then
            echo -e "\\nOverwriting orignal file with optimized self: $i >> ${i%%.mpc}.jpg\\n"
            convert "$i" -monitor "${i%%.mpc}.jpg"
            # overwrite the original image with it's optimized version
            # by moving it from the tmp directory to the source directory
            if [ -f "${i%%.mpc}.jpg" ]; then
                mv "${i%%.mpc}.jpg" "$PWD"
                # delete both cache files before continuing
                rm "$i"
                rm "${i%%.mpc}.cache"
                clear
            fi
        fi
    done
done
