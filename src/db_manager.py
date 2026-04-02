import psycopg2
from psycopg2 import errors
from psycopg2.extras import RealDictCursor
from typing import List, Dict, Any, Optional
import os
import subprocess
import time
import sys


class DatabaseManager:
    def __init__(self, database=None, host=None, user=None, password=None, port=None):
        self.db_config = {
            'dbname': database or 'games_db_new',
            'user': user or 'postgres',
            'password': password or '1234',
            'host': host or 'localhost',
            'port': port or '5432'
        }
        self.connection = None
        self.cursor = None

    def _try_start_postgresql(self):
        """Пытается запустить PostgreSQL локально"""
        print("→ Попытка запуска PostgreSQL...")
        
        if sys.platform == 'win32':
            # Windows
            pg_versions = ['16', '15', '14', '13']
            pg_paths = [
                r'C:\Program Files\PostgreSQL',
                r'C:\Program Files (x86)\PostgreSQL'
            ]
            
            pg_ctl = None
            pg_data = None
            
            for version in pg_versions:
                for base_path in pg_paths:
                    ctl_path = os.path.join(base_path, version, 'bin', 'pg_ctl.exe')
                    data_path = os.path.join(base_path, version, 'data')
                    if os.path.exists(ctl_path) and os.path.exists(data_path):
                        pg_ctl = ctl_path
                        pg_data = data_path
                        break
                if pg_ctl:
                    break
            
            # Пробуем найти через PATH
            if not pg_ctl:
                try:
                    result = subprocess.run(['where', 'pg_ctl'], capture_output=True, text=True)
                    if result.returncode == 0:
                        pg_ctl = result.stdout.strip().split('\n')[0].strip()
                        # Пытаемся определить data directory
                        pg_data = os.path.join(os.path.dirname(os.path.dirname(pg_ctl)), 'data')
                except:
                    pass
            
            if pg_ctl and pg_data and os.path.exists(pg_data):
                try:
                    # Запускаем PostgreSQL
                    subprocess.Popen(
                        [pg_ctl, 'start', '-D', pg_data, '-w'],
                        creationflags=subprocess.CREATE_NO_WINDOW
                    )
                    time.sleep(3)  # Ждем запуска
                    print("✓ PostgreSQL запущен")
                    return True
                except Exception as e:
                    print(f"✗ Ошибка запуска PostgreSQL: {e}")
            else:
                print("✗ PostgreSQL не найден. Установите PostgreSQL:")
                print("  https://www.postgresql.org/download/windows/")
        
        elif sys.platform == 'linux':
            # Linux
            try:
                # Пробуем разные способы запуска
                for cmd in [
                    'sudo systemctl start postgresql',
                    'sudo service postgresql start',
                    'pg_ctlcluster 16 main start',
                    'pg_ctlcluster 15 main start',
                    'pg_ctlcluster 14 main start'
                ]:
                    result = subprocess.run(cmd, shell=True, capture_output=True)
                    if result.returncode == 0:
                        time.sleep(2)
                        print("✓ PostgreSQL запущен")
                        return True
                
                print("✗ Не удалось запустить PostgreSQL")
            except Exception as e:
                print(f"✗ Ошибка: {e}")
        
        elif sys.platform == 'darwin':
            # macOS
            try:
                result = subprocess.run(['brew', 'services', 'start', 'postgresql'], capture_output=True)
                if result.returncode == 0:
                    time.sleep(2)
                    print("✓ PostgreSQL запущен")
                    return True
            except:
                pass
        
        return False

    def connect(self):
        try:
            self.connection = psycopg2.connect(**self.db_config)
            self.cursor = self.connection.cursor(cursor_factory=RealDictCursor)
            return True
        except Exception as e:
            print(f"Ошибка подключения: {e}")
            # Пытаемся запустить PostgreSQL и подключаемся снова
            if self._try_start_postgresql():
                time.sleep(2)
                try:
                    self.connection = psycopg2.connect(**self.db_config)
                    self.cursor = self.connection.cursor(cursor_factory=RealDictCursor)
                    return True
                except Exception as e2:
                    print(f"Ошибка подключения после запуска: {e2}")
            return False

    def disconnect(self):
        if self.connection:
            self.connection.close()

    def init_database(self):
        try:
            self.cursor.execute("SELECT COUNT(*) FROM games")
            count = self.cursor.fetchone()['count']
            if count > 0:
                print(f"В базе {count} игр")
                # Проверяем наличие колонки executable_path и добавляем если нет
                self._add_executable_path_column_if_missing()
                return True
        except Exception as e:
            print(f"Ошибка проверки базы: {e}")
            self.connection.rollback()

        try:
            script_dir = os.path.dirname(os.path.abspath(__file__))
            sql_file = os.path.join(script_dir, '..', 'init_db.sql')

            if not os.path.exists(sql_file):
                print(f"Файл не найден: {sql_file}")
                return False

            with open(sql_file, 'r', encoding='utf-8') as f:
                self.cursor.execute(f.read())
            self.connection.commit()

            self.cursor.execute("SELECT COUNT(*) FROM games")
            count = self.cursor.fetchone()['count']
            print(f"Загружено {count} игр")
            return True
        except Exception as e:
            print(f"Ошибка: {e}")
            self.connection.rollback()
            return False

    def _add_executable_path_column_if_missing(self):
        """Добавляет колонку executable_path если она отсутствует"""
        try:
            self.cursor.execute("""
                SELECT column_name FROM information_schema.columns 
                WHERE table_name = 'games' AND column_name = 'executable_path'
            """)
            result = self.cursor.fetchone()
            if not result:
                self.cursor.execute("ALTER TABLE games ADD COLUMN executable_path VARCHAR(500)")
                self.connection.commit()
                print("Добавлена колонка executable_path")
        except Exception as e:
            print(f"Ошибка добавления колонки: {e}")
            self.connection.rollback()

    def get_all_games(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('SELECT * FROM games ORDER BY id')
            return [dict(row) for row in self.cursor.fetchall()]
        except Exception as e:
            print(f"Ошибка: {e}")
            return []

    def add_game(self, title: str, developer: str, publisher: str, release_date: str,
                 metacritic_score: int, genre: str, platform: str, game_modes: str,
                 engine: str, russian_language: bool, age_rating: int, image_url: str = None) -> tuple:
        """Добавить игру. Возвращает (True, None) при успехе или (False, ошибка) при неудаче"""
        try:
            self.cursor.execute('''
                INSERT INTO games (title, developer, publisher, release_date,
                                   metacritic_score, genre, platform, game_modes,
                                   engine, russian_language, age_rating, image_url)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
            ''', (title, developer, publisher, release_date,
                  metacritic_score, genre, platform, game_modes,
                  engine, bool(russian_language), age_rating, image_url))

            result = self.cursor.fetchone()
            self.connection.commit()
            
            if result:
                game_id = result['id']
                print(f"Добавлена игра: {title} (ID={game_id})")
            else:
                # Если fetchone не вернул результат, получаем последний ID
                self.cursor.execute('SELECT LASTVAL()')
                last_id = self.cursor.fetchone()
                game_id = last_id['lastval'] if last_id else None
                print(f"Добавлена игра: {title} (ID={game_id})")
            
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при добавлении игры: {str(e)}"
            print(error_msg)
            import traceback
            traceback.print_exc()
            self.connection.rollback()
            return (False, error_msg)

    def update_executable_path(self, game_id: int, executable_path: Optional[str]) -> tuple:
        """Обновить путь к исполняемому файлу игры. Возвращает (True, None) или (False, ошибка)"""
        try:
            self.cursor.execute('''
                UPDATE games SET executable_path = %s WHERE id = %s
            ''', (executable_path, game_id))
            self.connection.commit()
            print(f"Обновлен путь для игры ID={game_id}: {executable_path}")
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при обновлении пути: {str(e)}"
            print(error_msg)
            self.connection.rollback()
            return (False, error_msg)

    def update_image_url(self, game_id: int, image_url: Optional[str]) -> tuple:
        """Обновить URL изображения игры. Возвращает (True, None) или (False, ошибка)"""
        try:
            self.cursor.execute('''
                UPDATE games SET image_url = %s WHERE id = %s
            ''', (image_url, game_id))
            self.connection.commit()
            print(f"Обновлен URL изображения для игры ID={game_id}: {image_url}")
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при обновлении изображения: {str(e)}"
            print(error_msg)
            self.connection.rollback()
            return (False, error_msg)

    def delete_game(self, game_id: int) -> tuple:
        """Удалить игру по ID. Возвращает (True, None) или (False, ошибка)"""
        try:
            self.cursor.execute('DELETE FROM games WHERE id = %s', (game_id,))
            self.connection.commit()
            print(f"Удалена игра ID={game_id}")
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при удалении игры: {str(e)}"
            print(error_msg)
            self.connection.rollback()
            return (False, error_msg)

    def get_system_requirements(self, game_id: int) -> Optional[Dict[str, Any]]:
        """Получить системные требования игры"""
        try:
            self.cursor.execute('SELECT * FROM system_requirements WHERE game_id = %s', (game_id,))
            result = self.cursor.fetchone()
            return dict(result) if result else None
        except Exception as e:
            print(f"Ошибка: {e}")
            return None

    def update_system_requirements(self, game_id: int, requirements: Dict[str, Any]) -> tuple:
        """Обновить системные требования. Возвращает (True, None) или (False, ошибка)"""
        try:
            # Проверяем, есть ли уже запись
            self.cursor.execute('SELECT id FROM system_requirements WHERE game_id = %s', (game_id,))
            existing = self.cursor.fetchone()

            if existing:
                # Обновляем
                self.cursor.execute('''
                    UPDATE system_requirements SET
                        min_os = %s, min_processor = %s, min_memory = %s, min_graphics = %s,
                        min_directx = %s, min_storage = %s,
                        rec_os = %s, rec_processor = %s, rec_memory = %s, rec_graphics = %s,
                        rec_directx = %s, rec_storage = %s
                    WHERE game_id = %s
                ''', (
                    requirements.get('min_os'), requirements.get('min_processor'),
                    requirements.get('min_memory'), requirements.get('min_graphics'),
                    requirements.get('min_directx'), requirements.get('min_storage'),
                    requirements.get('rec_os'), requirements.get('rec_processor'),
                    requirements.get('rec_memory'), requirements.get('rec_graphics'),
                    requirements.get('rec_directx'), requirements.get('rec_storage'),
                    game_id
                ))
            else:
                # Создаём новую запись
                self.cursor.execute('''
                    INSERT INTO system_requirements (
                        game_id, min_os, min_processor, min_memory, min_graphics,
                        min_directx, min_storage, rec_os, rec_processor, rec_memory,
                        rec_graphics, rec_directx, rec_storage
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ''', (
                    game_id,
                    requirements.get('min_os'), requirements.get('min_processor'),
                    requirements.get('min_memory'), requirements.get('min_graphics'),
                    requirements.get('min_directx'), requirements.get('min_storage'),
                    requirements.get('rec_os'), requirements.get('rec_processor'),
                    requirements.get('rec_memory'), requirements.get('rec_graphics'),
                    requirements.get('rec_directx'), requirements.get('rec_storage')
                ))

            self.connection.commit()
            print(f"Обновлены системные требования для игры ID={game_id}")
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при обновлении требований: {str(e)}"
            print(error_msg)
            self.connection.rollback()
            return (False, error_msg)

    def get_game_by_id(self, game_id: int) -> Optional[Dict[str, Any]]:
        """Получить игру по ID"""
        try:
            self.cursor.execute('SELECT * FROM games WHERE id = %s', (game_id,))
            result = self.cursor.fetchone()
            return dict(result) if result else None
        except Exception as e:
            print(f"Ошибка: {e}")
            return None