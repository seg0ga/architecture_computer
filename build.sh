#!/bin/bash
# Скрипт сборки Game Library в EXE

echo "╔════════════════════════════════════════╗"
echo "║     GAME LIBRARY - Сборка в EXE        ║"
echo "╚════════════════════════════════════════╝"

# Активация venv
source venv/bin/activate

# Очистка старых сборок
echo ""
echo "→ Очистка старых файлов..."
rm -rf build dist *.spec

# Сборка
echo ""
echo "→ Сборка EXE файла..."
pyinstaller --onefile \
    --windowed \
    --name "Game Library" \
    --icon=icon.svg \
    --add-data "src:src" \
    --add-data "database:database" \
    --add-data "requirements.txt:." \
    --hidden-import=PIL \
    --hidden-import=psycopg2 \
    src/main.py

echo ""
echo "→ Копирование дополнительных файлов..."
cp -r database dist/ 2>/dev/null || true
cp requirements.txt dist/ 2>/dev/null || true
cp README.md dist/ 2>/dev/null || true
cp INSTALL.md dist/ 2>/dev/null || true

echo ""
echo "╔════════════════════════════════════════╗"
echo "║         СБОРКА ЗАВЕРШЕНА               ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "Готовый файл: dist/Game Library"
echo ""
echo "Для создания установщика:"
echo "  1. Скопируйте dist/ на Windows"
echo "  2. Запустите Inno Setup с installer.iss"
echo ""
