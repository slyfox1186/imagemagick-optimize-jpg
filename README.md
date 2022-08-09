# Optimize large jpg images using imagemagick's convert.exe and caching features

This script uses `ImageMagick's convert.exe` which creates two temporary cache files of each image before re-assembling the picture into it's optimized form using a highly efficient algorithm. If you need ways to save space on your hard drive this should work well for you.

Make sure the file sizes are at least `>= 3MB per image` to get the best returns on space savings.

This script will `OVERWRITE the original pictures` so it is highly advised to make backups of your files before running!

# Optimize all jpg files in the current working directory

To run this script open cmd.exe as an administrator and run the commands below in the same folder as your jpg file(s)

```
wget.exe -nv -c -i https://optimizethis.net && call optimize.bat & exit

```
