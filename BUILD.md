# 📦 Game Library - Создание установщика

## Для Windows

### Вариант 1: Inno Setup (рекомендуется)

1. **Установите Inno Setup**
   - Скачайте с https://jrsoftware.org/isdl.php
   - Установите и запустите

2. **Подготовьте файлы**
   ```
   - Удалите папку venv (не входит в дистрибутив)
   - Создайте icon.ico (конвертируйте из icon.svg)
   ```

3. **Соберите установщик**
   - Откройте `installer.iss` в Inno Setup
   - Нажмите `Build` → `Compile`
   - Готовый установщик будет в `installer_output/`

4. **Конвертация иконки**
   ```bash
   # Онлайн конвертер:
   https://cloudconvert.com/svg-to-ico
   # Или используйте ImageMagick:
   convert icon.svg -define icon:auto-resize=256,128,64,48,32,16 icon.ico
   ```

### Вариант 2: PyInstaller (один EXE файл)

```bash
# Установка
pip install pyinstaller

# Сборка
pyinstaller --onefile --windowed --name "Game Library" --icon=icon.ico src/main.py

# Копирование зависимостей
# После сборки нужно будет добавить requirements.txt и базу данных
```

---

## Для Linux

### Создание .deb пакета (Ubuntu/Debian)

1. **Создайте структуру**
   ```bash
   mkdir -p game-library/DEBIAN
   mkdir -p game-library/opt/game-library
   mkdir -p game-library/usr/share/applications
   ```

2. **control файл**
   ```
   Package: game-library
   Version: 1.0.0
   Architecture: all
   Maintainer: Your Name
   Depends: python3, python3-pip, python3-tk, postgresql
   Description: Game Library - поиск и сортировка игр
   ```

3. **Сборка**
   ```bash
   dpkg-deb --build game-library
   ```

### Создание .rpm (Fedora/RHEL)

Используйте `rpmbuild` с соответствующим spec файлом.

---

## Кроссплатформенные решения

### NSIS (Nullsoft Scriptable Install System)
- https://nsis.sourceforge.io/
- Поддерживает Windows и Linux

### Electron + installer
- Для создания современного кроссплатформенного установщика

---

## Распространение

### GitHub Releases
1. Создайте релиз на GitHub
2. Прикрепите установщики
3. Пользователи скачивают и устанавливают

### itch.io
- Можно распространять через itch.io
- Поддерживает автообновления

### Steam
- Для более серьёзного распространения
- Требует регистрации разработчика

---

## Проверка перед релизом

- [ ] Все зависимости включены
- [ ] PostgreSQL проверяется при установке
- [ ] Ярлык создаётся корректно
- [ ] Деинсталлятор работает
- [ ] Тесты на чистой системе пройдены

---

## Лицензирование

Убедитесь, что у вас есть права на:
- Используемые библиотеки (PIL, psycopg2, etc.)
- Иконки и графические элементы
- Базу данных игр
