@echo off
setlocal enabledelayedexpansion

echo.
echo ========================================
echo   GAME LIBRARY - Windows Build Script
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
    echo IMPORTANT: During installation, check "Add Python to PATH"
    echo.
    pause
    exit /b 1
)

echo [OK] Python found
python --version
echo.

REM Check if virtual environment exists
if not exist "venv\" (
    echo Creating virtual environment...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to create virtual environment
        pause
        exit /b 1
    )
    echo [OK] Virtual environment created
) else (
    echo [OK] Virtual environment exists
)
echo.

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat
echo.

REM Install dependencies
echo Installing dependencies...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed
echo.

REM Install PyInstaller
echo Installing PyInstaller...
pip install pyinstaller
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install PyInstaller
    pause
    exit /b 1
)
echo [OK] PyInstaller installed
echo.

REM Clean old builds
echo Cleaning old builds...
rmdir /s /q build 2>nul
rmdir /s /q dist 2>nul
del /q *.spec 2>nul
echo [OK] Cleaned
echo.

REM Build EXE
echo ========================================
echo   Building Game Library.exe...
echo ========================================
echo.

pyinstaller --onefile ^
    --windowed ^
    --name "Game Library" ^
    --icon=icon.ico ^
    --add-data "src;src" ^
    --add-data "database;database" ^
    --add-data "requirements.txt;." ^
    --hidden-import=PIL ^
    --hidden-import=psycopg2 ^
    --hidden-import=PIL.Image ^
    --hidden-import=PIL.ImageTk ^
    src\main.py

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Build failed!
    echo.
    echo Common issues:
    echo - Missing dependencies (check requirements.txt)
    echo - PyInstaller not installed
    echo - Python path issues
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Build successful!
echo.

REM Copy additional files to dist
echo Copying additional files...
if exist "database\" (
    xcopy /E /I /Y database "dist\database"
)
if exist "requirements.txt" copy /Y requirements.txt "dist\"
if exist "README.md" copy /Y README.md "dist\"
if exist "INSTALL.md" copy /Y INSTALL.md "dist\"

echo.
echo ========================================
echo   BUILD COMPLETE!
echo ========================================
echo.
echo Your executable is ready at:
echo   dist\Game Library.exe
echo.
echo You can distribute this single file,
echo or create an installer using Inno Setup.
echo.
echo To test: double-click "dist\Game Library.exe"
echo.
pause
