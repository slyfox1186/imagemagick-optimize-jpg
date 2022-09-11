@ECHO OFF
COLOR 0A

:----------------------------------------------------------------------------------

REM CHANGE DIRECTORY TO THE CALLER SCRIPT'S DIRECTORY "run.bat"
PUSHD "%1"

:----------------------------------------------------------------------------------

REM SET THE TITLE OF THE WINDOW
FOR %%A IN (.) DO TITLE Optimize jpg images: %%~fA

:----------------------------------------------------------------------------------

REM FIND IMAGEMAGICK'S CONVERT.EXE FILE AND SET A VARIABLE TO POINT TO IT'S FULL PATH
FOR /F "USEBACKQ TOKENS=*" %%A IN (`WHERE convert.exe ^| FINDSTR /I /R ".*ImageMagick.*convert.exe$"`) DO SET "CONVERT="%%A""
FOR /F "USEBACKQ TOKENS=*" %%A IN (`WHERE identify.exe ^| FINDSTR /I /R ".*ImageMagick.*identify.exe$"`) DO SET "IDENTIFY=""%%A^""

:----------------------------------------------------------------------------------

REM CREATE FILES IN WINDOWS' TEMP DIRECTORY: "%TMP%"
IF NOT EXIST "%TMP%\jpg-cache\" MD "%TMP%\jpg-cache\" 2>NUL
IF NOT EXIST "optimized\" MD "optimized\" 2>NUL

:----------------------------------------------------------------------------------

REM FIND ALL JPG FILES AND CONVERT THEM TO TEMP CACHE FORMAT THEN COMBINE THE FILES AND OUTPUT THE OPTIMIZED IMAGES
FOR %%G IN (*.jpg) DO (
    FOR /F "TOKENS=1-2" %%H IN ('%IDENTIFY% +ping -format "%%w %%h" "%%G"') DO (
        CLS & ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
        ECHO=
        %CONVERT% "%%~nxG" -monitor -filter Triangle -define filter:support=2 -thumbnail "%%Hx%%I" -strip ^
        -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off ^
        -auto-level -enhance -interlace none -colorspace sRGB "%TMP%\jpg-cache\%%~nG.mpc" & CLS
        IF EXIST "%TMP%\jpg-cache\%%~nG.mpc" (
            %CONVERT% "%TMP%\jpg-cache\%%~nG.mpc" -monitor "optimized\%%~nG.jpg" & CLS
            DEL /Q "%TMP%\jpg-cache\%%~nG.cache" "%TMP%\jpg-cache\%%~nG.mpc"
        )
    )
)

:----------------------------------------------------------------------------------

REM OPEN PARENT FOLDER IN EXPLORER
START "" /MAX "%WINDIR%\explorer.exe" "%CD%\"
EXIT /B
