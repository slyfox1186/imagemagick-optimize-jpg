@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
COLOR 0A

:----------------------------------------------------------------------------------

REM CHANGE DIRECTORY TO THE SCRIPTS DIRECTORY AND OPEN CMD IN MAXIMIZED WINDOW
PUSHD "%~dp0"
IF NOT "%1"=="MAX" START /MAX CMD /D /C %0 MAX & GOTO :EOF

:----------------------------------------------------------------------------------

REM SET THE TITLE OF THE WINDOW
FOR %%A IN (.) DO TITLE Optimize jpg images: %%~fA

:----------------------------------------------------------------------------------

REM DELETE FILES FROM ANY PRIOR FAILED ATTEMPTS
IF EXIST "index.html" DEL /Q "index.html" >NUL

:----------------------------------------------------------------------------------

REM CREATE AND MOVE FILES IN WINDOWS' TEMP DIRECTORY: "%TMP%"
REM CREATE THE DIRECTORIES FOR THE CACHE, INPUT, AND OUTPUT FILES
IF NOT EXIST "%TMP%\jpg-cache\" MD "%TMP%\jpg-cache\" >NUL
IF NOT EXIST "%CD%\optimized\" MD "%CD%\optimized\" >NUL

:----------------------------------------------------------------------------------

REM FIND ALL JPG FILES AND CONVERT THEM TO TEMP CACHE FORMAT THEN COMBINE THE FILES AND OUTPUT THE OPTIMIZED IMAGES
REM THIS WILL DELETE THE ORIGIAL FILE AND STORE THE OPTIMIZED IMAGE IN THE FOLDER "OPTIMIZED"
FOR %%G IN (*.jpg) DO (
    FOR /F "TOKENS=1-2" %%H IN ('identify.exe +ping -format "%%w %%h" "%%G"') DO (
        CLS & ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
        ECHO=
        convert.exe "%CD%\%%~nxG" -monitor -filter Triangle -define filter:support=2 -thumbnail "%%Hx%%I" -strip ^
        -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off ^
        -auto-level -enhance -interlace none -colorspace sRGB "%TMP%\jpg-cache\%%~nG.mpc" & CLS
        IF EXIST "%TMP%\jpg-cache\%%~nG.mpc" (
            convert.exe "%TMP%\jpg-cache\%%~nG.mpc" -monitor "%CD%\optimized\%%~nG.jpg" & CLS
            DEL /Q "%TMP%\jpg-cache\%%~nG.cache" "%TMP%\jpg-cache\%%~nG.mpc" "%CD%\%%~nG.jpg"
        )
    )
)

:----------------------------------------------------------------------------------

REM OPEN PARENT FOLDER IN EXPLORER
START "" /MAX "%WINDIR%\explorer.exe" "%CD%\"

:----------------------------------------------------------------------------------

REM CLEANUP ALL TEMP FILES AND DIRECTORIES
START "" /I CMD /D /C DEL /Q "opt.bat" >NUL
