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

REM SET CONVERT.EXE'S PATH (YOU MUST POINT THIS AT YOUR CONVERT.EXE FILE PATH)
REM SET CONVERT="%ProgramFiles%\ImageMagick\convert.exe"
SET CONVERT=%CD%\convert.exe
SET CONVERT_DL="https://github.com/slyfox1186/imagemagick-optimize-jpg/raw/main/convert.exe"

:----------------------------------------------------------------------------------

REM SKIP TO CONVERT IF CACHE FILES ALREADY EXIST AND MAKE TEMP DIRECTORY
IF EXIST "IMagick_Cache_Files\*.mpc" (GOTO CONVERT) ELSE (MD "IMagick_Cache_Files")

:----------------------------------------------------------------------------------

REM FIND ALL JPG FILES AND CONVERT THEM TO TEMPORARY CACHE FORMAT
SETLOCAL ENABLEEXTENSIONS
FOR %%G IN (*.jpg) DO (
    FOR /F "TOKENS=1-2" %%H IN ('identify.exe +ping -format "%%w %%h" "%%G"') DO (
        ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
        ECHO=
        curl.exe %CONVERT_DL% > "convert.exe"
        powershell.exe -NoL -NoP -W Maximized -Exe Bypass -C "& {Start-Process -FilePath '%CONVERT%' -ArgumentList '-monitor -filter Triangle -define filter:support=2 -thumbnail '%%Hx%%I' -strip -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -auto-level -enhance -interlace none -colorspace sRGB 'IMagick_Cache_Files\%%~nG.mpc''}"
        CLS
    )
)

:----------------------------------------------------------------------------------

REM CONVERT CACHE FILES INTO JPG
:CONVERT
SETLOCAL ENABLEEXTENSIONS
FOR %%G IN ("IMagick_Cache_Files\*.mpc") DO (
    ECHO Converting: %%~nG.cache ^>^> %%~nG.jpg
    ECHO=
    curl.exe %CONVERT_DL% > "convert.exe"
    powershell.exe -NoL -NoP -W Maximized -Exe Bypass -C "& {Start-Process -FilePath '%CONVERT%' -ArgumentList ''%%G' -monitor '%%~nG.jpg''}"
    CLS
    )
)

:----------------------------------------------------------------------------------

REM CLEANUP TEMP FILES+FOLDERS
IF EXIST "IMagick_Cache_Files" RD /S /Q "IMagick_Cache_Files"
IF EXIST "convert.exe" DEL /Q "convert.exe"
START "" "%CD%"
START "" /I CMD /D /C DEL /Q "Optimize.bat"
