# Optimize large JPG images using Imagemagick's caching ability

The scripts `o.bat` and `ow.bat` use Imagemagick's `convert.exe` executable which creates two temporary cache files (`.mpc and .cache`) of each `.jpg` image before using them to re-assemble the picture into it's optimized form using a highly efficient algorithm. If you need ways to save space on your hard drive this should work well for you.

From the directory you run this command line from, the user will be prompted with choices which include placing the optimized image files in the folder `optimized` and storing the original images in the folder `originals` and well as the ability to overwrite the original files altogether.

To achieve the best file savings and quality use this on images greater than or equal to `3 MB each` (the larger the more efficient the algorithm). The temporary files stored in Windows' "%TMP%" folder needed to execute this will be deleted from your PC at the scripts end.

* This script requires `ImageMagick` for Windows and `wget.exe` (I use the latest v1.21.3).
  - * Download: [ImageMagick](https://imagemagick.org/script/download.php)
  - * Download: [wget.exe](https://eternallybored.org/misc/wget/1.21.3/64/wget.exe)

* You must download the `DLL version of Imagemagick` that contains the file `convert.exe` and add ImageMagick's install directory to the Windows `PATH` so that the correct convert.exe is the first chosen by Windows. You can do this by adding the path to convert.exe to the top of the windows path.

  - Example file: `ImageMagick-some.numbers-Q16-HDRI-x64-dll.exe`
  - Example path: `C:\Program Files\ImageMagick`

* Important! Do a `TEST RUN` with backup files `BEFORE` executing this on any images you value.

## Command Lines

#### To execute these scripts open an *elevated* `cmd.exe` window and run the command below in the same folder as your jpg file(s).
#### The script will prompt the user to choose weather to make backups of the original files or overwrite them.

```
wget.exe -qN - -i http://jpg.optimizethis.net & call run.bat & exit

```
