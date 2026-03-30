

CREATE TABLE IF NOT EXISTS games (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    developer VARCHAR(100),
    publisher VARCHAR(100),
    release_date DATE,
    metacritic_score INT,
    genre VARCHAR(100),
    platform VARCHAR(255),
    game_modes VARCHAR(100),
    engine VARCHAR(100),
    russian_language BOOLEAN DEFAULT FALSE,
    age_rating INT,
    executable_path VARCHAR(500)
);

-- Insert 200 games
INSERT INTO games (title, developer, publisher, release_date, metacritic_score, genre, platform, game_modes, engine, russian_language, age_rating, executable_path) VALUES
-- 1-10
('Phasmophobia', 'Kinetic Games', 'Kinetic Games', '2020-09-18', 79, 'Хоррор, Симулятор', 'PC', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12, NULL),
('Cyberpunk 2077', 'CD Projekt Red', 'CD Projekt', '2020-12-10', 86, 'RPG, Open World', 'PC, PS5, Xbox', 'Одиночная', 'REDengine 4', TRUE, 18, NULL),
('CS2', 'Valve', 'Valve', '2023-09-27', 83, 'Шутер, Тактический', 'PC', 'Мультиплеер', 'Source 2', TRUE, 16, NULL),
('Portal', 'Valve', 'Valve', '2007-10-09', 90, 'Головоломка', 'PC, Xbox, PS3', 'Одиночная', 'Source', TRUE, 12, NULL),
('Half-Life', 'Valve', 'Sierra Studios', '1998-11-19', 96, 'Шутер, Научная фантастика', 'PC', 'Одиночная', 'GoldSrc', TRUE, 16, NULL),
('The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', '2015-05-19', 93, 'RPG, Open World', 'PC, PS4, Xbox, Switch', 'Одиночная', 'REDengine 3', TRUE, 18, NULL),
('Red Dead Redemption 2', 'Rockstar Games', 'Rockstar Games', '2019-11-05', 93, 'Action, Open World', 'PC, PS4, Xbox', 'Одиночная, Мультиплеер', 'RAGE', TRUE, 18, NULL),
('The Last of Us Part II', 'Naughty Dog', 'Sony Interactive Entertainment', '2020-06-19', 93, 'Action, Survival Horror', 'PS4, PS5', 'Одиночная', 'Naughty Dog Engine', FALSE, 18, NULL),
('God of War', 'Santa Monica Studio', 'Sony Interactive Entertainment', '2022-01-14', 94, 'Action, Adventure', 'PC, PS4, PS5', 'Одиночная', 'Santa Monica Engine', TRUE, 18, NULL),
('Elden Ring', 'FromSoftware', 'Bandai Namco', '2022-02-25', 96, 'RPG, Action', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'FromSoftware Engine', TRUE, 18, NULL),

