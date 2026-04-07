#!/bin/bash
# ============================================================
# Сборка Game Library в один исполняемый файл для Linux
# Запуск: ./build_linux.sh
# ============================================================

echo ""
echo "╔════════════════════════════════════════╗"
echo "║     GAME LIBRARY - Сборка для Linux    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Проверяем Python
if ! command -v python3 &> /dev/null; then
    echo "[✗] Python3 не найден"
    echo "  Ubuntu: sudo apt install python3 python3-venv"
    exit 1
fi

# Создаём venv
if [ ! -d "venv" ]; then
    echo "→ Создание виртуального окружения..."
    python3 -m venv venv
fi

source venv/bin/activate

# PyInstaller
if ! command -v pyinstaller &> /dev/null; then
    echo "→ Установка PyInstaller..."
    pip install -q pyinstaller
fi

# Зависимости
echo "→ Установка зависимостей..."
pip install -q -r requirements.txt

# Очистка
echo "→ Очистка старых сборок..."
rm -rf build dist *.spec

# Сборка
echo ""
echo "→ Сборка..."
pyinstaller --onefile \
    --name "GameLibrary" \
    --add-data "src:src" \
    --add-data "init_db.json:." \
    --hidden-import=PIL \
    --hidden-import=psycopg2 \
    --hidden-import=tkinter \
    src/main.py

if [ $? -eq 0 ]; then
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║         СБОРКА ЗАВЕРШЕНА               ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    echo "Исполняемый файл: dist/GameLibrary"
    echo ""
    echo "Размер: $(du -sh dist/GameLibrary | cut -f1)"
    echo ""
    echo "Запуск: ./dist/GameLibrary"
    echo ""
else
    echo ""
    echo "[✗] Сборка не удалась!"
    exit 1
fi
