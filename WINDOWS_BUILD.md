# 📦 Game Library - Создание Windows EXE

## ⚡ Быстрый способ (рекомендуется)

### На Windows:

1. **Скопируйте проект на Windows компьютер**

2. **Установите зависимости**
   ```cmd
   python -m venv venv
   venv\Scripts\activate
   pip install -r requirements.txt
   pip install pyinstaller
   ```

3. **Запустите сборку**
   ```cmd
   build.bat
   ```

4. **Готово!** 
   - EXE файл: `dist\Game Library.exe`
   - Можно запускать без Python!

---

## 🔧 Сборка установщика

### С Inno Setup:

1. **Установите Inno Setup**
   - https://jrsoftware.org/isdl.php

2. **Конвертируйте иконку**
   - https://cloudconvert.com/svg-to-ico
   - Или используйте онлайн конвертер

3. **Соберите установщик**
   - Откройте `installer.iss` в Inno Setup
   - Нажмите **Build → Compile**
   - Готово: `installer_output\GameLibrary_Setup.exe`

---

## 📁 Структура после сборки

```
dist/
├── Game Library.exe      # Основной файл
├── database/             # База данных
├── requirements.txt      # Зависимости
├── README.md            # Документация
└── INSTALL.md           # Инструкция
```

---

## 🚀 Распространение

### Вариант 1: Один EXE файл
- Просто скопируйте `Game Library.exe`
- Пользователь запускает и работает!

### Вариант 2: Установщик
- Создайте `.exe` установщик через Inno Setup
- Пользователь устанавливает как обычную программу

### Вариант 3: Архив
- Запакуйте `dist/` в ZIP
- Пользователь распаковывает и запускает

---

## 🎯 Для пользователей

**Минимальные требования:**
- Windows 10/11
- PostgreSQL (для работы с БД)

**Установка PostgreSQL:**
```
https://www.postgresql.org/download/windows/
```

Или используйте портативную версию:
```
https://www.enterprisedb.com/downloads/postgres-postgresql-downloads
```

---

## ⚠️ Важно

- EXE файл собран на Linux, поэтому может не работать на Windows
- **Для Windows EXE нужно собирать на Windows!**
- Tkinter должен быть установлен в системе

---

## 🆘 Решение проблем

### "Не найден tkinter"
```cmd
# Переустановите Python с опцией tcl/tk
# Или: pip install tk
```

### "Не найден psycopg2"
```cmd
pip install psycopg2-binary
```

### EXE не запускается
```cmd
# Запустите с консолью для отладки
"Game Library.exe" --console
```

---

**Готово!** Теперь у вас есть полноценный EXE файл! 🎉
