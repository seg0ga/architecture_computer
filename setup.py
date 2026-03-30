"""
Game Library - Setup Installer
Установка всех зависимостей и настройка приложения
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path

# Цвета для вывода
class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'

def print_header(text):
    print(f"\n{Colors.HEADER}{Colors.BOLD}{'='*60}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{text.center(60)}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{'='*60}{Colors.ENDC}\n")

def print_success(text):
    print(f"{Colors.OKGREEN}✓ {text}{Colors.ENDC}")

def print_error(text):
    print(f"{Colors.FAIL}✗ {text}{Colors.ENDC}")

def print_info(text, *args):
    if args:
        text = text + " " + " ".join(str(a) for a in args)
    print(f"{Colors.OKCYAN}→ {text}{Colors.ENDC}")

def check_python():
    """Проверка установки Python"""
    print_header("ПРОВЕРКА PYTHON")
    try:
        version = sys.version_info
        if version.major >= 3 and version.minor >= 8:
            print_success(f"Python {version.major}.{version.minor}.{version.micro} найден")
            return True
        else:
            print_error(f"Требуется Python 3.8+, найден {version.major}.{version.minor}")
            return False
    except:
        print_error("Python не найден")
        return False

def create_venv():
    """Создание виртуального окружения"""
    print_header("СОЗДАНИЕ ВИРТУАЛЬНОГО ОКРУЖЕНИЯ")
    venv_path = Path(__file__).parent / "venv"
    
    if venv_path.exists():
        print_info("Виртуальное окружение уже существует")
        return True
    
    try:
        subprocess.check_call([sys.executable, "-m", "venv", str(venv_path)])
        print_success("Виртуальное окружение создано")
        return True
    except Exception as e:
        print_error(f"Ошибка создания: {e}")
        return False

def install_dependencies():
    """Установка зависимостей"""
    print_header("УСТАНОВКА ЗАВИСИМОСТЕЙ")
    
    venv_path = Path(__file__).parent / "venv"
    if os.name == 'nt':
        pip_path = venv_path / "Scripts" / "pip.exe"
        python_path = venv_path / "Scripts" / "python.exe"
    else:
        pip_path = venv_path / "bin" / "pip"
        python_path = venv_path / "bin" / "python"
    
    requirements_path = Path(__file__).parent / "requirements.txt"
    
    try:
        # Обновление pip
        subprocess.check_call([str(python_path), "-m", "pip", "install", "--upgrade", "pip"])
        
        # Установка зависимостей
        subprocess.check_call([str(pip_path), "install", "-r", str(requirements_path)])
        
        print_success("Все зависимости установлены")
        return True
    except Exception as e:
        print_error(f"Ошибка установки: {e}")
        return False

def check_postgresql():
    """Проверка PostgreSQL"""
    print_header("ПРОВЕРКА POSTGRESQL")
    print_info("PostgreSQL должен быть установлен отдельно")
    print_info("Скачать можно с: https://www.postgresql.org/download/")
    return True

def setup_database():
    """Настройка базы данных"""
    print_header("НАСТРОЙКА БАЗЫ ДАННЫХ")
    
    venv_path = Path(__file__).parent / "venv"
    if os.name == 'nt':
        python_path = venv_path / "Scripts" / "python.exe"
    else:
        python_path = venv_path / "bin" / "python"
    
    # Скрипт настройки БД
    setup_script = Path(__file__).parent / "setup_db.py"
    
    if setup_script.exists():
        try:
            subprocess.check_call([str(python_path), str(setup_script)])
            print_success("База данных настроена")
            return True
        except Exception as e:
            print_error(f"Ошибка настройки БД: {e}")
            print_info("Вы можете настроить БД вручную или запустить приложение - оно предложит настройку")
            return True  # Не блокируем установку
    else:
        print_info("Скрипт setup_db.py не найден")
        return True

def create_shortcut():
    """Создание ярлыка на рабочем столе"""
    print_header("СОЗДАНИЕ ЯРЛЫКА")
    
    if os.name == 'nt':
        # Windows
        try:
            import win32com.client
            
            desktop = Path(os.environ['USERPROFILE']) / "Desktop"
            shortcut_path = desktop / "Game Library.lnk"
            
            venv_python = Path(__file__).parent / "venv" / "Scripts" / "python.exe"
            main_script = Path(__file__).parent / "src" / "main.py"
            
            shell = win32com.client.Dispatch('WScript.Shell')
            shortcut = shell.CreateShortCut(str(shortcut_path))
            shortcut.Targetpath = str(venv_python)
            shortcut.Arguments = str(main_script)
            shortcut.WorkingDirectory = str(Path(__file__).parent)
            shortcut.IconLocation = str(Path(__file__).parent / "icon.ico")
            shortcut.save()
            
            print_success("Ярлык создан на рабочем столе")
            return True
        except Exception as e:
            print_error(f"Ошибка создания ярлыка: {e}")
            print_info("Ярлык можно создать вручную")
            return True
    else:
        # Linux
        try:
            desktop = Path.home() / "Desktop"
            desktop.mkdir(exist_ok=True)
            
            shortcut_path = desktop / "game-library.desktop"
            app_path = Path(__file__).parent
            
            desktop_content = f"""[Desktop Entry]
