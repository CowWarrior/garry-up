@echo off
echo "Copying XML files..."
copy .\*.xml %WOWADDON%\GarryUp /Y
echo "Copying LUA files..."
copy .\*.lua %WOWADDON%\GarryUp /Y
echo "Copying TOC file..."
copy .\*.lua %WOWADDON%\GarryUp /Y
pause