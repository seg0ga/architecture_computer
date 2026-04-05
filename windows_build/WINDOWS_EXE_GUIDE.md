# 🚀 How to Build Windows EXE

## Quick Summary

This project is ready to build into a Windows executable. You have **two options**:

---

## Option 1: Build EXE (Recommended)

### What you need:
- Windows 10/11 computer
- Python 3.8+ installed
- PostgreSQL running

### Steps:

1. **Copy the entire project to Windows**
   - Copy this folder to your Windows machine
   - Make sure `icon.ico` file is present (already included)

2. **Double-click `BUILD_WINDOWS.bat`**
   - This script does everything automatically:
     - Creates virtual environment
     - Installs dependencies
     - Builds the EXE file
   
3. **Find your EXE**
   - After build completes, the executable is at:
     ```
     dist\Game Library.exe
     ```
   - You can distribute this single file to users!

---

## Option 2: Use Launcher (No Build Needed)

If you just want to run the application without building an EXE:

1. **Double-click `LAUNCHER.bat`**
   - Automatically sets up Python environment
   - Installs dependencies
   - Starts the application

2. **Use every time**
   - Just double-click `LAUNCHER.bat` to run the app
   - No need to build anything!

---

## Manual Build (if batch files don't work)

Open Command Prompt and run:

```cmd
# 1. Create virtual environment
python -m venv venv

# 2. Activate it
venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt
pip install pyinstaller

# 4. Build EXE
pyinstaller --onefile --windowed --name "Game Library" --icon=icon.ico --add-data "src;src" --add-data "database;database" --hidden-import=PIL --hidden-import=psycopg2 src\main.py

# 5. Copy database folder
xcopy /E /I /Y database dist\database

# 6. Your EXE is ready!
dist\Game Library.exe
```

---

## Creating Professional Installer (Optional)

To create a proper Windows installer (.exe with setup wizard):

1. **Install Inno Setup**
   - Download: https://jrsoftware.org/isdl.php
   - Install it

2. **Open `installer.iss` in Inno Setup**

3. **Click Build → Compile**

4. **Find installer at** `installer_output\GameLibrary_Setup.exe`

---

## Requirements for End Users

People who use the built EXE need:
- ✅ Windows 10/11
- ✅ PostgreSQL installed and running

That's it! The EXE includes everything else.

---

## Troubleshooting

### "Python not found"
- Download Python from https://www.python.org/downloads/
- **IMPORTANT**: Check "Add Python to PATH" during installation

### "psycopg2 error"
```cmd
pip install psycopg2-binary
```

### "PostgreSQL connection error"
- Make sure PostgreSQL is installed and running
- Run: `net start PostgreSQL` (as Administrator)
- Initialize database: `python setup_db.py`

### Build fails with errors
- Delete `venv` folder
- Run `BUILD_WINDOWS.bat` again
- This does a clean rebuild

---

## Files Explained

| File | Purpose |
|------|---------|
| `BUILD_WINDOWS.bat` | One-click build script |
| `LAUNCHER.bat` | One-click run script (no build) |
| `icon.ico` | Windows icon file |
| `icon.svg` | Original SVG icon |
| `installer.iss` | Inno Setup installer script |

---

## Need Help?

See these files for more info:
- `README.md` - General documentation
- `INSTALL.md` - Installation guide
- `BUILD.md` - Build documentation

---

**Good luck!** 🎮
