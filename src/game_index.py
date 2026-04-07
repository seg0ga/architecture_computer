from typing import List, Dict, Any, Optional
from src.optimal_tree import OptimalSearchTree


def digital_sort_by_title(games):
    """Цифровая сортировка по названию (поразрядная)"""
    if not games:
        return []

    # Берем копию
    arr = games.copy()

    # Находим максимальную длину строки
    max_len = 0
    for game in arr:
        title_len = len(game['title']) if game['title'] else 0
        if title_len > max_len:
            max_len = title_len

    # Сортировка по разрядам (от младшего к старшему)
    for pos in range(max_len - 1, -1, -1):
        # Используем словарь вместо списка для поддержки любых Unicode символов
        buckets = {}

        for game in arr:
            title = game['title'] if game['title'] else ''
            if pos < len(title):
                char_code = ord(title[pos])
            else:
                char_code = 0  # Если строка короче, ставим в начало
            
            if char_code not in buckets:
                buckets[char_code] = []
            buckets[char_code].append(game)

        # Собираем обратно по возрастанию кодов символов
        arr = []
        for char_code in sorted(buckets.keys()):
            arr.extend(buckets[char_code])

    return arr


class GameIndex:
    def __init__(self, games: List[Dict[str, Any]]):
        self.games = games
        self.trees = {}
        self.build_all_indexes()

    def build_all_indexes(self):
        # Для названий используем цифровую сортировку
        self.sorted_by_title = digital_sort_by_title(self.games)

        # Остальные деревья оставляем как есть (упрощенные)
        self.trees['publisher'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['publisher'].lower() if x['publisher'] else '', x['title'].lower())
        )
        self.trees['publisher'].build()

        self.trees['release_date'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (str(x['release_date']) if x['release_date'] else '0001-01-01', x['title'].lower())
        )
        self.trees['release_date'].build()

        self.trees['metacritic_score'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (-x['metacritic_score'] if x['metacritic_score'] else 0, x['title'].lower())
        )
        self.trees['metacritic_score'].build()

        self.trees['age_rating'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['age_rating'] if x['age_rating'] else 0, x['title'].lower())
        )
        self.trees['age_rating'].build()

    def get_sorted_by(self, sort_type: str) -> List[Dict[str, Any]]:
        if sort_type == 'title':
            return self.sorted_by_title
        if sort_type not in self.trees:
            return []
        return self.trees[sort_type].inorder_traversal()

    def search_by_title(self, title: str) -> List[Dict[str, Any]]:
        """Поиск по названию (простой перебор)"""
        results = []
        for game in self.games:
            if title.lower() in game['title'].lower():
                results.append(game)
        return results

    def search_by_publisher(self, publisher: str) -> List[Dict[str, Any]]:
        """Поиск по издателю"""
        results = []
        for game in self.games:
            game_publisher = game.get('publisher')
            if game_publisher and publisher.lower() in game_publisher.lower():
                results.append(game)
        return results

    def search_exact(self, sort_type: str, key: Any) -> Optional[Dict[str, Any]]:
        if sort_type == 'title':
            for game in self.games:
                if game['title'].lower() == str(key).lower():
                    return game
            return None
        if sort_type not in self.trees:
            return None
        return self.trees[sort_type].search(key)

    def get_statistics(self) -> Dict[str, Dict[str, Any]]:
        stats = {}
        # Для названий своя статистика
        stats['title'] = {
            'height': 0,
            'nodes': len(self.games),
            'total_weighted_height': 0,
            'avg_weighted_height': 0
        }
        for name, tree in self.trees.items():
            stats[name] = tree.get_statistics()
        return stats