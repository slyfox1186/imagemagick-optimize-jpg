# Optimize large JPG images using ImageMagick's caching ability
### CURRENTLY IN TESTING MODE ONLY

* This script requires `ImageMagick for Windows`.
* You must download the `DLL` version that contains the file `convert.exe`
* Add ImageMagick's install directory to the Windows `PATH`
* [Download](https://imagemagick.org/script/download.php)
  - Example: `ImageMagick-some.numbers-Q16-HDRI-x64-dll.exe`

#### Important! Do a TEST RUN with backup files BEFORE running this on any images you value.

The script `optimize.bat` uses ImageMagick's `convert.exe` which creates two temporary cache files (`.mpc and .cache`) from each `.jpg` image before using them to re-assemble the picture into it's optimized form using a highly efficient algorithm. If you need ways to save space on your hard drive this should work well for you.

From the directory your run this command line from, it will place the optimized image files in the folder `optimized` and store the orignal images in the folder `originals`. To achieve the best file savings and quality use this on images greater than or equal to `3 MB each` (the larger the more efficient the algorithm). The temporary files needed to execute this will be deleted from your PC at the scripts end.

## Optimize your jpg images

#### To execute this open an `elevated cmd.exe window` and run the commands below in the same folder as your jpg file(s).

```
wget.exe -c -i https://github.com/slyfox1186/imagemagick-optimize-jpg/raw/main/optimize.bat >NUL 2>&1 && ^
call optimize.bat && ^
exit

```
#### The below command will delete the original files. Beware!
```
wget.exe -c https://github.com/slyfox1186/imagemagick-optimize-jpg/raw/main/optimize-overwrite.bat >NUL 2>&1 && ^
call optimize-overwrite.bat && ^
exit

```
