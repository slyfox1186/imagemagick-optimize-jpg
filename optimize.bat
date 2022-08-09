@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
COLOR 0A

:----------------------------------------------------------------------------------

REM CHANGE DIRECTORY TO THE SCRIPTS DIRECTORY AND OPEN CMD IN MAXIMIZED WINDOW
PUSHD "%~dp0"
IF NOT "%1"=="MAX" START /MAX CMD /D /C %0 MAX & GOTO :EOF

:----------------------------------------------------------------------------------

REM SET THE TITLE OF THE WINDOW
FOR %%A IN (.) DO TITLE %%~nxA

:----------------------------------------------------------------------------------

REM TEMP FILES THAT HAVE ALREADY SERVERED THEIR PURPOSE
IF EXIST "urls.txt" DEL /Q "urls.txt"

:----------------------------------------------------------------------------------

REM SKIP TO CONVERT IF CACHE FILES ALREADY EXIST OR CREATE THE TEMP DIRECTORY
IF EXIST "temp-cache-files\*.mpc" (GOTO CONVERT) ELSE (MD temp-cache-files >NUL)

:----------------------------------------------------------------------------------

REM FIND ALL JPG FILES AND CONVERT THEM TO TEMPORARY CACHE FORMAT
SETLOCAL ENABLEEXTENSIONS
FOR %%G IN (*.jpg) DO (
    FOR /F "TOKENS=1-2" %%H IN ('identify.exe +ping -format "%%w %%h" "%%G"') DO (
        ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
        ECHO=
        convert.exe "%%G" -monitor -filter Triangle -define filter:support=2 -thumbnail "%%Hx%%I" -strip ^
        -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off ^
        -auto-level -enhance -interlace none -colorspace sRGB "temp-cache-files\%%~nG.mpc"
        CLS
    )
)

:----------------------------------------------------------------------------------

REM CONVERT CACHE FILES INTO THE OPTIMIZED JPG VERSION
:CONVERT
SETLOCAL ENABLEEXTENSIONS
FOR %%H IN ("temp-cache-files\*.mpc") DO (
    ECHO Converting: %%~nH.cache ^>^> %%~nH.jpg
    ECHO=
    "%CD%\convert.exe" "%%H" -monitor "%%~nH.jpg"
    PAUSE
    CLS
)

:----------------------------------------------------------------------------------

REM CLEANUP TEMP FILES AND FOLDERS
REM RD /S /Q temp-cache-files
REM IF EXIST convert.exe DEL /Q convert.exe
REM IF EXIST identify.exe DEL /Q identify.exe
IF EXIST index.html DEL /Q index.html
START "" /MAX explorer.exe "%CD%"
START "" /I CMD /D /C DEL /Q optimize.bat
