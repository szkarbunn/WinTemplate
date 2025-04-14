@echo off
setlocal

REM === Configuration ===
set "MAKEFILE_DIR=wxWidgetSrc\build\msw"
set "MAKE_TOOL=mingw32-make"
set "LOG_FILE=Build_Static_Raport.log"

REM === Clear log file ===
echo. > %LOG_FILE%
echo Build started: %DATE% %TIME% >> %LOG_FILE%

REM === Define common flags ===
set "COMMON_FLAGS=SHELL=CMD.exe -j12 SHARED=0 UNICODE=1 MONOLITHIC=0"

REM === DEBUG CLEAN ===
echo ========================================== | tee -a %LOG_FILE%
echo MODE: DEBUG CLEAN                         | tee -a %LOG_FILE%
echo ========================================== | tee -a %LOG_FILE%
call %MAKE_TOOL% -C %MAKEFILE_DIR% -f makefile.gcc %COMMON_FLAGS% BUILD=debug clean | tee -a %LOG_FILE%

REM === DEBUG SETUP HEADERS ===
echo ========================================== | tee -a %LOG_FILE%
echo MODE: DEBUG SETUP                         | tee -a %LOG_FILE%
echo ========================================== | tee -a %LOG_FILE%
call %MAKE_TOOL% -C %MAKEFILE_DIR% -f makefile.gcc %COMMON_FLAGS% BUILD=debug setup_h | tee -a %LOG_FILE%

REM === DEBUG COMPILE ===
echo ========================================== | tee -a %LOG_FILE%
echo MODE: DEBUG COMPILE                       | tee -a %LOG_FILE%
echo ========================================== | tee -a %LOG_FILE%
%MAKE_TOOL% -C %MAKEFILE_DIR% -f makefile.gcc %COMMON_FLAGS% BUILD=debug | tee -a %LOG_FILE%

REM === RELEASE CLEAN ===
echo ========================================== | tee -a %LOG_FILE%
echo MODE: RELEASE CLEAN                       | tee -a %LOG_FILE%
echo ========================================== | tee -a %LOG_FILE%
call %MAKE_TOOL% -C %MAKEFILE_DIR% -f makefile.gcc %COMMON_FLAGS% BUILD=release clean | tee -a %LOG_FILE%

REM === RELEASE SETUP HEADERS ===
echo ========================================== | tee -a %LOG_FILE%
echo MODE: RELEASE SETUP                       | tee -a %LOG_FILE%
echo ========================================== | tee -a %LOG_FILE%
call %MAKE_TOOL% -C %MAKEFILE_DIR% -f makefile.gcc %COMMON_FLAGS% BUILD=release setup_h | tee -a %LOG_FILE%

REM === RELEASE COMPILE ===
echo ========================================== | tee -a %LOG_FILE%
echo MODE: RELEASE COMPILE                     | tee -a %LOG_FILE%
echo ========================================== | tee -a %LOG_FILE%
%MAKE_TOOL% -C %MAKEFILE_DIR% -f makefile.gcc %COMMON_FLAGS% BUILD=release | tee -a %LOG_FILE%

echo === BUILD COMPLETED ===
pause
endlocal
