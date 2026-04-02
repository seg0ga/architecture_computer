#!/bin/bash
# Game Library - Быстрый запуск с автозапуском PostgreSQL

echo ""
echo "╔════════════════════════════════════════╗"
echo "║           GAME LIBRARY                 ║"
echo "║     Запуск с автозапуском БД           ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Проверяем, запущен ли PostgreSQL
echo "→ Проверка PostgreSQL..."
if pg_isready -q 2>/dev/null; then
    echo "✓ PostgreSQL уже запущен"
    goto_launch=true
else
    echo "✗ PostgreSQL не запущен"
    goto_launch=false
fi

if [ "$goto_launch" = false ]; then
    echo ""
    echo "→ Запуск PostgreSQL..."
    
    # Пробуем разные способы запуска
    if sudo systemctl start postgresql 2>/dev/null; then
        echo "✓ PostgreSQL запущен через systemctl"
    elif sudo service postgresql start 2>/dev/null; then
        echo "✓ PostgreSQL запущен через service"
    elif sudo pg_ctlcluster 16 main start 2>/dev/null; then
        echo "✓ PostgreSQL запущен через pg_ctlcluster (16)"
    elif sudo pg_ctlcluster 15 main start 2>/dev/null; then
        echo "✓ PostgreSQL запущен через pg_ctlcluster (15)"
    elif sudo pg_ctlcluster 14 main start 2>/dev/null; then
        echo "✓ PostgreSQL запущен через pg_ctlcluster (14)"
    else
        echo ""
        echo "╔════════════════════════════════════════╗"
        echo "║  ОШИБКА: Не удалось запустить БД       ║"
        echo "╚════════════════════════════════════════╝"
        echo ""
        echo "Попробуйте запустить вручную:"
        echo "  sudo systemctl start postgresql"
        echo "  или"
        echo "  sudo service postgresql start"
        echo ""
        exit 1
    fi
    
    sleep 2
fi

echo ""
echo "════════════════════════════════════════"
echo "→ Запуск Game Library..."
echo "════════════════════════════════════════"
echo ""

# Запускаем приложение
if [ -f "venv/bin/python" ]; then
    source venv/bin/activate
    python src/main.py
else
    python3 src/main.py
fi
