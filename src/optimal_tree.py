from typing import List, Dict, Any, Optional
import numpy as np


class TreeNode:
    def __init__(self, key: Any, data: Dict[str, Any], weight: int = 1):
        self.key = key
        self.data = data
        self.weight = weight
        self.left = None
        self.right = None


class OptimalSearchTree:
    def __init__(self, items: List[Dict[str, Any]], key_func, weight_func=None):
        self.items = items
        self.key_func = key_func
        self.weight_func = weight_func or (lambda x: 1)
        self.n = len(items)

        # Сортируем элементы по ключу
        self.sorted_items = sorted(items, key=lambda x: key_func(x))
        self.keys = [key_func(item) for item in self.sorted_items]
        self.weights = [self.weight_func(item) for item in self.sorted_items]

        # Матрицы для динамического программирования
        self.AW = np.zeros((self.n + 1, self.n + 1), dtype=int)
        self.AP = np.zeros((self.n + 1, self.n + 1), dtype=int)
        self.AR = np.zeros((self.n + 1, self.n + 1), dtype=int)

        self.root = None

    def build(self):
        """Построение дерева оптимального поиска"""
        if self.n == 0:
            return

        # Шаг 1: Вычисление матрицы весов AW
        for i in range(self.n + 1):
            for j in range(i + 1, self.n + 1):
                self.AW[i][j] = self.AW[i][j - 1] + self.weights[j - 1]

        # Шаг 2: Инициализация для поддеревьев из одной вершины
        for i in range(self.n):
            self.AP[i][i + 1] = self.AW[i][i + 1]
            self.AR[i][i + 1] = i + 1

        # Шаг 3: Вычисление для поддеревьев большей длины
        for h in range(2, self.n + 1):
            for i in range(0, self.n - h + 1):
                j = i + h

                left_bound = self.AR[i][j - 1] if j > i + 1 else i + 1
                right_bound = self.AR[i + 1][j] if i + 1 < j else j

                min_val = float('inf')
                best_k = left_bound

                for k in range(int(left_bound), int(right_bound) + 1):
                    if k - 1 < i or k > j:
                        continue
                    current = self.AP[i][k - 1] + self.AP[k][j]
                    if current < min_val:
                        min_val = current
                        best_k = k

                self.AP[i][j] = self.AW[i][j] + min_val
                self.AR[i][j] = best_k

        # Шаг 4: Построение дерева
        self.root = self._build_subtree(0, self.n)

    def _build_subtree(self, left: int, right: int) -> Optional[TreeNode]:
        if left >= right:
            return None

        k = int(self.AR[left][right])
        if k == 0:
            return None

        idx = k - 1
        node = TreeNode(
            key=self.keys[idx],
            data=self.sorted_items[idx],
            weight=self.weights[idx]
        )

        node.left = self._build_subtree(left, k - 1)
        node.right = self._build_subtree(k, right)

        return node

    def search(self, key: Any) -> Optional[Dict[str, Any]]:
        node = self.root
        comparisons = 0

        while node:
            comparisons += 1
            if key == node.key:
                node.data['comparisons'] = comparisons
                return node.data
            elif key < node.key:
                node = node.left
            else:
                node = node.right

        return None

    def search_partial(self, key_partial: str) -> List[Dict[str, Any]]:
        results = []
        self._partial_search(self.root, key_partial, results)
        return results

    def _partial_search(self, node: Optional[TreeNode], key_partial: str, results: List):
        if not node:
            return

        if key_partial.lower() in str(node.key).lower():
            results.append(node.data)

        self._partial_search(node.left, key_partial, results)
        self._partial_search(node.right, key_partial, results)

    def inorder_traversal(self) -> List[Dict[str, Any]]:
        result = []
        self._inorder(self.root, result)
        return result

    def _inorder(self, node: Optional[TreeNode], result: List):
        if not node:
            return
        self._inorder(node.left, result)
        result.append(node.data)
        self._inorder(node.right, result)

    def get_statistics(self) -> Dict[str, Any]:
        if not self.root:
            return {'height': 0, 'nodes': 0, 'avg_weighted_height': 0}

        total_weight = sum(self.weights)
        stats = {'height': 0, 'total_weighted_height': 0}

        self._calc_statistics(self.root, 1, stats)

        return {
            'height': stats['height'],
            'nodes': self.n,
            'total_weighted_height': stats['total_weighted_height'],
            'avg_weighted_height': stats['total_weighted_height'] / total_weight if total_weight > 0 else 0
        }

    def _calc_statistics(self, node: Optional[TreeNode], depth: int, stats: Dict):
        if not node:
            return

        stats['height'] = max(stats['height'], depth)
        stats['total_weighted_height'] += depth * node.weight

        self._calc_statistics(node.left, depth + 1, stats)
        self._calc_statistics(node.right, depth + 1, stats)

    def print_tree(self, node: Optional[TreeNode] = None, level: int = 0):
        if node is None:
            node = self.root
            if node is None:
                print("Дерево пусто")
                return

        if node.right:
            self.print_tree(node.right, level + 1)

        print('    ' * level + f"└── {node.key} (вес: {node.weight})")

        if node.left:
            self.print_tree(node.left, level + 1)