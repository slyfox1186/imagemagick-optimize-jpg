@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
COLOR 0A

PUSHD "%~dp0"

wget.exe -c -O "convert.exe" "https://github.com/slyfox1186/imagemagick-optimize-jpg/blob/main/convert.exe?raw=true" && ^
curl.exe "https://raw.githubusercontent.com/slyfox1186/imagemagick-optimize-jpg/main/optimize.bat" > "optimize.bat" && ^
call "optimize.bat" & ^
exit
