# Optimize large jpg images using imagemagick's convert.exe and caching features
This script uses imagemagick's convert.exe file which creates temporary cache files of each jpg image before assembling the final pictures.

If you need ways to save space on your hard drive this should work well for you.

Make sure file sizes are `at least >= 3MB each`

This script `WILL overwrite` the original pictures so it is highly advised to make backups.

To use the below commands: `Open cmd.exe as an administrator` to the jpg file(s) directory

# Optimize all jpg files in the current working directory

Just run the commands below in the same folder as your jpg file(s) 

```
wget.exe -c -O convert.exe https://github.com/slyfox1186/imagemagick-optimize-jpg/blob/main/convert.exe?raw=true && ^
curl.exe https://raw.githubusercontent.com/slyfox1186/imagemagick-optimize-jpg/main/optimize.bat > optimize.bat && ^
call optimize.bat & exit

```
