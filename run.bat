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

REM CALL OVERWRITE SCRIPT
:OW
IF EXIST "%TMP%\ow.bat" (
    CALL "%TMP%\ow.bat" "%~dp0"
    GOTO END
  ) ELSE (
    ECHO WARNING: MISSING FILE "%TMP%\ow.bat"
    ECHO=
    PAUSE
    GOTO END
)

:----------------------------------------------------------------------------------------------

REM CALL DEFAULT OPTIMIZE SCRIPT
:OPT
IF EXIST "%TMP%\opt.bat" (
    CALL "%TMP%\opt.bat" "%~dp0"
    GOTO END
  ) ELSE (
    ECHO WARNING: MISSING FILE "%TMP%\opt.bat"
    ECHO=
    PAUSE
    GOTO END
)

:----------------------------------------------------------------------------------------------

REM DELETE LEFTOVER BATCH FILES ON THE PC
:END
IF EXIST "%TMP%\ow.bat" DEL /Q "%TMP%\ow.bat" >NUL
IF EXIST "%TMP%\opt.bat" DEL /Q "%TMP%\opt.bat" >NUL
REM IF EXIST "run.bat" DEL /Q "run.bat" >NUL
ECHO=
PAUSE
EXIT /B
