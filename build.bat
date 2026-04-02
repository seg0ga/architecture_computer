@echo off
REM Сборка Game Library в EXE для Windows

echo ╔════════════════════════════════════════╗
echo ║     GAME LIBRARY - Сборка в EXE        ║
echo ╚════════════════════════════════════════╝
echo.

REM Активация venv
call venv\Scripts\activate.bat

REM Очистка
echo → Очистка старых файлов...
rmdir /s /q build dist 2>nul
del *.spec 2>nul

REM Сборка
echo → Сборка EXE файла...
pyinstaller --onefile ^
    --windowed ^
    --name "Game Library" ^
    --icon=icon.ico ^
    --add-data "src;src" ^
    --add-data "database;database" ^
    --add-data "requirements.txt;." ^
    --hidden-import=PIL ^
    --hidden-import=psycopg2 ^
    src\main.py

echo → Копирование дополнительных файлов...
xcopy /E /I database dist\database 2>nul
copy requirements.txt dist\ 2>nul
copy README.md dist\ 2>nul
copy INSTALL.md dist\ 2>nul
copy launcher.bat dist\ 2>nul

echo.
echo ╔════════════════════════════════════════╗
echo ║         СБОРКА ЗАВЕРШЕНА               ║
echo ╚════════════════════════════════════════╝
echo.
echo Готовый файл: dist\Game Library.exe
echo Лаунчер: dist\launcher.bat
echo.
echo Для запуска с автозапуском БД:
echo   1. launcher.bat - запуск с автозапуском PostgreSQL
echo   2. Game Library.exe - прямой запуск
echo.
echo Для создания установщика:
echo   1. Установите Inno Setup
echo   2. Откройте installer.iss
echo   3. Нажмите Build
echo.
pause
