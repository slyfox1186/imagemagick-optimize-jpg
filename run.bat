@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
PROMPT $G
COLOR 0A

:----------------------------------------------------------------------------------------------

REM REMOVE MISC FILES OF NO USE
IF EXIST "index.html" DEL /Q "index.html" >NUL
IF EXIST "urls.txt" DEL /Q "urls.txt" >NUL

:----------------------------------------------------------------------------------------------

REM MOVE FILES TO TMP DIRECTORY
IF EXIST "opt.bat" MOVE /Y "opt.bat" "%TMP%\opt.bat" >NUL
IF EXIST "ow.bat" MOVE /Y "ow.bat" "%TMP%\ow.bat" >NUL

:----------------------------------------------------------------------------------------------

REM PROMPT USER WITH CHOICES
CLS
ECHO CHOOSE A PATH FORWARD: & ECHO=
ECHO [1]  OPTIMIZE ^(SAFE FOR ORIGINAL FILES^)
ECHO [2]  OPTIMIZE^+OVERWRITE ^(DANGER: OVERWRITES ORIGINAL FILES^!^)
ECHO [3]  GOTO EXIT & ECHO=

CHOICE /C 123 /N & CLS

IF ERRORLEVEL 3 EXIT /B
IF ERRORLEVEL 2 GOTO OW
IF ERRORLEVEL 1 GOTO OPT

:----------------------------------------------------------------------------------------------

:OW
IF EXIST "%TMP%\ow.bat" (
    CALL "%TMP%\ow.bat" "%~dp0"
    EXIT /B
  ) ELSE (
    ECHO WARNING: MISSING FILE "%TMP%\ow.bat"
    ECHO=
    PAUSE
    EXIT /B
)


:----------------------------------------------------------------------------------------------

:OPT
IF EXIST "%TMP%\opt.bat" (
    CALL "%TMP%\opt.bat" "%~dp0"
    EXIT /B
  ) ELSE (
    ECHO WARNING: MISSING FILE "%TMP%\opt.bat"
    ECHO=
    PAUSE
    EXIT /B
)
