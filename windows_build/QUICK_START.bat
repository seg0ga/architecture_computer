@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: GAME LIBRARY - Single File Launcher with Auto-Setup
:: Just double-click this file to run the application!
:: ============================================================

title Game Library - Launcher
color 0A

echo.
echo ╔════════════════════════════════════════╗
echo ║        GAME LIBRARY - Launcher         ║
echo ╚════════════════════════════════════════╝
echo.

:: Check Python installation
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ╔════════════════════════════════════════╗
    echo ║          PYTHON NOT FOUND!             ║
    echo ╚════════════════════════════════════════╝
    echo.
    echo Please install Python 3.8+ from:
    echo https://www.python.org/downloads/
    echo.
    echo IMPORTANT: Check "Add Python to PATH" during install!
    echo.
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version') do set PYTHON_VERSION=%%i
echo [✓] Python %PYTHON_VERSION% found
echo.

:: Create/activate venv
if not exist "venv\" (
    echo → Creating virtual environment...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo [✗] Failed to create venv
        pause
        exit /b 1
    )
    echo [✓] Virtual environment created
)

call venv\Scripts\activate.bat

:: Install dependencies if needed
if not exist "venv\.setup_complete" (
    echo.
    echo → Installing dependencies (first run only)...
    pip install -q -r requirements.txt
    if %errorlevel% neq 0 (
        echo.
        echo [✗] Failed to install dependencies
        echo.
        echo Try manual install:
        echo   pip install -r requirements.txt
        pause
        exit /b 1
    )
    
    :: Mark as setup complete
    echo. > venv\.setup_complete
    echo [✓] Dependencies installed
) else (
    echo [✓] Dependencies already installed
)

echo.
echo ════════════════════════════════════════════
echo.

:: PostgreSQL check
echo Checking PostgreSQL...
sc query PostgreSQL >nul 2>&1
if %errorlevel% equ 0 (
    sc query PostgreSQL | find "RUNNING" >nul
    if %errorlevel% equ 0 (
        echo [✓] PostgreSQL is running
    ) else (
        echo [!] PostgreSQL not running, attempting to start...
        net start PostgreSQL >nul 2>&1
        if %errorlevel% equ 0 (
            echo [✓] PostgreSQL started successfully
        ) else (
            echo [⚠] Could not auto-start PostgreSQL
            echo     Please start it manually before running the app
        )
    )
) else (
    echo [ℹ] PostgreSQL service not found
    echo     Make sure PostgreSQL is installed and running
)

echo.
echo ════════════════════════════════════════════
echo.
echo Starting Game Library...
echo.

:: Run the application
python src\main.py

if %errorlevel% neq 0 (
    echo.
    echo ╔════════════════════════════════════════╗
    echo ║         APPLICATION ERROR!             ║
    echo ╚════════════════════════════════════════╝
    echo.
    echo Exit code: %errorlevel%
    echo.
    echo Common solutions:
    echo 1. Make sure PostgreSQL is running
    echo 2. Initialize database: python setup_db.py
    echo 3. Reinstall deps: pip install -r requirements.txt
    echo.
    pause
    exit /b %errorlevel%
)

echo.
echo ╔════════════════════════════════════════╗
echo ║     Application closed successfully    ║
echo ╚════════════════════════════════════════╝
echo.
pause
