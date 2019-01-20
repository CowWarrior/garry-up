@echo off
echo Copying XML files...
echo Target: "%WOWADDON%\GarryUp"
copy .\*.xml "%WOWADDON%\GarryUp" /Y
echo "Copying LUA files..."
copy .\*.lua "%WOWADDON%\GarryUp" /Y
echo "Copying TOC file..."
copy .\*.toc "%WOWADDON%\GarryUp" /Y
pause