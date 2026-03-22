import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.db_manager import DatabaseManager
from src.game_index import GameIndex
import time


def print_games(games: list, title: str = ""):
    """Вывод списка игр в читаемом формате"""
    if title:
        print(f"\n{title}")
    print("\n" + "=" * 140)
    print(f"{'№':<4} {'Название':<35} {'Издатель':<20} {'Дата':<12} {'Оценка':<8} {'Возраст':<8} {'Движок':<15}")
    print("=" * 140)

    for i, game in enumerate(games, 1):
        title_text = game['title'][:33] + '..' if len(game['title']) > 35 else game['title']
        publisher = game['publisher'][:18] + '..' if len(game['publisher']) > 20 else game['publisher']
        release_date = str(game['release_date'])[:10] if game['release_date'] else 'N/A'
        score = game['metacritic_score'] or 0
        age = game['age_rating'] or 0
        engine = game['engine'][:13] + '..' if len(game.get('engine', '')) > 15 else game.get('engine', 'N/A')

        print(f"{i:<4} {title_text:<35} {publisher:<20} {release_date:<12} {score:<8} {age:<8} {engine:<15}")

    print("=" * 140)
    print(f"Всего игр: {len(games)}")


def main():
    print("=" * 140)
    print(" " * 45 + "СИСТЕМА ОПТИМАЛЬНОГО ПОИСКА ИГР")
    print("=" * 140)

    db = DatabaseManager('database/games.db')

    if not db.connect():
        print("Не удалось подключиться к базе данных.")
        return

    print("✓ Подключение к базе данных установлено")

    if not db.init_database():
        print("Ошибка при инициализации базы данных")
        return

    games = db.get_all_games()
    print(f"✓ Загружено {len(games)} игр")

    print("\nПостроение деревьев оптимального поиска...")
    start_time = time.time()
    index = GameIndex(games)
    build_time = time.time() - start_time
    print(f"✓ Индексы построены за {build_time:.3f} секунд")

    while True:
        print("\n" + "=" * 140)
        print("МЕНЮ:")
        print("1. Вывести исходный список игр")
        print("2. Вывести игры, отсортированные по названию")
        print("3. Вывести игры, отсортированные по издателю + названию")
        print("4. Вывести игры, отсортированные по дате выхода + названию")
        print("5. Вывести игры, отсортированные по оценке Metacritic + названию")
        print("6. Вывести игры, отсортированные по возрастному рейтингу + названию")
        print("7. Поиск по названию")
        print("8. Поиск по издателю")
        print("9. Вывести статистику")
        print("10. Показать структуру дерева (по названию)")
        print("0. Выход")

        choice = input("\nВыберите действие: ")

        if choice == '1':
            print_games(games, "ИСХОДНЫЙ СПИСОК ИГР:")
        elif choice == '2':
            print_games(index.get_sorted_by('title'), "СОРТИРОВКА ПО НАЗВАНИЮ:")
        elif choice == '3':
            print_games(index.get_sorted_by('publisher_title'), "СОРТИРОВКА ПО ИЗДАТЕЛЮ + НАЗВАНИЮ:")
        elif choice == '4':
            print_games(index.get_sorted_by('release_title'), "СОРТИРОВКА ПО ДАТЕ ВЫХОДА + НАЗВАНИЮ:")
        elif choice == '5':
            print_games(index.get_sorted_by('metacritic_title'), "СОРТИРОВКА ПО ОЦЕНКЕ METACRITIC + НАЗВАНИЮ:")
        elif choice == '6':
            print_games(index.get_sorted_by('age_title'), "СОРТИРОВКА ПО ВОЗРАСТНЫМ ОГРАНИЧЕНИЯМ + НАЗВАНИЮ:")
        elif choice == '7':
            query = input("Введите название (или часть названия): ")
            start_time = time.time()
            results = index.search_by_title(query)
            search_time = time.time() - start_time
            print(f"\nНайдено {len(results)} игр за {search_time:.4f} сек:")
            if results:
                print_games(results)
            else:
                print("Игры не найдены")
        elif choice == '8':
            query = input("Введите название издателя (или часть): ")
            start_time = time.time()
            results = index.search_by_publisher(query)
            search_time = time.time() - start_time
            print(f"\nНайдено {len(results)} игр за {search_time:.4f} сек:")
            if results:
                print_games(results)
            else:
                print("Игры не найдены")
        elif choice == '9':
            stats = index.get_statistics()
            print("\n=== Детальная статистика ===")
            for tree_name, tree_stats in stats.items():
                sort_names = {
                    'title': 'По названию',
                    'publisher_title': 'По издателю + названию',
                    'release_title': 'По дате выхода + названию',
                    'metacritic_title': 'По оценке Metacritic + названию',
                    'age_title': 'По возрастным ограничениям + названию'
                }
                print(f"\n{sort_names.get(tree_name, tree_name)}:")
                print(f"  • Количество узлов: {tree_stats['nodes']}")
                print(f"  • Высота дерева: {tree_stats['height']}")
                print(f"  • Суммарная взвешенная высота: {tree_stats['total_weighted_height']}")
                print(f"  • Средневзвешенная высота: {tree_stats['avg_weighted_height']:.3f}")
        elif choice == '10':
            print("\n=== СТРУКТУРА ДЕРЕВА ОПТИМАЛЬНОГО ПОИСКА (по названию) ===")
            index.print_tree('title')
            print("\nПримечание: числа в скобках - веса узлов (все веса = 1)")
        elif choice == '0':
            print("\nДо свидания!")
            break
        else:
            print("Неверный выбор. Попробуйте снова.")

    db.disconnect()


if __name__ == "__main__":
    main()