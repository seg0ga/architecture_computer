import sqlite3
from typing import List, Dict, Any, Optional
import os


class DatabaseManager:
    def __init__(self, database='database/games.db'):
        self.database = database
        self.connection = None
        self.cursor = None

    def connect(self):
        try:
            # Создаем папку database если её нет
            db_dir = os.path.dirname(self.database)
            if db_dir and not os.path.exists(db_dir):
                os.makedirs(db_dir)

            self.connection = sqlite3.connect(self.database)
            self.connection.row_factory = sqlite3.Row
            self.cursor = self.connection.cursor()
            return True
        except Exception as e:
            print(f"Error connecting to SQLite: {e}")
            return False

    def disconnect(self):
        if self.connection:
            self.connection.close()

    def init_database(self):
        """Инициализация базы данных и заполнение тестовыми данными"""
        try:
            # Создаем первую таблицу (основная информация об игре)
            self.cursor.execute('''
                CREATE TABLE IF NOT EXISTS games (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title VARCHAR(100) NOT NULL,
                    developer VARCHAR(100),
                    publisher VARCHAR(100),
                    release_date DATE,
                    metacritic_score INT,
                    genre VARCHAR(100),
                    platform VARCHAR(255),
                    game_modes VARCHAR(100)
                )
            ''')

            # Создаем вторую таблицу (дополнительная информация)
            self.cursor.execute('''
                CREATE TABLE IF NOT EXISTS game_details (
                    id INTEGER PRIMARY KEY,
                    engine VARCHAR(100),
                    russian_language BOOLEAN,
                    age_rating INT,
                    system_requirements TEXT,
                    FOREIGN KEY (id) REFERENCES games(id)
                )
            ''')

            # Проверяем, есть ли данные
            self.cursor.execute("SELECT COUNT(*) FROM games")
            count = self.cursor.fetchone()[0]

            if count == 0:
                # Вставляем данные в первую таблицу
                games_data = [
                    (1, 'Phasmophobia', 'Kinetic Games', 'Kinetic Games', '2020-09-18', 79, 'Хоррор, Симулятор', 'PC',
                     'Одиночная, Мультиплеер, Кооператив'),
                    (2, 'Cyberpunk 2077', 'CD Projekt Red', 'CD Projekt', '2020-12-10', 86, 'RPG, Open World',
                     'PC, PS5, Xbox', 'Одиночная'),
                    (3, 'CS2', 'Valve', 'Valve', '2023-09-27', 83, 'Шутер, Тактический', 'PC', 'Мультиплеер'),
                    (4, 'Portal', 'Valve', 'Valve', '2007-10-10', 90, 'Головоломка', 'PC, PS3, Xbox', 'Одиночная'),
                    (5, 'Half-Life', 'Valve', 'Valve', '1998-11-19', 96, 'Шутер', 'PC, PS2', 'Одиночная'),
                    (6, 'The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', '2015-05-19', 92, 'RPG, Open World',
                     'PC, PS4, Xbox', 'Одиночная'),
                    (7, 'Red Dead Redemption 2', 'Rockstar Games', 'Rockstar Games', '2019-11-05', 97,
                     'Action, Open World', 'PC, PS4, Xbox', 'Одиночная'),
                    (8, 'The Last of Us Part II', 'Naughty Dog', 'Sony', '2020-06-19', 93, 'Action, Adventure', 'PS4',
                     'Одиночная'),
                    (9, 'God of War', 'Santa Monica Studio', 'Sony', '2018-04-20', 94, 'Action, Adventure', 'PC, PS4',
                     'Одиночная'),
                    (10, 'Elden Ring', 'FromSoftware', 'Bandai Namco', '2022-02-25', 96, 'RPG, Action', 'PC, PS5, Xbox',
                     'Одиночная'),
                    (11, 'Minecraft', 'Mojang', 'Microsoft', '2011-11-18', 93, 'Sandbox, Survival', 'PC, PS, Xbox',
                     'Одиночная, Мультиплеер'),
                    (12, 'Grand Theft Auto V', 'Rockstar North', 'Rockstar Games', '2013-09-17', 97,
                     'Action, Open World', 'PC, PS4, Xbox', 'Одиночная'),
                    (13, 'Skyrim', 'Bethesda', 'Bethesda', '2011-11-11', 94, 'RPG, Open World', 'PC, PS4, Xbox',
                     'Одиночная'),
                    (14, 'Dark Souls III', 'FromSoftware', 'Bandai Namco', '2016-04-12', 89, 'RPG, Action',
                     'PC, PS4, Xbox', 'Одиночная'),
                    (15, 'Bloodborne', 'FromSoftware', 'Sony', '2015-03-24', 92, 'RPG, Action', 'PS4', 'Одиночная'),
                    (16, 'Sekiro: Shadows Die Twice', 'FromSoftware', 'Activision', '2019-03-22', 90, 'Action',
                     'PC, PS4, Xbox', 'Одиночная'),
                    (17, 'Monster Hunter: World', 'Capcom', 'Capcom', '2018-01-26', 90, 'Action, RPG', 'PC, PS4, Xbox',
                     'Одиночная, Кооператив'),
                    (18, 'Resident Evil Village', 'Capcom', 'Capcom', '2021-05-07', 84, 'Survival Horror',
                     'PC, PS5, Xbox', 'Одиночная'),
                    (19, 'Resident Evil 2', 'Capcom', 'Capcom', '2019-01-25', 91, 'Survival Horror', 'PC, PS4, Xbox',
                     'Одиночная'),
                    (
                    20, 'Devil May Cry 5', 'Capcom', 'Capcom', '2019-03-08', 88, 'Action', 'PC, PS4, Xbox', 'Одиночная')
                ]

                self.cursor.executemany('''
                    INSERT INTO games (id, title, developer, publisher, release_date, 
                                      metacritic_score, genre, platform, game_modes)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                ''', games_data)

                # Вставляем данные во вторую таблицу
                game_details_data = [
                    (1, 'Unity', 1, 12, '-'),
                    (2, 'REDengine 4', 1, 18, '-'),
                    (3, 'Source 2', 1, 16, '-'),
                    (4, 'Source', 1, 12, '-'),
                    (5, 'GoldSrc', 1, 16, '-'),
                    (6, 'REDengine 3', 1, 18, '-'),
                    (7, 'RAGE', 1, 18, '-'),
                    (8, 'Naughty Dog Engine', 0, 18, '-'),
                    (9, 'Proprietary', 1, 18, '-'),
                    (10, 'Proprietary', 1, 16, '-'),
                    (11, 'Java', 1, 7, '-'),
                    (12, 'RAGE', 1, 18, '-'),
                    (13, 'Creation Engine', 1, 18, '-'),
                    (14, 'Proprietary', 1, 16, '-'),
                    (15, 'Proprietary', 0, 18, '-'),
                    (16, 'Proprietary', 1, 18, '-'),
                    (17, 'MT Framework', 1, 16, '-'),
                    (18, 'RE Engine', 1, 18, '-'),
                    (19, 'RE Engine', 1, 18, '-'),
                    (20, 'RE Engine', 1, 18, '-')
                ]

                self.cursor.executemany('''
                    INSERT INTO game_details (id, engine, russian_language, age_rating, system_requirements)
                    VALUES (?, ?, ?, ?, ?)
                ''', game_details_data)

                self.connection.commit()
                print(f"✓ Добавлено {len(games_data)} игр в базу данных")

            return True
        except Exception as e:
            print(f"Error initializing database: {e}")
            return False

    def get_all_games(self) -> List[Dict[str, Any]]:
        """Получить все игры с объединением двух таблиц"""
        try:
            self.cursor.execute('''
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                ORDER BY g.id
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games: {e}")
            return []

    def get_games_sorted_by_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                ORDER BY g.title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by title: {e}")
            return []

    def get_games_sorted_by_publisher_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                ORDER BY g.publisher, g.title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by publisher and title: {e}")
            return []

    def get_games_sorted_by_release_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                ORDER BY g.release_date, g.title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by release date and title: {e}")
            return []

    def get_games_sorted_by_metacritic_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                ORDER BY g.metacritic_score DESC, g.title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by metacritic score and title: {e}")
            return []

    def get_games_sorted_by_age_title(self) -> List[Dict[str, Any]]:
        try:
            self.cursor.execute('''
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                ORDER BY d.age_rating, g.title
            ''')
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error fetching games sorted by age rating and title: {e}")
            return []

    def search_by_title(self, title: str) -> List[Dict[str, Any]]:
        try:
            query = '''
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                WHERE g.title LIKE ?
                ORDER BY g.title
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
                SELECT g.*, d.engine, d.russian_language, d.age_rating, d.system_requirements
                FROM games g
                LEFT JOIN game_details d ON g.id = d.id
                WHERE g.publisher LIKE ?
                ORDER BY g.publisher, g.title
            '''
            self.cursor.execute(query, (f'%{publisher}%',))
            rows = self.cursor.fetchall()
            return [dict(row) for row in rows]
        except Exception as e:
            print(f"Error searching by publisher: {e}")
            return []