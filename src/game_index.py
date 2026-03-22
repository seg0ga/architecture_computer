from typing import List, Dict, Any, Optional
from src.optimal_tree import OptimalSearchTree


class GameIndex:
    def __init__(self, games: List[Dict[str, Any]]):
        self.games = games
        self.trees = {}
        self.build_all_indexes()

    def build_all_indexes(self):
        # 1. По названию
        self.trees['title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: x['title'].lower(),
            weight_func=lambda x: 1
        )
        self.trees['title'].build()

        # 2. По издателю + названию
        self.trees['publisher_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['publisher'].lower(), x['title'].lower()),
            weight_func=lambda x: 1
        )
        self.trees['publisher_title'].build()

        # 3. По дате выхода + названию
        self.trees['release_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['release_date'], x['title'].lower()),
            weight_func=lambda x: 1
        )
        self.trees['release_title'].build()

        # 4. По оценке на метакритике + названию
        self.trees['metacritic_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (-x['metacritic_score'], x['title'].lower()),
            weight_func=lambda x: 1
        )
        self.trees['metacritic_title'].build()

        # 5. По возрастным ограничениям + названию
        self.trees['age_title'] = OptimalSearchTree(
            self.games,
            key_func=lambda x: (x['age_rating'], x['title'].lower()),
            weight_func=lambda x: 1
        )
        self.trees['age_title'].build()

    def get_sorted_by(self, sort_type: str) -> List[Dict[str, Any]]:
        if sort_type not in self.trees:
            raise ValueError(f"Unknown sort type: {sort_type}")
        return self.trees[sort_type].inorder_traversal()

    def search_by_title(self, title: str) -> List[Dict[str, Any]]:
        return self.trees['title'].search_partial(title)

    def search_by_publisher(self, publisher: str) -> List[Dict[str, Any]]:
        return self.trees['publisher_title'].search_partial(publisher)

    def search_exact(self, sort_type: str, key: Any) -> Optional[Dict[str, Any]]:
        if sort_type not in self.trees:
            raise ValueError(f"Unknown sort type: {sort_type}")
        return self.trees[sort_type].search(key)

    def get_statistics(self) -> Dict[str, Dict[str, Any]]:
        stats = {}
        for name, tree in self.trees.items():
            stats[name] = tree.get_statistics()
        return stats

    def print_tree(self, sort_type: str):
        if sort_type in self.trees:
            print(f"\n=== Дерево оптимального поиска ({sort_type}) ===")
            self.trees[sort_type].print_tree()