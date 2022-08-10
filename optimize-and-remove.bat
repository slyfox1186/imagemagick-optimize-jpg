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
TIMEOUT /NOBREAK 1 >NUL

:----------------------------------------------------------------------------------

REM CREATE AND MOVE FILES IN WINDOWS' TEMP DIRECTORY: "%TMP%"
REM CREATE THE DIRECTORIES FOR THE CACHE, INPUT, AND OUTPUT FILES
IF NOT EXIST "%TMP%\jpg-cache\" MD "%TMP%\jpg-cache\" >NUL
IF NOT EXIST "%CD%\optimized\" MD "%CD%\optimized\" >NUL

REM MOVE EXE FILES AS WELL
IF EXIST "%CD%\convert.exe" MOVE /Y "%CD%\convert.exe" "%TMP%\jpg-cache\" >NUL
IF EXIST "%CD%\identify.exe" MOVE /Y "%CD%\identify.exe" "%TMP%\jpg-cache\" >NUL

:----------------------------------------------------------------------------------

REM DELETE FILES FROM ANY PRIOR FAILED ATTEMPTS
IF EXIST "index.html" DEL /Q "index.html" >NUL
IF EXIST "%TMP%\jpg-cache\convert.exe" IF EXIST "%CD%\convert.exe" DEL /Q "%CD%\convert.exe"
IF EXIST "%TMP%\jpg-cache\identify.exe" IF EXIST "%CD%\identify.exe" DEL /Q "%CD%\identify.exe"

:----------------------------------------------------------------------------------

REM FIND ALL JPG FILES AND CONVERT THEM TO TEMP CACHE FORMAT THEN COMBINE THE FILES AND OUTPUT THE OPTIMIZED IMAGES
FOR %%G IN (*.jpg) DO (
    FOR /F "TOKENS=1-2" %%H IN ('%TMP%\jpg-cache\identify.exe +ping -format "%%w %%h" "%%G"') DO (
        CLS & ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
        ECHO=
        "%TMP%\jpg-cache\convert.exe" "%CD%\%%~nxG" -monitor -filter Triangle -define filter:support=2 -thumbnail "%%Hx%%I" -strip ^
        -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off ^
        -auto-level -enhance -interlace none -colorspace sRGB "%TMP%\jpg-cache\%%~nG.mpc" & CLS
        IF EXIST "%TMP%\jpg-cache\%%~nG.mpc" (
            "%TMP%\jpg-cache\convert.exe" "%TMP%\jpg-cache\%%~nG.mpc" -monitor "%CD%\optimized\%%~nG.jpg" & CLS
            DEL /Q "%TMP%\jpg-cache\%%~nG.cache" >NUL
            DEL /Q "%TMP%\jpg-cache\%%~nG.mpc" >NUL
            DEL /Q "%CD%\%%~nG.jpg" >NUL
        )
    )
)

:----------------------------------------------------------------------------------

REM OPEN PARENT FOLDER IN EXPLORER
START "" /MAX "%WINDIR%\explorer.exe" "%CD%\"

:----------------------------------------------------------------------------------

REM CLEANUP ALL TEMP FILES AND DIRECTORIES
IF EXIST "%CD%\convert.exe" DEL /Q "%CD%\convert.exe" >NUL
IF EXIST "%CD%\identify.exe" DEL /Q "%CD%\identify.exe" >NUL
START "" /I CMD /D /C DEL /Q "optimize-and-remove.bat" >NUL
