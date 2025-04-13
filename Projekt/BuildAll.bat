@echo off
echo Build start...

rem Wersja debug:
rem make BUILD=debug RUN=false

rem Wersja release:
rem make BUILD=release RUN=false

rem Z uruchomieniem:
make BUILD=debug RUN=true

pause
