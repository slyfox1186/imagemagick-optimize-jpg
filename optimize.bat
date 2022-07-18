@echo off
setlocal enableextensions
color 0a

:--------------------------------------------------------------------------------

pushd "%~dp0"
if not "%1"=="max" start /max cmd /d /c %0 max & goto :eof
set myDir=%cd%

:--------------------------------------------------------------------------------

REM RUN OPTIMIZE SCRIPT ON ALL JPG FILES IN THE SCRIPTS DIRECTORY
git.exe clone "https://github.com/slyfox1186/imagemagick-optimize-jpg.git"
pushd "imagemagick-optimize-jpg/scripts"
move /y "run.bat" "%myDir%"
popd
rd /s /q "imagemagick-optimize-jpg"
start "" /b call "run.bat"
exit
