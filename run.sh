#!/bin/bash

# Game Library Launcher for Linux

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "╔════════════════════════════════════════╗"
echo "║       GAME LIBRARY - Запуск            ║"
echo "╚════════════════════════════════════════╝"

# Проверка виртуального окружения
if [ ! -d "venv" ]; then
    echo ""
    echo "⚠ Виртуальное окружение не найдено!"
    echo "  Запустите: python3 setup.py"
    echo ""
    read -p "Нажмите Enter для выхода..."
    exit 1
fi

# Активация venv
source venv/bin/activate

# Проверка PostgreSQL
if ! sudo service postgresql status > /dev/null 2>&1; then
    echo ""
    echo "⚠ PostgreSQL не запущен. Запускаем..."
    sudo service postgresql start
fi

# Запуск приложения
echo ""
echo "→ Запуск приложения..."
echo ""
python src/main.py
