# Optimize large jpg images using imagemagick's caching feature
This script uses imagemagick's convert.exe file which creates temporary cache files of each jpg image before assembling the final pictures.

If you need to ways to save space on your heard drive this should work well for you.

Just apply this script to any jpg image files that are `greater than 3MB each`

# This WILL overwrite the original pictures so it is highly advised to make backups.

To use the below commands:
Open `cmd.exe as an administrator` and change the working directory to the same directory your jpg files

# Download the latest windows version of imagemagick
```
curl.exe "https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-43-Q16-HDRI-x64-dll.exe" > "ImageMagick.exe"
start "" /wait "ImageMagick.exe"
```

# Download and run the optimized batch script on all jpg files in the current working directory
```
curl.exe "https://raw.githubusercontent.com/slyfox1186/imagemagick-large-file-optimize/main/optimize.bat" > "optimize.bat"
call "optimize.bat"
```