Version=1.0
Type=Application
Name=Game Library
Comment=Игровая библиотека - поиск и сортировка игр
Exec={app_path / 'venv' / 'bin' / 'python'} {app_path / 'src' / 'main.py'}
Path={app_path}
Icon=applications-games
Terminal=false
Categories=Game;
"""
            
            with open(shortcut_path, 'w') as f:
                f.write(desktop_content)
            
            os.chmod(shortcut_path, 0o755)
            
            print_success("Ярлык создан на рабочем столе")
            return True
        except Exception as e:
            print_error(f"Ошибка создания ярлыка: {e}")
            return True

def create_uninstaller():
    """Создание деинсталлятора"""
    print_header("СОЗДАНИЕ ДЕИНСТАЛЛЯТОРА")
    
    uninstaller_path = Path(__file__).parent / "uninstall.exe" if os.name == 'nt' else Path(__file__).parent / "uninstall.sh"
    
    if os.name == 'nt':
        uninstall_script = '''@echo off
echo ============================================
echo    Game Library - Удаление
echo ============================================
echo.
echo Удаляем виртуальное окружение...
if exist "venv" rmdir /s /q "venv"
echo.
echo Готово!
echo.
pause
'''
        with open(uninstaller_path.with_suffix('.bat'), 'w', encoding='utf-8') as f:
            f.write(uninstall_script)
    else:
        uninstall_script = '''#!/bin/bash
echo "============================================"
echo "   Game Library - Удаление"
echo "============================================"
echo ""
echo "Удаляем виртуальное окружение..."
rm -rf "venv"
echo ""
echo "Готово!"
echo ""
'''
        with open(uninstaller_path, 'w') as f:
            f.write(uninstall_script)
        os.chmod(uninstaller_path, 0o755)
    
    print_success("Деинсталлятор создан")
    return True

def main():
    """Основная функция установки"""
    print_header("GAME LIBRARY - УСТАНОВКА")
    print_info("Добро пожаловать в мастер установки Game Library!")
    print_info("Программа будет установлена в:", Path(__file__).parent)
    print()
    
    # Убрано ожидание Enter для автоматического запуска
    # input("Нажмите Enter для начала установки...")
    
    steps = [
        ("Проверка Python", check_python),
        ("Создание виртуального окружения", create_venv),
        ("Установка зависимостей", install_dependencies),
        ("Проверка PostgreSQL", check_postgresql),
        ("Настройка базы данных", setup_database),
        ("Создание ярлыка", create_shortcut),
        ("Создание деинсталлятора", create_uninstaller),
    ]
    
    success_count = 0
    for name, func in steps:
        if func():
            success_count += 1
        else:
            print_error(f"Шаг '{name}' не выполнен")
            if name == "Проверка Python":
                print("\n{Colors.FAIL}Установка не может быть продолжена без Python!{Colors.ENDC}")
                input("\nНажмите Enter для выхода...")
                return False
    
    print_header("УСТАНОВКА ЗАВЕРШЕНА")
    print_success(f"Выполнено {success_count} из {len(steps)} шагов")
    print()
    print_info("Для запуска приложения:")
    print("  1. Используйте ярлык на рабочем столе")
    print("  2. Или запустите: python src/main.py")
    print()
    
    # Убрано ожидание для Linux
    if os.name == 'nt':
        input("Нажмите Enter для выхода...")
    
    return True

if __name__ == "__main__":
    main()