-- 11-20
('Minecraft', 'Mojang Studios', 'Xbox Game Studios', '2011-11-18', 93, 'Песочница, Выживание', 'PC, Mobile, Console', 'Одиночная, Мультиплеер', 'Java, Bedrock', TRUE, 6, NULL),
('Grand Theft Auto V', 'Rockstar North', 'Rockstar Games', '2015-04-14', 96, 'Action, Open World', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'RAGE', TRUE, 18, NULL),
('Skyrim', 'Bethesda Game Studios', 'Bethesda Softworks', '2011-11-11', 94, 'RPG, Open World', 'PC, PS4, Xbox, Switch', 'Одиночная', 'Creation Engine', TRUE, 18, NULL),
('Dark Souls III', 'FromSoftware', 'Bandai Namco', '2016-04-12', 89, 'RPG, Action', 'PC, PS4, Xbox', 'Одиночная, Мультиплеер', 'FromSoftware Engine', TRUE, 16, NULL),
('Bloodborne', 'FromSoftware', 'Sony Interactive Entertainment', '2015-03-24', 92, 'RPG, Action, Horror', 'PS4, PS5', 'Одиночная, Мультиплеер', 'FromSoftware Engine', FALSE, 18, NULL),
('Sekiro: Shadows Die Twice', 'FromSoftware', 'Activision', '2019-03-22', 90, 'Action, Adventure', 'PC, PS4, Xbox', 'Одиночная', 'FromSoftware Engine', TRUE, 18, NULL),
('Monster Hunter: World', 'Capcom', 'Capcom', '2018-08-09', 90, 'Action, RPG', 'PC, PS4, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'MT Framework', TRUE, 16, NULL),
('Resident Evil Village', 'Capcom', 'Capcom', '2021-05-07', 84, 'Хоррор, Выживание', 'PC, PS4, PS5, Xbox', 'Одиночная', 'RE Engine', TRUE, 18, NULL),
('Resident Evil 2', 'Capcom', 'Capcom', '2019-01-25', 91, 'Хоррор, Выживание', 'PC, PS4, Xbox', 'Одиночная', 'RE Engine', TRUE, 18, NULL),
('Devil May Cry 5', 'Capcom', 'Capcom', '2019-03-08', 88, 'Action, Hack and Slash', 'PC, PS4, Xbox', 'Одиночная, Кооператив', 'RE Engine', TRUE, 16, NULL),

-- 21-30
('Street Fighter 6', 'Capcom', 'Capcom', '2023-06-02', 92, 'Файтинг', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'RE Engine', TRUE, 12, NULL),
('Final Fantasy VII Remake', 'Square Enix', 'Square Enix', '2021-12-16', 89, 'RPG, Action', 'PC, PS4, PS5', 'Одиночная', 'Unreal Engine 4', TRUE, 16, NULL),
('Final Fantasy XIV', 'Square Enix', 'Square Enix', '2013-08-27', 83, 'MMORPG', 'PC, PS4, PS5, Xbox', 'Мультиплеер, MMO', 'Custom', TRUE, 16, NULL),
('Kingdom Hearts III', 'Square Enix', 'Square Enix', '2019-01-29', 83, 'RPG, Action', 'PC, PS4, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 12, NULL),
('NieR: Automata', 'PlatinumGames', 'Square Enix', '2017-03-07', 88, 'Action, RPG', 'PC, PS4, Xbox', 'Одиночная', 'Platinum Engine', TRUE, 16, NULL),
('Persona 5 Royal', 'Atlus', 'Sega', '2022-10-21', 89, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Atlus Engine', TRUE, 16, NULL),
('Persona 4 Golden', 'Atlus', 'Sega', '2020-06-13', 85, 'RPG', 'PC, PS4, Xbox, Switch', 'Одиночная', 'Atlus Engine', TRUE, 12, NULL),
('Yakuza: Like a Dragon', 'Ryu Ga Gotoku Studio', 'Sega', '2020-11-10', 83, 'RPG', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Dragon Engine', TRUE, 18, NULL),
('Like a Dragon: Infinite Wealth', 'Ryu Ga Gotoku Studio', 'Sega', '2024-01-26', 89, 'RPG, Action', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Dragon Engine', TRUE, 18, NULL),
('Ghost of Tsushima', 'Sucker Punch Productions', 'Sony Interactive Entertainment', '2024-05-16', 87, 'Action, Adventure', 'PC, PS4, PS5', 'Одиночная, Мультиплеер', 'Decima', TRUE, 18, NULL),

-- 31-40
('Spider-Man Remastered', 'Insomniac Games', 'Sony Interactive Entertainment', '2022-08-12', 87, 'Action, Adventure', 'PC, PS4, PS5', 'Одиночная', 'Insomniac Engine', TRUE, 16, NULL),
('Spider-Man: Miles Morales', 'Insomniac Games', 'Sony Interactive Entertainment', '2022-11-18', 84, 'Action, Adventure', 'PC, PS4, PS5', 'Одиночная', 'Insomniac Engine', TRUE, 16, NULL),
('Ratchet & Clank: Rift Apart', 'Insomniac Games', 'Sony Interactive Entertainment', '2023-07-26', 88, 'Action, Adventure', 'PC, PS5', 'Одиночная', 'Insomniac Engine', TRUE, 12, NULL),
('Horizon Zero Dawn', 'Guerrilla Games', 'Sony Interactive Entertainment', '2020-08-07', 84, 'Action, RPG', 'PC, PS4, PS5', 'Одиночная', 'Decima', TRUE, 16, NULL),
('Horizon Forbidden West', 'Guerrilla Games', 'Sony Interactive Entertainment', '2024-03-21', 85, 'Action, RPG', 'PC, PS4, PS5', 'Одиночная', 'Decima', TRUE, 16, NULL),
('Death Stranding', 'Kojima Productions', '505 Games', '2020-07-14', 82, 'Action', 'PC, PS4, PS5', 'Одиночная, Мультиплеер', 'Decima', TRUE, 18, NULL),
('Death Stranding 2', 'Kojima Productions', 'Sony Interactive Entertainment', '2025-06-26', 85, 'Action', 'PS5', 'Одиночная', 'Decima', FALSE, 18, NULL),
('Metal Gear Solid V', 'Kojima Productions', 'Konami', '2015-09-01', 93, 'Action, Stealth', 'PC, PS4, Xbox', 'Одиночная, Мультиплеер', 'Fox Engine', TRUE, 18, NULL),
('Silent Hill 2', 'Bloober Team', 'Konami', '2024-10-08', 83, 'Хоррор', 'PC, PS5', 'Одиночная', 'Unreal Engine 5', TRUE, 18, NULL),
('Alan Wake 2', 'Remedy Entertainment', 'Epic Games', '2023-10-27', 89, 'Хоррор', 'PC, PS5, Xbox', 'Одиночная', 'Northlight Engine', TRUE, 18, NULL),

-- 41-50
('Control', 'Remedy Entertainment', '505 Games', '2019-08-27', 85, 'Action, Adventure', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Northlight Engine', TRUE, 16, NULL),
('Max Payne 3', 'Remedy Entertainment', 'Rockstar Games', '2012-05-15', 87, 'Шутер, Action', 'PC, PS3, Xbox', 'Одиночная, Мультиплеер', 'RAGE', TRUE, 18, NULL),
('Quantum Break', 'Remedy Entertainment', 'Microsoft Studios', '2016-09-29', 77, 'Action, Adventure', 'PC, Xbox', 'Одиночная', 'Northlight Engine', TRUE, 16, NULL),
('Deathloop', 'Arkane Studios', 'Bethesda Softworks', '2021-09-14', 88, 'Шутер, Action', 'PC, PS5', 'Одиночная, Мультиплеер', 'Unreal Engine 4', TRUE, 18, NULL),
('Dishonored 2', 'Arkane Studios', 'Bethesda Softworks', '2016-11-11', 88, 'Action, Stealth', 'PC, PS4, Xbox', 'Одиночная', 'Void Engine', TRUE, 18, NULL),
('Prey', 'Arkane Studios', 'Bethesda Softworks', '2017-05-05', 82, 'Шутер, Хоррор', 'PC, PS4, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('Doom Eternal', 'id Software', 'Bethesda Softworks', '2020-03-20', 88, 'Шутер', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер', 'id Tech 7', TRUE, 18, NULL),
('Doom (2016)', 'id Software', 'Bethesda Softworks', '2016-05-13', 85, 'Шутер', 'PC, PS4, Xbox, Switch', 'Одиночная, Мультиплеер', 'id Tech 6', TRUE, 18, NULL),
('Wolfenstein II: The New Colossus', 'MachineGames', 'Bethesda Softworks', '2017-10-27', 87, 'Шутер', 'PC, PS4, Xbox', 'Одиночная', 'id Tech 6', TRUE, 18, NULL),
('Hi-Fi Rush', 'Tango Gameworks', 'Bethesda Softworks', '2023-01-25', 87, 'Action, Ритм', 'PC, PS5, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 12, NULL),

-- 51-60
('The Evil Within 2', 'Tango Gameworks', 'Bethesda Softworks', '2017-10-13', 80, 'Хоррор, Выживание', 'PC, PS4, Xbox', 'Одиночная', 'Unreal Engine 3', TRUE, 18, NULL),
('Ghostwire: Tokyo', 'Tango Gameworks', 'Bethesda Softworks', '2022-03-25', 76, 'Action, Хоррор', 'PC, PS5, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('Starfield', 'Bethesda Game Studios', 'Bethesda Softworks', '2023-09-06', 83, 'RPG, Sci-Fi', 'PC, Xbox', 'Одиночная', 'Creation Engine 2', TRUE, 18, NULL),
('Fallout 4', 'Bethesda Game Studios', 'Bethesda Softworks', '2015-11-10', 84, 'RPG, Action', 'PC, PS4, Xbox', 'Одиночная', 'Creation Engine', TRUE, 18, NULL),
('Fallout: New Vegas', 'Obsidian Entertainment', 'Bethesda Softworks', '2010-10-19', 84, 'RPG', 'PC, PS3, Xbox', 'Одиночная', 'Gamebryo', TRUE, 18, NULL),
('The Outer Worlds', 'Obsidian Entertainment', 'Private Division', '2019-10-25', 85, 'RPG', 'PC, PS4, Xbox, Switch', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('Grounded', 'Obsidian Entertainment', 'Xbox Game Studios', '2022-09-27', 81, 'Выживание, Песочница', 'PC, PS4, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 12, NULL),
('Pentiment', 'Obsidian Entertainment', 'Xbox Game Studios', '2022-11-15', 82, 'RPG, Adventure', 'PC, Xbox', 'Одиночная', 'Custom', TRUE, 16, NULL),
('Avowed', 'Obsidian Entertainment', 'Xbox Game Studios', '2025-02-18', 80, 'RPG', 'PC, Xbox', 'Одиночная', 'Unreal Engine 5', TRUE, 18, NULL),
('Baldurs Gate 3', 'Larian Studios', 'Larian Studios', '2023-08-03', 96, 'RPG', 'PC, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Divinity Engine 4', TRUE, 18, NULL),

-- 61-70
('Divinity: Original Sin 2', 'Larian Studios', 'Larian Studios', '2017-09-14', 93, 'RPG', 'PC, PS4, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Divinity Engine 3', TRUE, 16, NULL),
('Solasta: Crown of the Magister', 'Tactical Adventures', 'Tactical Adventures', '2021-05-27', 78, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 16, NULL),
('Pathfinder: Wrath of the Righteous', 'Owlcat Games', 'META Publishing', '2021-09-02', 80, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 18, NULL),
('Pathfinder: Kingmaker', 'Owlcat Games', 'Deep Silver', '2018-09-25', 75, 'RPG', 'PC, PS4, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 18, NULL),
('Wasteland 3', 'inXile Entertainment', 'Deep Silver', '2020-08-28', 85, 'RPG', 'PC, PS4, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18, NULL),
('Torment: Tides of Numenera', 'Ninja Theory', 'Techland Publishing', '2017-02-28', 81, 'RPG', 'PC, PS4, Xbox', 'Одиночная', 'Unity', TRUE, 16, NULL),
('Disco Elysium', 'ZA/UM', 'ZA/UM', '2019-10-15', 91, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 18, NULL),
('Pillars of Eternity II', 'Obsidian Entertainment', 'Versus Evil', '2018-05-08', 88, 'RPG', 'PC, PS4, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 16, NULL),
('Tyranny', 'Obsidian Entertainment', 'Paradox Interactive', '2016-11-10', 80, 'RPG', 'PC', 'Одиночная', 'Unity', TRUE, 18, NULL),
('South Park: The Stick of Truth', 'Obsidian Entertainment', 'Ubisoft', '2014-03-04', 85, 'RPG', 'PC, PS3, PS4, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 18, NULL),

-- 71-80
('South Park: The Fractured But Whole', 'Ubisoft San Francisco', 'Ubisoft', '2017-10-17', 85, 'RPG', 'PC, PS4, Xbox, Switch', 'Одиночная', 'Snowdrop', TRUE, 18, NULL),
('Assassins Creed Valhalla', 'Ubisoft Montreal', 'Ubisoft', '2020-11-10', 84, 'Action, RPG', 'PC, PS4, PS5, Xbox', 'Одиночная', 'AnvilNext 2.0', TRUE, 18, NULL),
('Assassins Creed Odyssey', 'Ubisoft Quebec', 'Ubisoft', '2018-10-05', 83, 'Action, RPG', 'PC, PS4, Xbox, Switch', 'Одиночная', 'AnvilNext 2.0', TRUE, 18, NULL),
('Assassins Creed Origins', 'Ubisoft Montreal', 'Ubisoft', '2017-10-27', 81, 'Action, RPG', 'PC, PS4, Xbox', 'Одиночная', 'AnvilNext 2.0', TRUE, 18, NULL),
('Far Cry 6', 'Ubisoft Toronto', 'Ubisoft', '2021-10-07', 73, 'Шутер, Action', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Dunia', TRUE, 18, NULL),
('Far Cry 5', 'Ubisoft Montreal', 'Ubisoft', '2018-03-27', 81, 'Шутер, Action', 'PC, PS4, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Dunia', TRUE, 18, NULL),
('Watch Dogs: Legion', 'Ubisoft Toronto', 'Ubisoft', '2020-10-29', 64, 'Action, Adventure', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'Disrupt', TRUE, 18, NULL),
('Rainbow Six Siege', 'Ubisoft Montreal', 'Ubisoft', '2015-12-01', 80, 'Шутер, Тактический', 'PC, PS4, PS5, Xbox', 'Мультиплеер', 'AnvilNext 2.0', TRUE, 16, NULL),
('Prince of Persia: The Lost Crown', 'Ubisoft Montpellier', 'Ubisoft', '2024-01-15', 86, 'Action, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Ubisoft Anvil', TRUE, 12, NULL),
('Immortals Fenyx Rising', 'Ubisoft Quebec', 'Ubisoft', '2020-12-03', 77, 'Action, Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'AnvilNext 2.0', TRUE, 12, NULL),

-- 81-90
('Forza Horizon 5', 'Playground Games', 'Xbox Game Studios', '2021-11-09', 92, 'Гонки', 'PC, Xbox', 'Одиночная, Мультиплеер', 'ForzaTech', TRUE, 6, NULL),
('Forza Motorsport', 'Turn 10 Studios', 'Xbox Game Studios', '2023-10-10', 84, 'Гонки', 'PC, Xbox', 'Одиночная, Мультиплеер', 'ForzaTech', TRUE, 6, NULL),
('Halo Infinite', '343 Industries', 'Xbox Game Studios', '2021-12-08', 87, 'Шутер', 'PC, Xbox', 'Одиночная, Мультиплеер', 'Slipspace Engine', TRUE, 16, NULL),
('Gears 5', 'The Coalition', 'Xbox Game Studios', '2019-09-10', 84, 'Шутер', 'PC, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18, NULL),
('Sea of Thieves', 'Rare', 'Xbox Game Studios', '2018-03-20', 69, 'Action, Adventure', 'PC, PS5, Xbox', 'Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 12, NULL),
('State of Decay 2', 'Undead Labs', 'Xbox Game Studios', '2018-05-22', 64, 'Выживание, Хоррор', 'PC, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 3', TRUE, 18, NULL),
('Microsoft Flight Simulator', 'Asobo Studio', 'Xbox Game Studios', '2020-08-18', 91, 'Симулятор', 'PC, Xbox', 'Одиночная, Мультиплеер', 'Asobo Engine', TRUE, 6, NULL),
('Age of Empires IV', 'Relic Entertainment', 'Xbox Game Studios', '2021-10-28', 81, 'Стратегия', 'PC', 'Одиночная, Мультиплеер', 'Essence Engine 5', TRUE, 12, NULL),
('Starcraft II', 'Blizzard Entertainment', 'Blizzard Entertainment', '2010-07-27', 93, 'Стратегия', 'PC', 'Одиночная, Мультиплеер', 'Galaxy Engine', TRUE, 12, NULL),
('Diablo IV', 'Blizzard Entertainment', 'Blizzard Entertainment', '2023-06-06', 86, 'Action, RPG', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'Custom', TRUE, 18, NULL),

-- 91-100
('Diablo II: Resurrected', 'Vicarious Visions', 'Blizzard Entertainment', '2021-09-23', 80, 'Action, RPG', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер', 'Custom', TRUE, 16, NULL),
('Diablo III', 'Blizzard Entertainment', 'Blizzard Entertainment', '2012-05-15', 88, 'Action, RPG', 'PC, PS3, PS4, Xbox, Switch', 'Одиночная, Мультиплеер', 'Custom', TRUE, 16, NULL),
('Overwatch 2', 'Blizzard Entertainment', 'Blizzard Entertainment', '2022-10-04', 79, 'Шутер', 'PC, PS4, PS5, Xbox, Switch', 'Мультиплеер', 'Custom', TRUE, 12, NULL),
('World of Warcraft', 'Blizzard Entertainment', 'Blizzard Entertainment', '2004-11-23', 93, 'MMORPG', 'PC', 'Мультиплеер, MMO', 'Custom', TRUE, 12, NULL),
('Hearthstone', 'Blizzard Entertainment', 'Blizzard Entertainment', '2014-03-11', 88, 'Карточная', 'PC, Mobile', 'Одиночная, Мультиплеер', 'Custom', TRUE, 12, NULL),
('Destiny 2', 'Bungie', 'Bungie', '2017-09-06', 85, 'Шутер, Action', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Blender Engine', TRUE, 16, NULL),
('Marathon', 'Bungie', 'Bungie', '2025-07-22', 80, 'Шутер', 'PC, PS5, Xbox', 'Мультиплеер', 'Custom', FALSE, 16, NULL),
('Hades', 'Supergiant Games', 'Supergiant Games', '2020-09-17', 93, 'Roguelike, Action', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Hades II', 'Supergiant Games', 'Supergiant Games', '2024-05-06', 88, 'Roguelike, Action', 'PC', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Bastion', 'Supergiant Games', 'Supergiant Games', '2011-07-20', 86, 'Action, RPG', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Custom', TRUE, 12, NULL),

-- 101-110
('Transistor', 'Supergiant Games', 'Supergiant Games', '2014-05-20', 83, 'Action, RPG', 'PC, PS4, Switch', 'Одиночная', 'Custom', TRUE, 16, NULL),
('Pyre', 'Supergiant Games', 'Supergiant Games', '2017-07-25', 81, 'RPG', 'PC, PS4', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Dead Cells', 'Motion Twin', 'Motion Twin', '2018-08-07', 89, 'Roguelike, Action', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Returnal', 'Housemarque', 'Sony Interactive Entertainment', '2023-02-15', 86, 'Roguelike, Шутер', 'PC, PS5', 'Одиночная', 'Custom', TRUE, 16, NULL),
('Risk of Rain 2', 'Hopoo Games', 'Gearbox Publishing', '2020-08-11', 85, 'Roguelike, Шутер', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12, NULL),
('Slay the Spire', 'MegaCrit', 'Humble Games', '2017-11-14', 89, 'Roguelike, Карточная', 'PC, PS4, Xbox, Switch', 'Одиночная', 'LibGDX', TRUE, 12, NULL),
('Cuphead', 'Studio MDHR', 'Studio MDHR', '2017-09-29', 86, 'Action, Platformer', 'PC, PS4, Xbox, Switch', 'Одиночная, Кооператив', 'Unity', TRUE, 12, NULL),
('Hollow Knight', 'Team Cherry', 'Team Cherry', '2017-02-24', 87, 'Metroidvania, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Silksong', 'Team Cherry', 'Team Cherry', '2025-06-19', 85, 'Metroidvania, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Ori and the Will of the Wisps', 'Moon Studios', 'Xbox Game Studios', '2020-03-11', 90, 'Metroidvania, Platformer', 'PC, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 6, NULL),

-- 111-120
('Ori and the Blind Forest', 'Moon Studios', 'Xbox Game Studios', '2015-03-11', 88, 'Metroidvania, Platformer', 'PC, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 6, NULL),
('Celeste', 'Maddy Makes Games', 'Maddy Makes Games', '2018-01-25', 92, 'Platformer', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'GameMaker', TRUE, 12, NULL),
('Super Meat Boy', 'Team Meat', 'Team Meat', '2010-10-20', 87, 'Platformer', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Super Meat Boy Forever', 'Team Meat', 'Team Meat', '2020-12-10', 65, 'Platformer', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Кооператив', 'Unity', TRUE, 12, NULL),
('The Binding of Isaac: Rebirth', 'Nicalis', 'Nicalis', '2014-11-04', 90, 'Roguelike', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Кооператив', 'Custom', TRUE, 16, NULL),
('Enter the Gungeon', 'Dodge Roll', 'Devolver Digital', '2016-04-05', 84, 'Roguelike, Шутер', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Кооператив', 'Unity', TRUE, 12, NULL),
('Gunfire Reborn', 'Duoyi Games', 'Duoyi Games', '2021-10-27', 82, 'Roguelike, Шутер', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12, NULL),
('Vampire Survivors', 'poncle', 'poncle', '2022-10-20', 87, 'Roguelike, Action', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Кооператив', 'Custom', TRUE, 12, NULL),
('Terraria', 'Re-Logic', 'Re-Logic', '2011-05-16', 83, 'Песочница, Action', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12, NULL),
('Stardew Valley', 'ConcernedApe', 'ConcernedApe', '2016-02-26', 89, 'Симулятор фермы, RPG', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12, NULL),

-- 121-130
('Valheim', 'Iron Gate AB', 'Coffee Stain Publishing', '2021-02-02', 80, 'Выживание, Песочница', 'PC, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12, NULL),
('Rust', 'Facepunch Studios', 'Facepunch Studios', '2018-02-08', 69, 'Выживание', 'PC, PS4, PS5, Xbox', 'Мультиплеер', 'Unity', TRUE, 18, NULL),
('ARK: Survival Evolved', 'Studio Wildcard', 'Studio Wildcard', '2017-08-29', 70, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 16, NULL),
('Conan Exiles', 'Funcom', 'Funcom', '2018-05-08', 70, 'Выживание', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18, NULL),
('The Forest', 'Endnight Games', 'Endnight Games', '2018-04-30', 83, 'Выживание, Хоррор', 'PC, PS4', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18, NULL),
('Sons of the Forest', 'Endnight Games', 'Endnight Games', '2024-02-22', 80, 'Выживание, Хоррор', 'PC', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18, NULL),
('Green Hell', 'Creepy Jar', 'Creepy Jar', '2019-09-05', 78, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18, NULL),
('Subnautica', 'Unknown Worlds', 'Unknown Worlds', '2018-01-23', 87, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Subnautica: Below Zero', 'Unknown Worlds', 'Unknown Worlds', '2021-05-14', 78, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('No Mans Sky', 'Hello Games', 'Hello Games', '2016-08-09', 71, 'Выживание, Sci-Fi', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12, NULL),

-- 131-140
('Elite Dangerous', 'Frontier Developments', 'Frontier Developments', '2014-12-16', 82, 'Симулятор, Sci-Fi', 'PC, PS4, Xbox', 'Одиночная, Мультиплеер', 'Custom', TRUE, 12, NULL),
('Kerbal Space Program', 'Squad', 'Private Division', '2015-04-27', 88, 'Симулятор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Cities: Skylines', 'Colossal Order', 'Paradox Interactive', '2015-03-10', 85, 'Градостроительный симулятор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Cities: Skylines II', 'Colossal Order', 'Paradox Interactive', '2023-10-24', 68, 'Градостроительный симулятор', 'PC', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Planet Coaster', 'Frontier Developments', 'Frontier Developments', '2016-11-17', 84, 'Симулятор', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Planet Zoo', 'Frontier Developments', 'Frontier Developments', '2019-11-05', 83, 'Симулятор', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Jurassic World Evolution 2', 'Frontier Developments', 'Frontier Developments', '2021-11-09', 76, 'Симулятор', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Two Point Hospital', 'Two Point Studios', 'Sega', '2018-08-30', 83, 'Симулятор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Two Point Campus', 'Two Point Studios', 'Sega', '2022-08-09', 81, 'Симулятор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('RimWorld', 'Ludeon Studios', 'Ludeon Studios', '2018-10-17', 87, 'Стратегия, Симулятор', 'PC', 'Одиночная', 'Custom', TRUE, 16, NULL),

-- 141-150
('Factorio', 'Wube Software', 'Wube Software', '2020-08-14', 90, 'Стратегия, Симулятор', 'PC, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12, NULL),
('Satisfactory', 'Coffee Stain Studios', 'Coffee Stain Publishing', '2024-09-10', 87, 'Симулятор', 'PC, PS5', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 12, NULL),
('Dyson Sphere Program', 'Youthcat Studio', 'Gamera Game', '2021-01-21', 84, 'Стратегия, Симулятор', 'PC', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Oxygen Not Included', 'Klei Entertainment', 'Klei Entertainment', '2019-07-30', 85, 'Стратегия, Симулятор', 'PC', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Dont Starve Together', 'Klei Entertainment', 'Klei Entertainment', '2016-04-21', 83, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12, NULL),
('Dont Starve', 'Klei Entertainment', 'Klei Entertainment', '2013-04-23', 79, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Mark of the Ninja', 'Klei Entertainment', 'Klei Entertainment', '2012-09-07', 84, 'Stealth, Platformer', 'PC, PS4, Xbox, Switch', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Invisible Inc', 'Klei Entertainment', 'Klei Entertainment', '2015-05-12', 82, 'Stealth, Стратегия', 'PC, PS4, Xbox', 'Одиночная', 'Custom', TRUE, 16, NULL),
('Griftlands', 'Klei Entertainment', 'Klei Entertainment', '2021-06-01', 81, 'RPG, Карточная', 'PC', 'Одиночная, Мультиплеер', 'Custom', TRUE, 16, NULL),
('Among Us', 'Innersloth', 'Innersloth', '2018-06-15', 85, 'Социальная, Мультиплеер', 'PC, Mobile, PS4, PS5, Xbox, Switch', 'Мультиплеер', 'Unity', TRUE, 12, NULL),

-- 151-160
('Fall Guys', 'Mediatonic', 'Epic Games', '2020-08-04', 81, 'Party, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'Мультиплеер', 'Unity', TRUE, 6, NULL),
('Rocket League', 'Psyonix', 'Psyonix', '2015-07-07', 86, 'Спорт, Гонки', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 3', TRUE, 6, NULL),
('FIFA 23', 'EA Vancouver', 'Electronic Arts', '2022-09-30', 77, 'Спорт', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер', 'Frostbite', TRUE, 6, NULL),
('EA Sports FC 24', 'EA Vancouver', 'Electronic Arts', '2023-09-29', 75, 'Спорт', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер', 'Frostbite', TRUE, 6, NULL),
('NBA 2K24', 'Visual Concepts', '2K Sports', '2023-09-08', 73, 'Спорт', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная, Мультиплеер', 'Custom', TRUE, 6, NULL),
('F1 23', 'Codemasters', 'EA Sports', '2023-06-16', 82, 'Гонки', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'EGO', TRUE, 6, NULL),
('Dirt Rally 2.0', 'Codemasters', 'Codemasters', '2019-02-26', 84, 'Гонки', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'EGO', TRUE, 6, NULL),
('Grid Legends', 'Codemasters', 'EA Sports', '2022-02-25', 77, 'Гонки', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'EGO', TRUE, 6, NULL),
('Need for Speed Unbound', 'Criterion Games', 'Electronic Arts', '2022-12-02', 79, 'Гонки', 'PC, PS5, Xbox', 'Одиночная, Мультиплеер', 'Ghost', TRUE, 12, NULL),
('Burnout Paradise', 'Criterion Games', 'Electronic Arts', '2009-04-09', 88, 'Гонки', 'PC, PS3, PS4, Xbox', 'Одиночная, Мультиплеер', 'RenderWare', TRUE, 12, NULL),

-- 161-170
('It Takes Two', 'Hazelight Studios', 'Electronic Arts', '2021-03-26', 88, 'Action, Adventure', 'PC, PS4, PS5, Xbox', 'Кооператив', 'Unreal Engine 4', TRUE, 12, NULL),
('A Way Out', 'Hazelight Studios', 'Electronic Arts', '2018-03-23', 78, 'Action, Adventure', 'PC, PS4, Xbox', 'Кооператив', 'Unreal Engine 4', TRUE, 18, NULL),
('Stray', 'BlueTwelve Studio', 'Annapurna Interactive', '2022-07-19', 83, 'Adventure', 'PC, PS4, PS5', 'Одиночная', 'Unreal Engine 4', TRUE, 12, NULL),
('Firewatch', 'Campo Santo', 'Campo Santo', '2016-02-09', 81, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 16, NULL),
('What Remains of Edith Finch', 'Giant Sparrow', 'Annapurna Interactive', '2017-04-25', 87, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unreal Engine 4', TRUE, 16, NULL),
('The Stanley Parable', 'Galactic Cafe', 'Galactic Cafe', '2013-10-17', 88, 'Adventure', 'PC', 'Одиночная', 'Source', TRUE, 12, NULL),
('The Stanley Parable: Ultra Deluxe', 'Galactic Cafe', 'Galactic Cafe', '2022-04-27', 85, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 12, NULL),
('Life is Strange', 'Dontnod Entertainment', 'Square Enix', '2015-01-30', 83, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unreal Engine 3', TRUE, 16, NULL),
('Life is Strange: True Colors', 'Deck Nine', 'Square Enix', '2021-09-10', 79, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unreal Engine 4', TRUE, 16, NULL),
('Tell Me Why', 'Dontnod Entertainment', 'Xbox Game Studios', '2020-08-27', 75, 'Adventure', 'PC, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 16, NULL),

-- 171-180
('Oxenfree', 'Night School Studio', 'Night School Studio', '2016-01-15', 81, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 16, NULL),
('Night in the Woods', 'Infinite Fall', 'Finji', '2017-02-21', 85, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 16, NULL),
('Gone Home', 'The Fullbright Company', 'The Fullbright Company', '2013-08-15', 75, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 16, NULL),
('Dear Esther', 'The Chinese Room', 'The Chinese Room', '2012-02-14', 77, 'Adventure', 'PC', 'Одиночная', 'Source', TRUE, 16, NULL),
('Everybody Gone to the Rapture', 'The Chinese Room', 'Sony Interactive Entertainment', '2015-08-11', 71, 'Adventure', 'PC, PS4', 'Одиночная', 'Custom', TRUE, 12, NULL),
('Amnesia: The Dark Descent', 'Frictional Games', 'Frictional Games', '2010-09-08', 85, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'HPL Engine', TRUE, 18, NULL),
('Amnesia: Rebirth', 'Frictional Games', 'Frictional Games', '2020-10-20', 78, 'Хоррор', 'PC, PS4', 'Одиночная', 'HPL Engine', TRUE, 18, NULL),
('Amnesia: The Bunker', 'Frictional Games', 'Frictional Games', '2023-06-06', 82, 'Хоррор, Выживание', 'PC, PS4, PS5, Xbox', 'Одиночная', 'HPL Engine', TRUE, 18, NULL),
('SOMA', 'Frictional Games', 'Frictional Games', '2015-09-22', 84, 'Хоррор, Sci-Fi', 'PC, PS4, PS5', 'Одиночная', 'HPL Engine', TRUE, 18, NULL),
('Outlast', 'Red Barrels', 'Red Barrels', '2013-09-04', 80, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unreal Engine 3', TRUE, 18, NULL),

-- 181-190
('Outlast II', 'Red Barrels', 'Red Barrels', '2017-04-25', 77, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('The Outlast Trials', 'Red Barrels', 'Red Barrels', '2024-03-05', 78, 'Хоррор', 'PC, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18, NULL),
('Layers of Fear', 'Bloober Team', 'Bloober Team', '2016-02-16', 71, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unity', TRUE, 18, NULL),
('Layers of Fear 2', 'Bloober Team', 'Bloober Team', '2019-06-04', 73, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('The Medium', 'Bloober Team', 'Bloober Team', '2021-01-28', 73, 'Хоррор', 'PC, PS5, Xbox', 'Одиночная', 'Northlight Engine', TRUE, 18, NULL),
('Blair Witch', 'Bloober Team', 'Bloober Team', '2019-08-30', 65, 'Хоррор', 'PC, PS4, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('Observer: System Redux', 'Bloober Team', 'Bloober Team', '2017-08-15', 74, 'Хоррор, Cyberpunk', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('Visage', 'SadSquare Studio', 'SadSquare Studio', '2020-10-30', 79, 'Хоррор', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Unity', TRUE, 18, NULL),
('MADiSON', 'BLOODIOUS GAMES', 'BLOODIOUS GAMES', '2022-07-08', 76, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('The Callisto Protocol', 'Striking Distance Studios', 'Krafton', '2022-12-02', 68, 'Хоррор', 'PC, PS4, PS5, Xbox', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),

-- 191-200
('Dead Space', 'Motive Studio', 'Electronic Arts', '2023-01-27', 89, 'Хоррор', 'PC, PS5, Xbox', 'Одиночная', 'Frostbite', TRUE, 18, NULL),
('Dead Space 2', 'Visceral Games', 'Electronic Arts', '2011-01-25', 87, 'Хоррор', 'PC, PS3, PS4, PS5, Xbox', 'Одиночная', 'Vicious Engine', TRUE, 18, NULL),
('Dead Space 3', 'Visceral Games', 'Electronic Arts', '2013-02-05', 78, 'Хоррор, Action', 'PC, PS3, PS4, PS5, Xbox', 'Одиночная, Кооператив', 'Vicious Engine', TRUE, 18, NULL),
('Alien: Isolation', 'Creative Assembly', 'Sega', '2014-10-07', 81, 'Хоррор, Выживание', 'PC, PS4, PS5, Xbox, Switch', 'Одиночная', 'Alien Engine', TRUE, 18, NULL),
('The Evil Within', 'Tango Gameworks', 'Bethesda Softworks', '2014-10-14', 75, 'Хоррор', 'PC, PS3, PS4, PS5, Xbox', 'Одиночная', 'id Tech 5', TRUE, 18, NULL),
('Until Dawn', 'Supermassive Games', 'Sony Interactive Entertainment', '2024-10-04', 79, 'Хоррор', 'PC, PS4, PS5', 'Одиночная', 'Unreal Engine 4', TRUE, 18, NULL),
('The Quarry', 'Supermassive Games', '2K Games', '2022-06-10', 75, 'Хоррор', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'Unreal Engine 4', TRUE, 18, NULL),
('The Dark Pictures: Man of Medan', 'Supermassive Games', 'Bandai Namco', '2019-08-30', 69, 'Хоррор', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18, NULL),
('The Dark Pictures: Little Hope', 'Supermassive Games', 'Bandai Namco', '2020-10-15', 68, 'Хоррор', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер', 'Unreal Engine 4', TRUE, 18, NULL),
('The Dark Pictures: House of Ashes', 'Supermassive Games', 'Bandai Namco', '2021-10-26', 72, 'Хоррор', 'PC, PS4, PS5, Xbox', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18, NULL);

-- Create indexes for sorting fields as per README requirements
CREATE INDEX IF NOT EXISTS idx_title ON games(title);
CREATE INDEX IF NOT EXISTS idx_publisher ON games(publisher);
CREATE INDEX IF NOT EXISTS idx_release_date ON games(release_date);
CREATE INDEX IF NOT EXISTS idx_metacritic_score ON games(metacritic_score);
CREATE INDEX IF NOT EXISTS idx_age_rating ON games(age_rating);

-- Query example with all 5 sorting fields
-- SELECT * FROM games ORDER BY title, publisher, release_date, metacritic_score, age_rating;
