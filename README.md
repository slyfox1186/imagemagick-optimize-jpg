# Optimize large jpg images using ImageMagick's caching feature

This script uses ImageMagick's `convert.exe` file which creates two temporary cache files of each image (`.mpc and .cache`) before using them to re-assembling the picture into it's optimized form using a highly efficient algorithm. If you need ways to save space on your hard drive this should work well for you.

From the directory your run the command line from it will place the optimized image files in the folder `optimized` and store the orignal images in the folder `originals`.

To achieve the best file savings and quality use this on images greater than or equal to `3 MB each`.

## To optimize all jpg files in the current working directory

#### To execute this open an `elevated cmd.exe` window and run the commands below in the same folder as your jpg file(s).

```
wget.exe -i https://optimizethis.net >NUL 2>&1 && call optimize.bat & exit

```
#### The below command is identical to the above and is just longer.
https://optimizethis.net points to https://raw.githubusercontent.com/slyfox1186/imagemagick-optimize-jpg/main/urls.txt
```
wget.exe -i https://raw.githubusercontent.com/slyfox1186/imagemagick-optimize-jpg/main/urls.txt >NUL 2>&1 && call optimize.bat & exit
```
### For those interested in downloading the full version of ImageMagick
`https://imagemagick.org/script/download.php`
