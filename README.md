# Optimize large JPG images using Imagemagick's caching ability

The scripts `optimize.bat` and `optimize-overwrite.bat` use Imagemagick's `convert.exe` executable which creates two temporary cache files (`.mpc and .cache`) of each `.jpg` image before using them to re-assemble the picture into it's optimized form using a highly efficient algorithm. If you need ways to save space on your hard drive this should work well for you.

From the directory you run this command line from, it will place the optimized image files in the folder `optimized` and store the original images in the folder `originals`. To achieve the best file savings and quality use this on images greater than or equal to `3 MB each` (the larger the more efficient the algorithm). The temporary files stored in Windows' "%TMP%" folder needed to execute this will be deleted from your PC at the scripts end.

* This script requires `ImageMagick` for Windows and `wget.exe` (I use the latest v1.21.3).
  - * Download: [ImageMagick](https://imagemagick.org/script/download.php)
  - * Download: [wget.exe](https://eternallybored.org/misc/wget/1.21.3/64/wget.exe)

* You must download the `DLL` version that contains the file `convert.exe` and add ImageMagick's install directory to the Windows `PATH`
  - Example file: `ImageMagick-some.numbers-Q16-HDRI-x64-dll.exe`
  - Example path: `C:\Program Files\ImageMagick`

* Important! Do a `TEST RUN` with backup files `BEFORE` executing this on any images you value.

## Command Lines

#### To execute this open an `elevated cmd.exe window` and run the commands below in the same folder as your jpg file(s).

```
wget.exe -qN https://github.com/slyfox1186/imagemagick-optimize-jpg/raw/main/optimize.bat >NUL 2>&1 & call optimize.bat & exit

```
#### The below command will overwrite the original files. Beware!
```
wget.exe -qN https://github.com/slyfox1186/imagemagick-optimize-jpg/raw/main/optimize-overwrite.bat >NUL 2>&1 & call optimize-overwrite.bat & exit

```
