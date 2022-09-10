@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
PROMPT $G
COLOR 0A

:----------------------------------------------------------------------------------------------

REM REMOVE MISC FILES OF NO USE
IF EXIST "index.html" DEL /Q "index.html"
IF EXIST "urls.txt" DEL /Q "urls.txt"

:----------------------------------------------------------------------------------------------

REM MOVE FILES TO TMP DIRECTORY
IF EXIST "opt.bat" MOVE /Y "opt.bat" "%TMP%\opt.bat"
IF EXIST "ow.bat" MOVE /Y "ow.bat" "%TMP%\ow.bat"

:----------------------------------------------------------------------------------------------

REM PROMPT USER WITH CHOICES
ECHO CHOOSE A PATH FORWARD: & ECHO=
ECHO [1]  OPTIMIZE ^(ORIGINAL FILE SAFE^)
ECHO [2]  OPTIMIZE ^+ OVERWRITE ^(BEWARE OF LOSING YOUR ORIGINAL FILES^!^)
ECHO [3]  GOTO EXIT & ECHO=

CHOICE /C 123 /N & CLS

IF ERRORLEVEL 3 GOTO :EOF
IF ERRORLEVEL 2 GOTO OW
IF ERRORLEVEL 1 GOTO OPT

:----------------------------------------------------------------------------------------------

:OW
IF EXIST "%TMP%\ow.bat" (
    CALL "%TMP%\ow.bat" "%~dp0"
    GOTO :EOF
  ) ELSE (
    ECHO WARNING: MISSING FILE "%TMP%\ow.bat"
    ECHO=
    PAUSE
    GOTO :EOF
)


:----------------------------------------------------------------------------------------------

:OPT
IF EXIST "%TMP%\opt.bat" (
    CALL "%TMP%\opt.bat" "%~dp0"
    GOTO :EOF
  ) ELSE (
    ECHO WARNING: MISSING FILE "%TMP%\opt.bat"
    ECHO=
    PAUSE
    GOTO :EOF
)
