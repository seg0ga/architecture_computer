from typing import List, Dict, Any, Optional
from optimal_tree import OptimalSearchTree


def digital_sort_by_title(games):
    """Цифровая сортировка по названию (поразрядная)"""
    if not games:
        return []

    # Берем копию
    arr = games.copy()

    # Находим максимальную длину строки
    max_len = 0
    for game in arr:
        title_len = len(game['title'])
        if title_len > max_len:
            max_len = title_len

    # Сортировка по разрядам (от младшего к старшему)
    for pos in range(max_len - 1, -1, -1):
        # Создаем корзины (ASCII символы)
        buckets = [[] for _ in range(256)]

        for game in arr:
            title = game['title']
            if pos < len(title):
                char_code = ord(title[pos])
            else:
                char_code = 0  # Если строка короче, ставим в начало
            buckets[char_code].append(game)

        # Собираем обратно
        arr = []
        for bucket in buckets:
            arr.extend(bucket)

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
        self.trees['publisher_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['publisher'].lower(), x['title'].lower())
        )
        self.trees['publisher_title'].build()

        self.trees['release_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['release_date'], x['title'].lower())
        )
        self.trees['release_title'].build()

        self.trees['metacritic_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (-x['metacritic_score'], x['title'].lower())
        )
        self.trees['metacritic_title'].build()

        self.trees['age_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['age_rating'], x['title'].lower())
        )
        self.trees['age_title'].build()

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
            if publisher.lower() in game['publisher'].lower():
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