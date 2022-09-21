@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
COLOR 0A

:----------------------------------------------------------------------------------------------

REM REMOVE MISC FILES OF NO USE
IF EXIST "index.html" DEL /Q "index.html" >NUL
IF EXIST "urls.txt" DEL /Q "urls.txt" >NUL

:----------------------------------------------------------------------------------------------

REM MOVE FILES TO TMP DIRECTORY
IF EXIST "o.bat" MOVE /Y "o.bat" "%TMP%\o.bat" >NUL
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
IF ERRORLEVEL 1 GOTO O

:----------------------------------------------------------------------------------------------

REM CALL OVERWRITE SCRIPT
:OW
IF EXIST "%TMP%\ow.bat" (
    CALL "%TMP%\ow.bat" "%~dp0" "%~nx0"
    GOTO END
  ) ELSE (
    ECHO Warning Missing File: "%TMP%\ow.bat"
    GOTO END
)

:----------------------------------------------------------------------------------------------

REM CALL DEFAULT OPTIMIZE SCRIPT
:O
IF EXIST "%TMP%\o.bat" (
    CALL "%TMP%\o.bat" "%~dp0"
    GOTO END
  ) ELSE (
    ECHO Warning Missing File: "%TMP%\o.bat"
    GOTO END
)

:----------------------------------------------------------------------------------------------

REM DELETE LEFTOVER BATCH FILES ON THE PC
:END
ECHO=
PAUSE
IF EXIST "*.bat" DEL /Q "*.bat"
