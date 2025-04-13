@echo off
setlocal

set CPPCHECK="cppcheck"
set SRC_DIR=code
set REPORT_FILE=bin\cppcheck_report.txt

echo.
echo ==========================================
echo Running cppcheck on %SRC_DIR%...
echo ==========================================
echo.

:: Create bin folder if it doesn't exist
if not exist bin (
    mkdir bin
)

:: Run cppcheck with full analysis
%CPPCHECK% --enable=all --inconclusive --std=c++17 --force ^
--inline-suppr --quiet ^
--output-file=%REPORT_FILE% %SRC_DIR%

echo.
echo ==========================================
echo cppcheck finished.
echo Report saved to %REPORT_FILE%
echo ==========================================
echo.

pause
endlocal
