import psycopg2
from psycopg2 import errors
from psycopg2.extras import RealDictCursor
from typing import List, Dict, Any, Optional
import os


class DatabaseManager:
    def __init__(self, database=None, host=None, user=None, password=None, port=None):
        if database is None:
            self.db_config = {
                'dbname': 'games_db',
                'user': 'postgres',
                'password': 'postgres',
                'host': 'localhost',
                'port': '5432'
            }
        else:
            self.db_config = {
                'dbname': database,
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
            print(f"Error connecting to PostgreSQL: {e}")
            return False

    def disconnect(self):
        if self.connection:
            self.connection.close()

    def init_database(self):
        """Инициализация базы данных и заполнение из SQL файла"""
        try:
            self.cursor.execute("SELECT COUNT(*) FROM games")
            count = self.cursor.fetchone()['count']
            
            if count > 0:
                print(f"✓ В базе уже загружено {count} игр")
                return True
        except errors.UndefinedTable:
            self.connection.rollback()
        
        try:
            script_dir = os.path.dirname(os.path.abspath(__file__))
            sql_file = os.path.join(script_dir, '..', 'init_db.sql')

            if not os.path.exists(sql_file):
                print(f"SQL file not found at {sql_file}")
                return False

            with open(sql_file, 'r', encoding='utf-8') as f:
                sql_script = f.read()

            self.cursor.execute(sql_script)
            self.connection.commit()

            self.cursor.execute("SELECT COUNT(*) FROM games")
            count = self.cursor.fetchone()['count']
            print(f"✓ Загружено {count} игр из init_db.sql")

            return True
        except Exception as e:
            print(f"Error initializing database: {e}")
            self.connection.rollback()
            return False

    def get_all_games(self) -> List[Dict[str, Any]]:
        """Получить все игры"""
        try:
            self.cursor.execute('''
                SELECT id, title, developer, publisher, release_date, 
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                ORDER BY id
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games: {e}")
            return []

    def get_games_sorted_by_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT id, title, developer, publisher, release_date, 
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                ORDER BY title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by title: {e}")
            return []

    def get_games_sorted_by_publisher_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT id, title, developer, publisher, release_date, 
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                ORDER BY publisher, title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by publisher and title: {e}")
            return []

    def get_games_sorted_by_release_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT id, title, developer, publisher, release_date, 
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                ORDER BY release_date, title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by release date and title: {e}")
            return []

    def get_games_sorted_by_metacritic_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT id, title, developer, publisher, release_date, 
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                ORDER BY metacritic_score DESC, title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by metacritic score and title: {e}")
            return []

    def get_games_sorted_by_age_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT id, title, developer, publisher, release_date, 
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                ORDER BY age_rating, title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by age rating and title: {e}")
            return []

    def search_by_title(self, title: str) -> List[Dict[str, Any]]:
        try:
            query = '''
                SELECT id, title, developer, publisher, release_date, 
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                WHERE title ILIKE %s
                ORDER BY title
            '''
            self.cursor.execute(query, (f'%{title}%',))
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error searching by title: {e}")
            return []

    def search_by_publisher(self, publisher: str) -> List[Dict[str, Any]]:
        try:
            query = '''
                SELECT id, title, developer, publisher, release_date,
                       metacritic_score, genre, platform, game_modes,
                       engine, russian_language, age_rating
                FROM games
                WHERE publisher ILIKE %s
                ORDER BY publisher, title
            '''
            self.cursor.execute(query, (f'%{publisher}%',))
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error searching by publisher: {e}")
            return []

    def add_game(self, title: str, developer: str, publisher: str, release_date: str,
                 metacritic_score: int, genre: str, platform: str, game_modes: str,
                 engine: str, russian_language: bool, age_rating: int) -> bool:
        """Добавить новую игру в базу данных"""
        try:
            query = '''
                INSERT INTO games (title, developer, publisher, release_date,
                                   metacritic_score, genre, platform, game_modes,
                                   engine, russian_language, age_rating)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
            '''
            self.cursor.execute(query, (
                title, developer, publisher, release_date,
                metacritic_score, genre, platform, game_modes,
                engine, russian_language, age_rating
            ))
            self.connection.commit()
            game_id = self.cursor.fetchone()['id']
            print(f"✓ Игра добавлена с ID={game_id}")
            return True
        except Exception as e:
            print(f"Error adding game: {e}")
            self.connection.rollback()
            return False
