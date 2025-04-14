@echo off
setlocal

REM === Configuration ===
set "SRC_DIR=wxWidgetSrc"
set "REPO=https://github.com/wxWidgets/wxWidgets.git"

IF EXIST "%SRC_DIR%" (
    echo Folder "%SRC_DIR%" already exists. Exit.
    pause
    endlocal
    exit /b
)

rem git clone --depth 1 %REPO% %SRC_DIR%
git clone --recurse-submodules --depth 1 %REPO% %SRC_DIR%

IF ERRORLEVEL 1 (
    echo Git clone failed.
) else (
    echo WxWidgets downloaded successfully.
)

pause
endlocal
