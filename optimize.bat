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

REM CREATE TEMP DIRECTORIES FOR CACHE AND OUTPUT FILES
IF NOT EXIST "%TMP%\temp-cache-files\" MD "%TMP%\temp-cache-files\" >NUL
IF NOT EXIST "%CD%\optimized\" MD "%CD%\optimized\" >NUL
IF NOT EXIST "%CD%\originals\" MD "%CD%\originals\" >NUL

:----------------------------------------------------------------------------------

REM MOVE TEMP EXE FILES IF FOUND
IF EXIST "%CD%\convert.exe" MOVE /Y "%CD%\convert.exe" "%TMP%\temp-cache-files\" >NUL
IF EXIST "%CD%\identify.exe" MOVE /Y "%CD%\identify.exe" "%TMP%\temp-cache-files\" >NUL

:----------------------------------------------------------------------------------

REM DELETE FILES FROM PREVIOUS ATTEMPTS OR FAILED ATTEMPTS
IF EXIST "index.html" DEL /Q "index.html" >NUL
IF EXIST "urls.txt" DEL /Q "urls.txt" >NUL
CLS

:----------------------------------------------------------------------------------

REM FIND ALL JPG FILES AND CONVERT THEM TO TEMP CACHE FORMAT
FOR %%G IN (*.jpg) DO (
    FOR /F "TOKENS=1-2" %%H IN ('%TMP%\temp-cache-files\identify.exe +ping -format "%%w %%h" "%%G"') DO (
        ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
        ECHO=
        "%TMP%\temp-cache-files\convert.exe" "%CD%\%%~nxG" -monitor -filter Triangle -define filter:support=2 -thumbnail "%%Hx%%I" -strip ^
        -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off ^
        -auto-level -enhance -interlace none -colorspace sRGB "%TMP%\temp-cache-files\%%~nG.mpc"
        CLS
        IF EXIST "%TMP%\temp-cache-files\%%~nG.mpc" (
            "%TMP%\temp-cache-files\convert.exe" "%TMP%\temp-cache-files\%%~nG.mpc" -monitor "%CD%\optimized\%%~nG.jpg"
            CLS
            IF EXIST "%TMP%\temp-cache-files\%%~nG.cache" DEL /Q "%TMP%\temp-cache-files\%%~nG.cache" >NUL
            IF EXIST "%TMP%\temp-cache-files\%%~nG.mpc" DEL /Q "%TMP%\temp-cache-files\%%~nG.mpc" >NUL
            MOVE /Y "%CD%\%%~nG.jpg" "%CD%\originals\"
            CLS
        )
    )
)

:----------------------------------------------------------------------------------

REM OPEN PARENT FOLDER IN EXPLORER
START "" /MAX "%WINDIR%\explorer.exe" "%CD%\optimized\"

:----------------------------------------------------------------------------------

REM CLEANUP ALL OTHER TEMP FILES AND FOLDERS
IF EXIST "%TMP%\temp-cache-files\" RD /S /Q "%TMP%\temp-cache-files\" >NUL
START "" /I CMD /D /C DEL /Q "optimize.bat"
