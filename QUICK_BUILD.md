# 🚀 Game Library - Создание установщика

## Быстрый старт

### Для Windows

1. **Установите Inno Setup**
   - https://jrsoftware.org/isdl.php
   - Скачайте и установите

2. **Подготовьте проект**
   ```bash
   # Удалите лишнее
   rmdir /s /q venv
   rmdir /s /q __pycache__
   ```

3. **Создайте иконку**
   - Конвертируйте `icon.svg` в `icon.ico`
   - Онлайн: https://cloudconvert.com/svg-to-ico
   - Или: `convert icon.svg icon.ico` (ImageMagick)

4. **Соберите установщик**
   - Откройте `installer.iss` в Inno Setup
   - Нажмите `Build` → `Compile`
   - Готово! Файл в `installer_output/GameLibrary_Setup.exe`

### Для Linux

```bash
# 1. Создайте директорию
mkdir -p game-library_{1.0.0}/DEBIAN
mkdir -p game-library_{1.0.0}/opt/game-library

# 2. Скопируйте файлы
cp -r src database requirements.txt setup.py run.sh icon.svg \
    game-library_{1.0.0}/opt/game-library/

# 3. Создайте control
cat > game-library_{1.0.0}/DEBIAN/control << EOF
Package: game-library
Version: 1.0.0
Architecture: all
Maintainer: Your Name
Depends: python3, python3-pip, python3-tk, postgresql
Description: Game Library - поиск и сортировка игр
EOF

# 4. Соберите пакет
dpkg-deb --build game-library_{1.0.0}
```

---

## Альтернативные варианты

### PyInstaller (один EXE)

```bash
pip install pyinstaller
pyinstaller --onefile --windowed --name "Game Library" --icon=icon.ico src/main.py
```

### Auto-exe (простой вариант)

```bash
pip install auto-py-to-exe
auto-py-to-exe
```

---

## Распространение

1. **GitHub Releases**
   - Создайте релиз на GitHub
   - Прикрепите установщик
   - Пользователи скачивают

2. **Google Drive / Dropbox**
   - Загрузите файл
   - Поделитесь ссылкой

3. **Собственный сайт**
   - Разместите на хостинге
   - Добавьте ссылку для скачивания

---

## Проверка

Перед публикацией проверьте:
- [ ] Установка работает на чистой системе
- [ ] PostgreSQL проверяется/устанавливается
- [ ] Ярлык создаётся
- [ ] Приложение запускается
- [ ] Деинсталлятор удаляет всё

---

## Готово!

Теперь пользователи могут:
1. Скачать установщик
2. Установить в один клик
3. Запустить с рабочего стола
