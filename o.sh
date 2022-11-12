#!/bin/bash

clear

# explain purpose of script to user
echo "[i] This script locates and stores the paths of each jpg file found in the script's directory, and"
echo '    from each match ImageMagick creates a set of temporary cache files (outputs to /tmp).'
echo
echo '[i] ImageMagick then utilizes each temporary cache file by running an advanced algorithm that'
echo '    combines the two files data and outputs a highly optimized version of the original file.'
echo
echo "[i] The optimized versions of each image will be stored in inside a directory called 'output'"
echo
read -p '[i] Press Enter to continue.'
clear

# make output directory
if [ ! -d output ]; then mkdir -p output; fi

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
                mv "${i%%.mpc}.jpg" "$PWD/output"
                # delete both cache files before continuing
                rm "$i"
                rm "${i%%.mpc}.cache"
                clear
            fi
        fi
    done
done

# unset variables
unset dimension

# delete this script from pc
# if [ -f "$0" ]; then rm -- "$0"; fi
