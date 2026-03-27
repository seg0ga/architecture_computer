import psycopg2
from psycopg2 import errors
from psycopg2.extras import RealDictCursor
from typing import List, Dict, Any, Optional
import os


class DatabaseManager:
    def __init__(self, database=None, host=None, user=None, password=None, port=None):
        self.db_config = {
            'dbname': database or 'games_db',
            'user': user or 'postgres',
            'password': password or 'postgres',
            'host': host or 'localhost',
            'port': port or '5432'
        }
        self.connection = None
        self.cursor = None

    def connect(self):
        try:
            self.connection = psycopg2.connect(**self.db_config)
            self.cursor = self.connection.cursor(cursor_factory=RealDictCursor)
            return True
        except Exception as e:
            print(f"Ошибка подключения: {e}")
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
                return True
        except:
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

    def get_all_games(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('SELECT * FROM games ORDER BY id')
            return [dict(row) for row in self.cursor.fetchall()]
        except Exception as e:
            print(f"Ошибка: {e}")
            return []

    def add_game(self, title: str, developer: str, publisher: str, release_date: str,
                 metacritic_score: int, genre: str, platform: str, game_modes: str,
                 engine: str, russian_language: bool, age_rating: int) -> tuple:
        """Добавить игру. Возвращает (True, None) при успехе или (False, ошибка) при неудаче"""
        try:
            self.cursor.execute('''
                INSERT INTO games (title, developer, publisher, release_date,
                                   metacritic_score, genre, platform, game_modes,
                                   engine, russian_language, age_rating)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
            ''', (title, developer, publisher, release_date, 
                  metacritic_score, genre, platform, game_modes,
                  engine, russian_language, age_rating))
            
            game_id = self.cursor.fetchone()[0]
            self.connection.commit()
            print(f"Добавлена игра: {title} (ID={game_id})")
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при добавлении игры: {str(e)}"
            print(error_msg)
            self.connection.rollback()
            return (False, error_msg)