# Optimize large jpg images using imagemagick's caching feature
This script uses imagemagick's convert.exe file which creates temporary cache files of each jpg image before assembling the final pictures.

If you need to ways to save space on your heard drive this should work well for you.

Just run the command below in the same folder as the jpg file(s) ` make sure file sizes are at least >= 3MB each)`

# You MUST change the variables in the `optimize.bat` script to point to the file `convert.exe` if it is not already in the windows path
# This WILL overwrite the original pictures so it is highly advised to make backups.

To use the below commands:
Open `cmd.exe as an administrator` and change the working directory to the same directory your jpg files

# Download the latest windows version of imagemagick
```
curl.exe "https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-43-Q16-HDRI-x64-dll.exe" > "ImageMagick.exe"
start "" /wait "ImageMagick.exe"
```

# Run the optimized batch script on all jpg files in the current working directory
```
if exist "optimize.bat" del /q "optimize.bat"
curl.exe "https://raw.githubusercontent.com/slyfox1186/imagemagick-optimize-jpg/main/optimize.bat" > "optimize.bat"
call "optimize.bat"
exit

```
