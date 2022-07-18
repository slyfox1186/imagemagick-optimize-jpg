@echo off
setlocal enableextensions
color 0a

:--------------------------------------------------------------------------------

pushd "%~dp0"
if not "%1"=="max" start /max cmd /d /c %0 max & goto :eof
set myDir=%cd%

:--------------------------------------------------------------------------------

REM RUN OPTIMIZE SCRIPT ON ALL JPG FILES IN THE SCRIPTS DIRECTORY
git.exe clone "https://github.com/slyfox1186/imagemagick-large-file-optimize.git"
pushd "imagemagick-large-file-optimize"
move /y "optimize.bat" "%myDir%"
popd
rd /s /q "imagemagick-large-file-optimize"
call "optimize.bat"
