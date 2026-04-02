@echo off
setlocal enabledelayedexpansion

REM ════════════════════════════════════════════
REM Game Library - Быстрый запуск
REM Автоматический запуск PostgreSQL и приложения
REM ════════════════════════════════════════════

title Game Library

echo.
echo ╔════════════════════════════════════════╗
echo ║           GAME LIBRARY                 ║
echo ║     Запуск с автозапуском БД           ║
echo ╚════════════════════════════════════════╝
echo.

REM Проверяем, запущен ли PostgreSQL
echo → Проверка PostgreSQL...
netstat -an | findstr ":5432" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ PostgreSQL уже запущен на порту 5432
    goto LAUNCH
)

echo ✗ PostgreSQL не запущен
echo.
echo → Поиск и запуск PostgreSQL...

REM Ищем установку PostgreSQL
set "PGCTL="
set "PGDATA="

for %%v in (16 15 14 13) do (
    if exist "C:\Program Files\PostgreSQL\%%v\bin\pg_ctl.exe" (
        set "PGCTL=C:\Program Files\PostgreSQL\%%v\bin\pg_ctl.exe"
        set "PGDATA=C:\Program Files\PostgreSQL\%%v\data"
        goto FOUND
    )
    if exist "C:\Program Files (x86)\PostgreSQL\%%v\bin\pg_ctl.exe" (
        set "PGCTL=C:\Program Files (x86)\PostgreSQL\%%v\bin\pg_ctl.exe"
        set "PGDATA=C:\Program Files (x86)\PostgreSQL\%%v\data"
        goto FOUND
    )
)

REM Пробуем найти через PATH
where pg_ctl >nul 2>&1
if %errorlevel% equ 0 (
    for /f "delims=" %%i in ('where pg_ctl') do (
        set "PGCTL=%%i"
        for %%d in ("%%~dpi..") do set "PGDATA=%%~fd\data"
    )
    goto FOUND
)

echo.
echo ╔════════════════════════════════════════╗
echo ║  ОШИБКА: PostgreSQL не найден!         ║
echo ╚════════════════════════════════════════╝
echo.
echo Для работы приложения необходим PostgreSQL.
echo.
echo Варианты запуска:
echo.
echo 1) Установите PostgreSQL:
echo    https://www.postgresql.org/download/windows/
echo    Рекомендуемая версия: PostgreSQL 16
echo.
echo 2) Или запустите службу вручную:
echo    - Нажмите Win+R
echo    - Введите: services.msc
echo    - Найдите службу "postgresql-x64-XX"
echo    - Нажмите "Запустить"
echo.
echo 3) Или через командную строку (администратор):
echo    net start postgresql-x64-16
echo.
pause
exit /b 1

:FOUND
echo → Найден pg_ctl: !PGCTL!
echo → Каталог данных: !PGDATA!
echo.

if not exist "!PGDATA!" (
    echo ✗ Папка данных не найдена: !PGDATA!
    echo.
    echo Проверьте установку PostgreSQL.
    pause
    exit /b 1
)

echo → Запуск PostgreSQL...
"!PGCTL!" start -D "!PGDATA!" -w

if %errorlevel% neq 0 (
    echo.
    echo ╔════════════════════════════════════════╗
    echo ║  ОШИБКА: Не удалось запустить БД       ║
    echo ╚════════════════════════════════════════╝
    echo.
    echo Попробуйте:
    echo 1) Запустить от имени администратора
    echo 2) Проверить службу в services.msc
    echo.
    pause
    exit /b 1
)

timeout /t 3 /nobreak >nul

netstat -an | findstr ":5432" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ PostgreSQL успешно запущен
) else (
    echo ⚠ PostgreSQL может запускаться...
)

:LAUNCH
echo.
echo ════════════════════════════════════════════
echo → Запуск Game Library...
echo ════════════════════════════════════════════
echo.

REM Запускаем приложение
if exist "Game Library.exe" (
    start "" "Game Library.exe"
) else if exist "dist\Game Library.exe" (
    start "" "dist\Game Library.exe"
) else (
    echo → Запуск из исходников...
    python src\main.py
)

echo ✓ Приложение запущено
