@echo off
echo =====================================
echo Cleaning ALL build artifacts...
echo =====================================

REM Delete build and bin directories
rmdir /S /Q build 2>nul
rmdir /S /Q bin 2>nul

REM Clean using make for both configurations
echo.
echo --- make clean [debug]
make clean BUILD=debug

echo.
echo --- make clean [release]
make clean BUILD=release

echo.
echo Done.
pause
