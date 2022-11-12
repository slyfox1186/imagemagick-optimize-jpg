#!/bin/bash

clear

echo "[i] This script locates and stores the paths of each jpg file found in the script's directory, and"
echo '    from each match it finds and creates a set of temporary cache files.'
echo
echo '[i] ImageMagick will then utilize each cache file created by running an advanced algorithm that combines'
echo '    and compiles a highly optimized version and then stores the output by overwriting the original image.'
echo
echo '[i] To continue the scripts execution you must confirm that you understand it WILL OVERWRITE THE ORIGINAL FILES!'
echo
read -p "[i] Please enter 'Yes' to confirm overwrite: " uChoice
clear

if [[ "$uChoice" != "Yes" ]]; then
    echo -e "[i] You must enter Yes 'exactly as shown' to continue the scripts execution.\\n"
    read -p '[i] Press Enter to start over or ^Z to exit.'
    bash "$0"
    exit 1
elif [[ "$uChoice" = "Yes" ]]; then
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
                    mv "${i%%.mpc}.jpg" "$PWD"
                    rm "${i%%.mpc}.cache"
                    rm "$i"
                    clear
                fi
            fi
        done
    done
fi

unset dimension
