"""
Настройка базы данных для Game Library
"""

import subprocess
import sys

def setup_database():
    """Настройка PostgreSQL и базы данных"""
    
    print("\n=== НАСТРОЙКА БАЗЫ ДАННЫХ ===\n")
    
    # Параметры подключения
    db_name = "games_db"
    db_user = "postgres"
    db_password = "postgres"
    
    print("1. Настройка пароля пользователя postgres...")
    try:
        subprocess.run(
            f'sudo -u postgres psql -c "ALTER USER {db_user} PASSWORD \'{db_password}\';"',
            shell=True, check=True, capture_output=True
        )
        print("   ✓ Пароль установлен")
    except Exception as e:
        print(f"   ⚠ Не удалось установить пароль: {e}")
    
    print("\n2. Создание базы данных...")
    try:
        subprocess.run(
            f'sudo -u postgres psql -c "CREATE DATABASE {db_name};"',
            shell=True, check=True, capture_output=True
        )
        print("   ✓ База данных создана")
    except Exception as e:
        print(f"   ℹ База данных уже существует или ошибка: {e}")
    
    print("\n3. Запуск приложения для инициализации таблиц...")
    print("   (Таблицы будут созданы автоматически при первом запуске)")
    
    print("\n=== ГОТОВО ===\n")
    print("Параметры подключения:")
    print(f"  Database: {db_name}")
    print(f"  User: {db_user}")
    print(f"  Password: {db_password}")
    print(f"  Host: localhost")
    print(f"  Port: 5432")
    print()

if __name__ == "__main__":
    setup_database()
