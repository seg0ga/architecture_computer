-- Создание базы данных
CREATE DATABASE IF NOT EXISTS games_db;
USE games_db;

-- Таблица игр
CREATE TABLE IF NOT EXISTS games (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    developer VARCHAR(100),
    publisher VARCHAR(100),
    release_date DATE,
    metacritic_score INT,
    genre VARCHAR(100),
    platform VARCHAR(255),
    cover VARCHAR(100),
    game_modes VARCHAR(100),
    engine VARCHAR(100),
    russian_language BOOLEAN,
    age_rating INT,
    system_requirements TEXT,
    INDEX idx_title (title),
    INDEX idx_publisher (publisher),
    INDEX idx_release_date (release_date),
    INDEX idx_metacritic_score (metacritic_score),
    INDEX idx_age_rating (age_rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Вставка данных (20 игр)
INSERT INTO games (id, title, developer, publisher, release_date, metacritic_score, genre, platform, game_modes, engine, russian_language, age_rating, system_requirements) VALUES
(1, 'Phasmophobia', 'Kinetic Games', 'Kinetic Games', '2020-09-18', 79, 'Хоррор, Симулятор', 'PC', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12, '-'),
(2, 'Cyberpunk 2077', 'CD Projekt Red', 'CD Projekt', '2020-12-10', 86, 'RPG, Open World', 'PC, PS5, Xbox', 'Одиночная', 'REDengine 4', TRUE, 18, '-'),
(3, 'CS2', 'Valve', 'Valve', '2023-09-27', 83, 'Шутер, Тактический', 'PC', 'Мультиплеер', 'Source 2', TRUE, 16, '-'),
(4, 'Portal', 'Valve', 'Valve', '2007-10-10', 90, 'Головоломка', 'PC, PS3, Xbox', 'Одиночная', 'Source', TRUE, 12, '-'),
(5, 'Half-Life', 'Valve', 'Valve', '1998-11-19', 96, 'Шутер', 'PC, PS2', 'Одиночная', 'GoldSrc', TRUE, 16, '-'),
(6, 'The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', '2015-05-19', 92, 'RPG, Open World', 'PC, PS4, Xbox', 'Одиночная', 'REDengine 3', TRUE, 18, '-'),
(7, 'Red Dead Redemption 2', 'Rockstar Games', 'Rockstar Games', '2019-11-05', 97, 'Action, Open World', 'PC, PS4, Xbox', 'Одиночная', 'RAGE', TRUE, 18, '-'),
(8, 'The Last of Us Part II', 'Naughty Dog', 'Sony', '2020-06-19', 93, 'Action, Adventure', 'PS4', 'Одиночная', 'Naughty Dog Engine', FALSE, 18, '-'),
(9, 'God of War', 'Santa Monica Studio', 'Sony', '2018-04-20', 94, 'Action, Adventure', 'PC, PS4', 'Одиночная', 'Proprietary', TRUE, 18, '-'),
(10, 'Elden Ring', 'FromSoftware', 'Bandai Namco', '2022-02-25', 96, 'RPG, Action', 'PC, PS5, Xbox', 'Одиночная', 'Proprietary', TRUE, 16, '-'),
(11, 'Minecraft', 'Mojang', 'Microsoft', '2011-11-18', 93, 'Sandbox, Survival', 'PC, PS, Xbox', 'Одиночная, Мультиплеер', 'Java', TRUE, 7, '-'),
(12, 'Grand Theft Auto V', 'Rockstar North', 'Rockstar Games', '2013-09-17', 97, 'Action, Open World', 'PC, PS4, Xbox', 'Одиночная', 'RAGE', TRUE, 18, '-'),
(13, 'Skyrim', 'Bethesda', 'Bethesda', '2011-11-11', 94, 'RPG, Open World', 'PC, PS4, Xbox', 'Одиночная', 'Creation Engine', TRUE, 18, '-'),
(14, 'Dark Souls III', 'FromSoftware', 'Bandai Namco', '2016-04-12', 89, 'RPG, Action', 'PC, PS4, Xbox', 'Одиночная', 'Proprietary', TRUE, 16, '-'),
(15, 'Bloodborne', 'FromSoftware', 'Sony', '2015-03-24', 92, 'RPG, Action', 'PS4', 'Одиночная', 'Proprietary', FALSE, 18, '-'),
(16, 'Sekiro: Shadows Die Twice', 'FromSoftware', 'Activision', '2019-03-22', 90, 'Action', 'PC, PS4, Xbox', 'Одиночная', 'Proprietary', TRUE, 18, '-'),
(17, 'Monster Hunter: World', 'Capcom', 'Capcom', '2018-01-26', 90, 'Action, RPG', 'PC, PS4, Xbox', 'Одиночная, Кооператив', 'MT Framework', TRUE, 16, '-'),
(18, 'Resident Evil Village', 'Capcom', 'Capcom', '2021-05-07', 84, 'Survival Horror', 'PC, PS5, Xbox', 'Одиночная', 'RE Engine', TRUE, 18, '-'),
(19, 'Resident Evil 2', 'Capcom', 'Capcom', '2019-01-25', 91, 'Survival Horror', 'PC, PS4, Xbox', 'Одиночная', 'RE Engine', TRUE, 18, '-'),
(20, 'Devil May Cry 5', 'Capcom', 'Capcom', '2019-03-08', 88, 'Action', 'PC, PS4, Xbox', 'Одиночная', 'RE Engine', TRUE, 18, '-');