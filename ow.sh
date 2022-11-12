#!/bin/bash

clear

# explain purpose of script to user
echo "[i] This script locates and stores the paths of each jpg file found in the script's directory, and"
echo '    from each match it finds and creates a set of temporary cache files.'
echo
echo '[i] ImageMagick will then utilize each cache file created by running an advanced algorithm that combines'
echo '    and compiles a highly optimized version and then stores the output by overwriting the original image.'
echo
echo '[i] To continue the scripts execution you must confirm that you understand it WILL OVERWRITE THE ORIGINAL FILES!'
echo
read -p "[i] Please enter 'Yes' to continue the scripts execution: " uChoice
clear

# validate the user's input
if [[ "$uChoice" != "Yes" ]]; then
    echo -e "[i] You must enter Yes 'exactly as shown' to continue the scripts execution.\\n"
    read -p '[i] Press Enter to start over or ^Z to exit.'
    bash "$0"
    exit 1
elif [[ "$uChoice" = "Yes" ]]; then
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
fi

# unset variables
unset dimension

# delete this script from pc
if [ -f "$0" ]; then rm -- "$0"; fi
