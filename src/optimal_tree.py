from typing import List, Dict, Any, Optional


class TreeNode:
    def __init__(self, key, data, weight=1):
        self.key = key
        self.data = data
        self.weight = weight
        self.left = None
        self.right = None


class OptimalSearchTree:
    """Упрощенная версия - только для совместимости"""

    def __init__(self, items: List[Dict[str, Any]], key_func, weight_func=None):
        self.items = items
        self.key_func = key_func
        self.weight_func = weight_func or (lambda x: 1)
        self.n = len(items)
        self.root = None

        # Сортируем и сохраняем
        self.sorted_items = sorted(items, key=lambda x: key_func(x))
        self.keys = [key_func(item) for item in self.sorted_items]
        self.weights = [self.weight_func(item) for item in self.sorted_items]

    def build(self):
        """Строим обычное бинарное дерево (не оптимальное)"""
        if self.n == 0:
            return
        self.root = self._build_balanced(0, self.n - 1)

    def _build_balanced(self, left, right):
        if left > right:
            return None

        mid = (left + right) // 2
        node = TreeNode(
            key=self.keys[mid],
            data=self.sorted_items[mid],
            weight=self.weights[mid]
        )
        node.left = self._build_balanced(left, mid - 1)
        node.right = self._build_balanced(mid + 1, right)
        return node

    def search(self, key):
        """Обычный поиск"""
        node = self.root
        while node:
            if key == node.key:
                return node.data
            elif key < node.key:
                node = node.left
            else:
                node = node.right
        return None

    def search_partial(self, key_partial):
        """Частичный поиск (просто перебор)"""
        results = []
        for item in self.sorted_items:
            if key_partial.lower() in str(self.key_func(item)).lower():
                results.append(item)
        return results

    def inorder_traversal(self):
        """Обход дерева"""
        result = []
        self._inorder(self.root, result)
        return result

    def _inorder(self, node, result):
        if not node:
            return
        self._inorder(node.left, result)
        result.append(node.data)
        self._inorder(node.right, result)

    def get_statistics(self):
        """Простая статистика"""
        if not self.root:
            return {'height': 0, 'nodes': 0, 'avg_weighted_height': 0}

        stats = {'height': 0, 'total_weighted_height': 0}
        self._calc_stats(self.root, 1, stats)

        total_weight = sum(self.weights) if self.weights else 1
        return {
            'height': stats['height'],
            'nodes': self.n,
            'total_weighted_height': stats['total_weighted_height'],
            'avg_weighted_height': stats['total_weighted_height'] / total_weight
        }

    def _calc_stats(self, node, depth, stats):
        if not node:
            return
        stats['height'] = max(stats['height'], depth)
        stats['total_weighted_height'] += depth * node.weight
        self._calc_stats(node.left, depth + 1, stats)
        self._calc_stats(node.right, depth + 1, stats)