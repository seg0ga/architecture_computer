#!/bin/bash
# ============================================================
# GAME LIBRARY - Быстрый запуск для Linux
# Просто запустите: ./run.sh
# ============================================================

echo ""
echo "╔════════════════════════════════════════╗"
echo "║        GAME LIBRARY - Launcher         ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Проверяем Python
if ! command -v python3 &> /dev/null; then
    echo "╔════════════════════════════════════════╗"
    echo "║        PYTHON НЕ НАЙДЕН!               ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    echo "Установите Python 3.8+:"
    echo "  Ubuntu/Debian: sudo apt install python3 python3-venv python3-pip python3-tk"
    echo "  Fedora:        sudo dnf install python3 python3-tkinter"
    echo "  Arch:          sudo pacman -S python python-tkinter"
    echo ""
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
echo "[✓] Python $PYTHON_VERSION найден"
echo ""

# Создаём venv если нет
if [ ! -d "venv" ]; then
    echo "→ Создание виртуального окружения..."
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "[✗] Ошибка создания venv"
        echo "  Установите: sudo apt install python3-venv"
        exit 1
    fi
    echo "[✓] Виртуальное окружение создано"
fi

source venv/bin/activate

# Устанавливаем зависимости
if [ ! -f "venv/.setup_complete" ]; then
    echo ""
    echo "→ Установка зависимостей (только первый раз)..."
    pip install -q -r requirements.txt
    if [ $? -ne 0 ]; then
        echo ""
        echo "[✗] Ошибка установки зависимостей"
        echo "  Ручная установка: pip install -r requirements.txt"
        exit 1
    fi
    touch venv/.setup_complete
    echo "[✓] Зависимости установлены"
else
    echo "[✓] Зависимости уже установлены"
fi

echo ""
echo "════════════════════════════════════════"

# Проверяем PostgreSQL
echo "→ Проверка PostgreSQL..."
PG_RUNNING=false

if pg_isready -q 2>/dev/null; then
    echo "[✓] PostgreSQL уже запущен"
    PG_RUNNING=true
fi

if [ "$PG_RUNNING" = false ]; then
    echo "[!] PostgreSQL не запущен, пробуем запустить..."
    
    if sudo systemctl start postgresql 2>/dev/null; then
        echo "[✓] PostgreSQL запущен (systemctl)"
        PG_RUNNING=true
    elif sudo service postgresql start 2>/dev/null; then
        echo "[✓] PostgreSQL запущен (service)"
        PG_RUNNING=true
    elif sudo pg_ctlcluster 16 main start 2>/dev/null; then
        echo "[✓] PostgreSQL запущен (v16)"
        PG_RUNNING=true
    elif sudo pg_ctlcluster 15 main start 2>/dev/null; then
        echo "[✓] PostgreSQL запущен (v15)"
        PG_RUNNING=true
    elif sudo pg_ctlcluster 14 main start 2>/dev/null; then
        echo "[✓] PostgreSQL запущен (v14)"
        PG_RUNNING=true
    else
        echo ""
        echo "[⚠] Не удалось запустить PostgreSQL автоматически"
        echo ""
        echo "Запустите вручную:"
        echo "  sudo systemctl start postgresql"
        echo "  или"
        echo "  sudo service postgresql start"
    fi
fi

if [ "$PG_RUNNING" = false ]; then
    echo ""
    echo "Продолжаю запуск без PostgreSQL (могут быть ошибки)..."
    sleep 2
fi

echo ""
echo "════════════════════════════════════════"
echo "→ Запуск Game Library..."
echo "════════════════════════════════════════"
echo ""

python src/main.py
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║         ОШИБКА ЗАПУСКА!                ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    echo "Код ошибки: $EXIT_CODE"
    echo ""
    echo "Частые решения:"
    echo "1. Запустите PostgreSQL: sudo systemctl start postgresql"
    echo "2. Инициализируйте БД: python3 setup_db.py"
    echo "3. Переустановите зависимости: pip install -r requirements.txt"
    echo ""
    exit $EXIT_CODE
fi

echo ""
echo "╔════════════════════════════════════════╗"
echo "║     Приложение закрыто успешно         ║"
echo "╚════════════════════════════════════════╝"
echo ""
