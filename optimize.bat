@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
COLOR 0A

:----------------------------------------------------------------------------------

REM CHANGE DIRECTORY TO THE SCRIPTS DIRECTORY AND OPEN CMD IN MAXIMIZED WINDOW
PUSHD "%~dp0"
IF NOT "%1"=="MAX" START /MAX CMD /D /C %0 MAX & GOTO :EOF

:----------------------------------------------------------------------------------

REM SET THE TITLE OF THE WINDOW
FOR %%A IN (.) DO TITLE %%nxA

:----------------------------------------------------------------------------------

REM SET CONVERT.EXE'S PATH (YOU MUST POINT THIS AT YOUR CONVERT.EXE FILE PATH)
SET CONVERT="%ProgramFiles%\ImageMagick\convert.exe"

:----------------------------------------------------------------------------------

REM SKIP TO CONVERT IF CACHE FILES ALREADY EXIST
IF EXIST "%CD%\IMagick_Cache_Files\*.mpc" GOTO CONVERT

:----------------------------------------------------------------------------------

REM CREATE TEMP FOLDERS
IF NOT EXIST "%CD%\IMagick_Cache_Files" MD "%CD%\IMagick_Cache_Files"

:----------------------------------------------------------------------------------

REM FIND ALL JPG FILES AND CONVERT THEM TO TEMPORARY CACHE FORMAT
SETLOCAL ENABLEEXTENSIONS
FOR %%G IN (*.jpg) DO (
	FOR /F "TOKENS=1-2" %%H IN ('identify.exe +ping -format "%%w %%h" "%%G"') DO (
		ECHO Creating: %%~nG.mpc ^+ %%~nG.cache
		ECHO=
		%CONVERT% "%%G" -monitor -filter Triangle -define filter:support=2 -thumbnail "%%Hx%%I" -strip ^
		-unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off ^
		-auto-level -enhance -interlace none -colorspace sRGB "%CD%\IMagick_Cache_Files\%%~nG.mpc"
		CLS
	)
)

:----------------------------------------------------------------------------------

REM CONVERT CACHE FILES INTO JPG
:CONVERT
SETLOCAL ENABLEEXTENSIONS
FOR %%G IN ("%CD%\IMagick_Cache_Files\*.mpc") DO (
	ECHO Converting: %%~nG.cache ^>^> "%CD%\%%~nG.jpg"
	ECHO=
	%CONVERT% "%%G" -monitor "%CD%\%%~nG.jpg"
	CLS
	)
)

:----------------------------------------------------------------------------------

REM CLEANUP TEMP FILES+FOLDERS
RD /S /Q "%CD%\IMagick_Cache_Files"
START "" "%CD%"
