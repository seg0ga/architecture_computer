# Запись №2
### 22.03.2026 Демин С. - Начата работа над базой данных (разделение таблиц)
#### Структура БД (таблица 1)
|id|title|developer|publisher|release_date|metacritic_score|genre|platform|game_modes|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| 1 | Phasmophobia | Kinetic Games | Kinetic Games | 2020-09-18 | 79 | Хоррор, Симулятор | PC |Одиночная, Мультиплеер, Кооператив |
| 2 | Cyberpunk 2077 | CD Projekt Red | CD Projekt | 2020-12-10 | 86 | RPG, Open World | PC, PS5, Xbox |Одиночная |REDengine 4|✅|18|-|
|...|...|...|...|...|...|...|...|...|...|
| n | CS2 | Valve | Valve | 2023-09-27 | 83 | Шутер, Тактический | PC  | Мультиплеер |Source 2|✅|16|-|


#### Структура БД (таблица 2)
|id|engine|russian_language|age_rating|system_requirements|
|:-:|:-:|:-:|:-:|:-:|
|1|Unity|✅|12|-|
|2|REDengine 4|✅|18|-|
|...|...|...|...|...|
|n|Source 2|✅|16|-|


#### Описание полей
|Поле|Тип данных|Описание|Пример|
|:-:|:-:|:-:|:-:|
|id|INT|Уникальный идентификатор игры. Самогенерится|1|
|title|VARCHAR(100)|Название игры|Phasmophobia|
|developer|VARCHAR(100)|Разработчик|Kinetic Games|
|publisher|VARCHAR(100)|Издатель|Kinetic Games|
|release_date|DATE|Дата выхода игры|2020-09-18|
|metacritic_score|INT|Оценка на Metacritic|79|
|genre|VARCHAR(100)|Жанр игры|Хоррор|
|platform|VARCHAR(255)|Платформа|PC, XBOX|
|cover|VARCHAR(100)|Ссылка на обложку||
|game_modes|VARCHAR(100)|Режимы игры|Кооператив|
|engine|VARCHAR(100)|Движок игры|Unity|
|russian_language|BOOLEAN|Наличие русского языка|TRUE|
|age_rating|INT|Возрастной рейтинг|16|
|system requirements|TEXT|Системные требования|-|


#### Сортировка через построение дерева
Сортрировка **должна** осуществляться по 5 полям:
1. По названию
2. По издателю+названию
3. По дате выхода+названию
4. По оценке не метакритике+названию
5. По возрастным ограничениям+названию



# Список игр в базе данных (200 игр)

1. Phasmophobia
2. Cyberpunk 2077
3. CS2
4. Portal
5. Half-Life
6. The Witcher 3: Wild Hunt
7. Red Dead Redemption 2
8. The Last of Us Part II
9. God of War
10. Elden Ring
11. Minecraft
12. Grand Theft Auto V
13. Skyrim
14. Dark Souls III
15. Bloodborne
16. Sekiro: Shadows Die Twice
17. Monster Hunter: World
18. Resident Evil Village
19. Resident Evil 2
20. Devil May Cry 5



#### ПРОТОТИП GUI
![IMG_20260317_153329_245](https://github.com/user-attachments/assets/2a322af6-44f9-4c77-825e-6ebb06eb7091)
![IMG_20260317_153329_966](https://github.com/user-attachments/assets/4016d5e4-1ca6-4ebc-a4c4-e3425b2bab88)
![IMG_20260317_153329_435](https://github.com/user-attachments/assets/7a7b6216-4d46-4435-8866-ddc3c0f94098)

