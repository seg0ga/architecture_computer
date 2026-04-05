@echo off
setlocal enabledelayedexpansion

echo.
echo ========================================
echo   GAME LIBRARY - Launcher
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found!
    echo.
    echo Please install Python 3.8+ from:
    echo https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

echo [OK] Python found
echo.

REM Check if virtual environment exists
if not exist "venv\" (
    echo Setting up for the first time...
    echo.
    
    echo Creating virtual environment...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to create virtual environment
        pause
        exit /b 1
    )
    
    echo Activating...
    call venv\Scripts\activate.bat
    
    echo Installing dependencies...
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install dependencies
        echo.
        echo Try installing manually:
        echo   pip install -r requirements.txt
        pause
        exit /b 1
    )
    
    echo.
    echo [OK] Setup complete!
    echo.
) else (
    call venv\Scripts\activate.bat
)

echo Starting Game Library...
echo.

REM Check if PostgreSQL is running
echo Checking PostgreSQL...
sc query PostgreSQL >nul 2>&1
if %errorlevel% equ 0 (
    sc query PostgreSQL | find "RUNNING" >nul
    if %errorlevel% neq 0 (
        echo PostgreSQL is not running. Starting PostgreSQL...
        net start PostgreSQL
        if %errorlevel% neq 0 (
            echo.
            echo [WARNING] Could not start PostgreSQL automatically.
            echo Please start PostgreSQL manually before running this application.
            echo.
        )
    ) else (
        echo [OK] PostgreSQL is running
    )
) else (
    echo [INFO] PostgreSQL service not found. Please ensure PostgreSQL is running.
)

echo.
echo ========================================
echo   Starting Game Library Application
echo ========================================
echo.

python src\main.py

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Application failed to start!
    echo.
    echo Common issues:
    echo - PostgreSQL is not running
    echo - Database not initialized (run: python setup_db.py)
    echo - Missing dependencies (run: pip install -r requirements.txt)
    echo.
    pause
    exit /b 1
)

echo.
echo Application closed.
pause
