@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
COLOR 0A

:----------------------------------------------------------------------------------------------

REM MOVE FILES TO TMP DIRECTORY
IF EXIST "opt.bat" MOVE /Y "opt.bat" "%TMP%\opt.bat"
IF EXIST "ow.bat" MOVE /Y "ow.bat" "%TMP%\ow.bat"

:----------------------------------------------------------------------------------------------

CLS
ECHO CHOOSE A PATH FORWARD: & ECHO=
ECHO [1]  OPTIMIZE ^(ORIGINAL FILE SAFE^)
ECHO [2]  OPTIMIZE ^+ OVERWRITE ^(BEWARE OF LOSING YOUR ORIGINALS^!^)
ECHO [3]  GOTO EXIT & ECHO=

CHOICE /C 123 /N & CLS

IF ERRORLEVEL 3 GOTO :EOF
IF ERRORLEVEL 2 GOTO OW
IF ERRORLEVEL 1 GOTO OPT

:----------------------------------------------------------------------------------------------

:OW
IF EXIST "%TMP%\ow.bat" (
    CALL "%TMP%\ow.bat"
    DEL /Q "%TMP%\ow.bat"
    GOTO :EOF
)


:----------------------------------------------------------------------------------------------

:OPT
IF EXIST "%TMP%\opt.bat" (
    CALL "%TMP%\opt.bat"
    DEL /Q "%TMP%\opt.bat"
    GOTO :EOF
)
