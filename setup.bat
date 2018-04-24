@echo off

:: pip
if not exist %APPDATA%\\pip (
    mkdir %APPDATA%\\pip
)
cp -f config\\pip\\pip.conf %APPDATA%\\pip\\pip.ini

:: ssh
if not exist %userprofile%\\.ssh (
    mkdir %userprofile%\\.ssh
)
cp -f ssh\\config %userprofile%\\.ssh\\config
