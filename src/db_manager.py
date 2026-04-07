import json
import os
from typing import List, Dict, Any, Optional
from datetime import date


class DatabaseManager:
    def __init__(self, db_file=None):
        self.db_file = db_file or os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'games_db.json')
        self.data = {
            'games': [],
            'system_requirements': []
        }
        self.next_game_id = 1
        self.next_requirement_id = 1

    def connect(self):
        """Подключение к файловой базе данных"""
        try:
            if os.path.exists(self.db_file):
                with open(self.db_file, 'r', encoding='utf-8') as f:
                    self.data = json.load(f)
                    # Определяем следующий ID
                    if self.data.get('games'):
                        self.next_game_id = max(g['id'] for g in self.data['games']) + 1
                    if self.data.get('system_requirements'):
                        self.next_requirement_id = max(r['id'] for r in self.data['system_requirements']) + 1
            return True
        except Exception as e:
            print(f"Ошибка подключения: {e}")
            return False

    def disconnect(self):
        """Отключение от базы данных"""
        self._save()

    def _save(self):
        """Сохранение данных в файл"""
        try:
            with open(self.db_file, 'w', encoding='utf-8') as f:
                json.dump(self.data, f, ensure_ascii=False, indent=2, default=str)
        except Exception as e:
            print(f"Ошибка сохранения: {e}")

    def init_database(self):
        """Инициализация базы данных"""
        if not self.data.get('games') or len(self.data['games']) == 0:
            # Загружаем данные из init_db.json если существует
            script_dir = os.path.dirname(os.path.abspath(__file__))
            json_file = os.path.join(script_dir, '..', 'init_db.json')

            if os.path.exists(json_file):
                try:
                    with open(json_file, 'r', encoding='utf-8') as f:
                        games_data = json.load(f)
                        self.data['games'] = games_data.get('games', [])
                        self.data['system_requirements'] = games_data.get('system_requirements', [])

                        # Обновляем счетчики ID
                        if self.data['games']:
                            self.next_game_id = max(g['id'] for g in self.data['games']) + 1
                        if self.data['system_requirements']:
                            self.next_requirement_id = max(r['id'] for r in self.data['system_requirements']) + 1

                        self._save()
                        print(f"Загружено {len(self.data['games'])} игр")
                        return True
                except Exception as e:
                    print(f"Ошибка загрузки из init_db.json: {e}")
                    return False
            else:
                print(f"Файл не найден: {json_file}")
                return False
        else:
            count = len(self.data['games'])
            print(f"В базе {count} игр")
            return True

    def get_all_games(self) -> List[Dict[str, Any]]:
        """Получить все игры"""
        return self.data.get('games', [])

    def add_game(self, title: str, developer: str, publisher: str, release_date: str,
                 metacritic_score: int, genre: str, platform: str, game_modes: str,
                 engine: str, russian_language: bool, age_rating: int, image_url: str = None) -> tuple:
        """Добавить игру. Возвращает (True, None) при успехе или (False, ошибка) при неудаче"""
        try:
            game = {
                'id': self.next_game_id,
                'title': title,
                'developer': developer,
                'publisher': publisher,
                'release_date': release_date,
                'metacritic_score': metacritic_score,
                'genre': genre,
                'platform': platform,
                'game_modes': game_modes,
                'engine': engine,
                'russian_language': bool(russian_language),
                'age_rating': age_rating,
                'executable_path': None,
                'image_url': image_url
            }
            self.data['games'].append(game)
            game_id = self.next_game_id
            self.next_game_id += 1
            self._save()

            print(f"Добавлена игра: {title} (ID={game_id})")
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при добавлении игры: {str(e)}"
            print(error_msg)
            import traceback
            traceback.print_exc()
            return (False, error_msg)

    def update_executable_path(self, game_id: int, executable_path: Optional[str]) -> tuple:
        """Обновить путь к исполняемому файлу игры. Возвращает (True, None) или (False, ошибка)"""
        try:
            for game in self.data['games']:
                if game['id'] == game_id:
                    game['executable_path'] = executable_path
                    self._save()
                    print(f"Обновлен путь для игры ID={game_id}: {executable_path}")
                    return (True, None)
            error_msg = f"Игра с ID={game_id} не найдена"
            print(error_msg)
            return (False, error_msg)
        except Exception as e:
            error_msg = f"Ошибка при обновлении пути: {str(e)}"
            print(error_msg)
            return (False, error_msg)

    def update_image_url(self, game_id: int, image_url: Optional[str]) -> tuple:
        """Обновить URL изображения игры. Возвращает (True, None) или (False, ошибка)"""
        try:
            for game in self.data['games']:
                if game['id'] == game_id:
                    game['image_url'] = image_url
                    self._save()
                    print(f"Обновлен URL изображения для игры ID={game_id}: {image_url}")
                    return (True, None)
            error_msg = f"Игра с ID={game_id} не найдена"
            print(error_msg)
            return (False, error_msg)
        except Exception as e:
            error_msg = f"Ошибка при обновлении изображения: {str(e)}"
            print(error_msg)
            return (False, error_msg)

    def delete_game(self, game_id: int) -> tuple:
        """Удалить игру по ID. Возвращает (True, None) или (False, ошибка)"""
        try:
            for i, game in enumerate(self.data['games']):
                if game['id'] == game_id:
                    deleted_game = self.data['games'].pop(i)
                    # Также удаляем системные требования
                    self.data['system_requirements'] = [
                        r for r in self.data['system_requirements'] if r['game_id'] != game_id
                    ]
                    self._save()
                    print(f"Удалена игра ID={game_id}")
                    return (True, None)
            error_msg = f"Игра с ID={game_id} не найдена"
            print(error_msg)
            return (False, error_msg)
        except Exception as e:
            error_msg = f"Ошибка при удалении игры: {str(e)}"
            print(error_msg)
            return (False, error_msg)

    def get_system_requirements(self, game_id: int) -> Optional[Dict[str, Any]]:
        """Получить системные требования игры"""
        try:
            for req in self.data.get('system_requirements', []):
                if req['game_id'] == game_id:
                    return req
            return None
        except Exception as e:
            print(f"Ошибка: {e}")
            return None

    def update_system_requirements(self, game_id: int, requirements: Dict[str, Any]) -> tuple:
        """Обновить системные требования. Возвращает (True, None) или (False, ошибка)"""
        try:
            # Ищем существующую запись
            existing_req = None
            for req in self.data.get('system_requirements', []):
                if req['game_id'] == game_id:
                    existing_req = req
                    break

            if existing_req:
                # Обновляем существующую запись
                existing_req.update(requirements)
            else:
                # Создаем новую запись
                new_req = {
                    'id': self.next_requirement_id,
                    'game_id': game_id,
                    **requirements
                }
                self.data['system_requirements'].append(new_req)
                self.next_requirement_id += 1

            self._save()
            print(f"Обновлены системные требования для игры ID={game_id}")
            return (True, None)
        except Exception as e:
            error_msg = f"Ошибка при обновлении требований: {str(e)}"
            print(error_msg)
            return (False, error_msg)

    def get_game_by_id(self, game_id: int) -> Optional[Dict[str, Any]]:
        """Получить игру по ID"""
        try:
            for game in self.data['games']:
                if game['id'] == game_id:
                    return game
            return None
        except Exception as e:
            print(f"Ошибка: {e}")
            return None
