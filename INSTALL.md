# Game Library - Инструкция по установке

## 📦 Быстрая установка (Windows)

### Вариант 1: Готовый установщик (рекомендуется)

1. Скачайте `GameLibrary_Setup.exe` из релиза
2. Запустите установщик
3. Следуйте инструкциям мастера установки
4. ✓ Готово! Ярлык появится на рабочем столе

### Вариант 2: Ручная установка

1. **Установите Python 3.8+**
   - Скачайте с https://www.python.org/downloads/
   - ✅ Отметьте "Add Python to PATH" при установке

2. **Установите PostgreSQL**
   - Скачайте с https://www.postgresql.org/download/
   - Используйте пароль `postgres` для пользователя postgres

3. **Запустите установщик**
   ```
   setup.py
   ```

4. **Запустите приложение**
   - Через ярлык на рабочем столе, или
   - `run.bat` (Windows)
   - `./run.sh` (Linux)

---

## 🐧 Установка на Linux

```bash
# 1. Установка зависимостей
sudo apt update
sudo apt install python3 python3-venv python3-pip python3-tk postgresql postgresql-contrib

# 2. Запуск установщика
python3 setup.py

# 3. Запуск приложения
./run.sh
```

---

## ⚙️ Настройка базы данных

При первом запуске приложение автоматически:
- Создаст базу данных `games_db`
- Создаст необходимые таблицы
- Загрузит 200 игр

**Параметры подключения по умолчанию:**
- Database: `games_db`
- User: `postgres`
- Password: `postgres`
- Host: `localhost`
- Port: `5432`

---

## 🗑️ Удаление

### Windows
- Через "Программы и компоненты" в Панели управления, или
- Запустите `uninstall.bat`

### Linux
```bash
./uninstall.sh
```

---

## 📋 Системные требования

| Компонент | Минимум | Рекомендуется |
|-----------|---------|---------------|
| ОС | Windows 10 / Linux | Windows 11 / Ubuntu 22.04+ |
| Python | 3.8 | 3.10+ |
| PostgreSQL | 12 | 14+ |
| RAM | 2 GB | 4 GB |
| Место на диске | 500 MB | 1 GB |

---

## 🆘 Решение проблем

### Ошибка подключения к базе данных
```bash
# Проверьте, запущен ли PostgreSQL
# Windows: services.msc → PostgreSQL
# Linux: sudo service postgresql status
```

### Ошибка "ModuleNotFoundError"
```bash
# Переустановите зависимости
venv/bin/pip install -r requirements.txt
```

### Нет картинок игр
- Проверьте подключение к интернету
- Картинки загружаются из Steam API

---

## 📞 Поддержка

При возникновении проблем:
1. Проверьте логи приложения
2. Убедитесь, что PostgreSQL запущен
3. Проверьте права доступа к БД

---

**Версия:** 1.0.0  
**Лицензия:** MIT
