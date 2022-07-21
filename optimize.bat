@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
COLOR 0A

:----------------------------------------------------------------------------------

REM IF DEFINED USE THE FIRST PASSED ARGUMENT TO CHANGE THE WORKING DIRECTORY BACK TO THE PARENT FOLDER
IF DEFINED PARENT_DIR (PUSHD "%PARENT_DIR%") ELSE (PUSHD "%~dp0")
IF NOT "%1"=="MAX" START /MAX CMD /D /C %0 MAX & GOTO :EOF

:----------------------------------------------------------------------------------

REM SET THE TITLE OF THE WINDOW
FOR %%A IN (.) DO TITLE %%~nxA

SET CONVERT="imagemagick-optimize-jpg\convert.exe"

:----------------------------------------------------------------------------------

REM SKIP AHEAD IF CACHE FILES ALREADY EXIST OR CREATE THE TEMP DIRECTORY IF NOT EXIST
IF /I EXIST "temp-cache-files\*.mpc" (GOTO CONVERT-CACHE) ELSE (MD temp-cache-files)

:----------------------------------------------------------------------------------

REM CONVERT ALL JPG FILES INTO THEIR TEMPORARY CACHE FORMAT
FOR %%G IN (*.jpg) DO (
    FOR /F "TOKENS=1-2" %%H IN ('identify.exe +ping -format "%%w %%h" "%%G"') DO (
        ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
        ECHO=
        %CONVERT% "%%G" -monitor -filter Triangle -define filter:support=2 -thumbnail %%Hx%%I -strip ^
        -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off ^
        -auto-level -enhance -interlace none -colorspace sRGB "temp-cache-files\%%~nG.mpc"
        CLS
    )
)

:----------------------------------------------------------------------------------

REM CONVERT THE PREVIOUSLY CREATED MPC AND CACHE FILES INTO IT'S OPTIMIZED JPG FORM
:CONVERT-CACHE
FOR %%G IN ("temp-cache-files\*.mpc") DO (
    ECHO Converting: %%~nG.cache ^>^> %%~nG.jpg
    ECHO=
    %CONVERT% "%%G" -monitor "%%~nG.jpg"
    CLS
)

:----------------------------------------------------------------------------------

REM CLEANUP TEMP FILES AND FOLDERS AND OPEN EXPLORER TO THE SCRIPT'S DIRECTORY
START "" /MAX explorer.exe "%CD%"
IF /I EXIST "imagemagick-optimize-jpg" RD /S /Q "imagemagick-optimize-jpg"
IF /I EXIST "temp-cache-files" RD /S /Q "temp-cache-files"
IF /I EXIST %CONVERT% DEL /Q %CONVERT%
START "" /I CMD /D /C IF /I EXIST "optimize.bat" DEL /Q "optimize.bat"
