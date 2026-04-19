@echo off
title LTCOE Campus Server
echo --------------------------------------------------
echo   LTCOE Campus — Starting Local Server...
echo --------------------------------------------------
echo.

:: Move to the project directory (where this .bat file is)
cd /d "%~dp0"

:: Check if Python is installed
where py >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python (py) was not found! 
    echo Please install Python from https://www.python.org/
    pause
    exit /b
)

:: Run the application
py app.py

echo.
echo --------------------------------------------------
echo   Server has stopped.
echo --------------------------------------------------
pause
