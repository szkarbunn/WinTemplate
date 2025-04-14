@echo off
setlocal

REM === Configuration ===
set "SRC_DIR=wxWidgetSrc"
set "DST_INCLUDE=include"
set "DST_LIB=lib"
set "DST_DLL=dll"

REM === Clean destination folders if they exist ===
echo Checking and cleaning destination folders...

if exist "%DST_INCLUDE%" (
    echo Removing %DST_INCLUDE%...
    rmdir /s /q "%DST_INCLUDE%"
)
if exist "%DST_LIB%" (
    echo Removing %DST_LIB%...
    rmdir /s /q "%DST_LIB%"
)
if exist "%DST_DLL%" (
    echo Removing %DST_DLL%...
    rmdir /s /q "%DST_DLL%"
)

REM === Recreate folders ===
mkdir "%DST_INCLUDE%"
mkdir "%DST_LIB%"
mkdir "%DST_DLL%"

REM === Copy entire include directory ===
echo Copying include folder...
xcopy /y /e /i "%SRC_DIR%\include" "%DST_INCLUDE%\" >nul

REM === Copy entire gcc_lib directory ===
echo Copying full gcc_lib to lib folder...
xcopy /y /e /i "%SRC_DIR%\lib\gcc_lib" "%DST_LIB%\gcc_lib" >nul

REM === Copy entire gcc_dll directory ===
echo Copying full gcc_dll to dll folder...
xcopy /y /e /i "%SRC_DIR%\lib\gcc_dll" "%DST_DLL%\gcc_dll" >nul

echo === DONE: All folders copied from %SRC_DIR% ===
pause
endlocal
