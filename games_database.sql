-- Games Database
-- Created: 2026-03-14
-- Structure based on README.md specification

CREATE TABLE IF NOT EXISTS games (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    developer VARCHAR(100),
    publisher VARCHAR(100),
    release_date DATE,
    metacritic_score INT,
    genre VARCHAR(100),
    platform VARCHAR(255),
    cover VARCHAR(255),
    game_modes VARCHAR(100),
    engine VARCHAR(100),
    russian_language BOOLEAN DEFAULT FALSE,
    age_rating INT
);

-- Insert 200 games
INSERT INTO games (title, developer, publisher, release_date, metacritic_score, genre, platform, cover, game_modes, engine, russian_language, age_rating) VALUES
-- 1-10
('Phasmophobia', 'Kinetic Games', 'Kinetic Games', '2020-09-18', 79, 'Хоррор, Симулятор', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/739630/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12),
('Cyberpunk 2077', 'CD Projekt Red', 'CD Projekt', '2020-12-10', 86, 'RPG, Open World', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1091500/header.jpg', 'Одиночная', 'REDengine 4', TRUE, 18),
('CS2', 'Valve', 'Valve', '2023-09-27', 83, 'Шутер, Тактический', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/730/header.jpg', 'Мультиплеер', 'Source 2', TRUE, 16),
('Portal', 'Valve', 'Valve', '2007-10-09', 90, 'Головоломка', 'PC, Xbox, PS3', 'https://cdn.cloudflare.steamstatic.com/steam/apps/400/header.jpg', 'Одиночная', 'Source', TRUE, 12),
('Half-Life', 'Valve', 'Sierra Studios', '1998-11-19', 96, 'Шутер, Научная фантастика', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/70/header.jpg', 'Одиночная', 'GoldSrc', TRUE, 16),
('The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', '2015-05-19', 93, 'RPG, Open World', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/292030/header.jpg', 'Одиночная', 'REDengine 3', TRUE, 18),
('Red Dead Redemption 2', 'Rockstar Games', 'Rockstar Games', '2019-11-05', 93, 'Action, Open World', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1174180/header.jpg', 'Одиночная, Мультиплеер', 'RAGE', TRUE, 18),
('The Last of Us Part II', 'Naughty Dog', 'Sony Interactive Entertainment', '2020-06-19', 93, 'Action, Survival Horror', 'PS4, PS5', 'https://image.api.playstation.com/vulcan/ap/rnd/202310/2320/4bb3b1d6e7e4e7e4e7e4e7e4.png', 'Одиночная', 'Naughty Dog Engine', FALSE, 18),
('God of War', 'Santa Monica Studio', 'Sony Interactive Entertainment', '2022-01-14', 94, 'Action, Adventure', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1593500/header.jpg', 'Одиночная', 'Santa Monica Engine', TRUE, 18),
('Elden Ring', 'FromSoftware', 'Bandai Namco', '2022-02-25', 96, 'RPG, Action', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1245620/header.jpg', 'Одиночная, Мультиплеер', 'FromSoftware Engine', TRUE, 18),

-- 11-20
('Minecraft', 'Mojang Studios', 'Xbox Game Studios', '2011-11-18', 93, 'Песочница, Выживание', 'PC, Mobile, Console', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1794680/header.jpg', 'Одиночная, Мультиплеер', 'Java, Bedrock', TRUE, 6),
('Grand Theft Auto V', 'Rockstar North', 'Rockstar Games', '2015-04-14', 96, 'Action, Open World', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/271590/header.jpg', 'Одиночная, Мультиплеер', 'RAGE', TRUE, 18),
('Skyrim', 'Bethesda Game Studios', 'Bethesda Softworks', '2011-11-11', 94, 'RPG, Open World', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/72850/header.jpg', 'Одиночная', 'Creation Engine', TRUE, 18),
('Dark Souls III', 'FromSoftware', 'Bandai Namco', '2016-04-12', 89, 'RPG, Action', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/374320/header.jpg', 'Одиночная, Мультиплеер', 'FromSoftware Engine', TRUE, 16),
('Bloodborne', 'FromSoftware', 'Sony Interactive Entertainment', '2015-03-24', 92, 'RPG, Action, Horror', 'PS4, PS5', 'https://image.api.playstation.com/vulcan/img/rnd/202010/2618/Y02ljdB8KFBZqQVNqJhKqA.png', 'Одиночная, Мультиплеер', 'FromSoftware Engine', FALSE, 18),
('Sekiro: Shadows Die Twice', 'FromSoftware', 'Activision', '2019-03-22', 90, 'Action, Adventure', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/814380/header.jpg', 'Одиночная', 'FromSoftware Engine', TRUE, 18),
('Monster Hunter: World', 'Capcom', 'Capcom', '2018-08-09', 90, 'Action, RPG', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/582010/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'MT Framework', TRUE, 16),
('Resident Evil Village', 'Capcom', 'Capcom', '2021-05-07', 84, 'Хоррор, Выживание', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1196590/header.jpg', 'Одиночная', 'RE Engine', TRUE, 18),
('Resident Evil 2', 'Capcom', 'Capcom', '2019-01-25', 91, 'Хоррор, Выживание', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/883710/header.jpg', 'Одиночная', 'RE Engine', TRUE, 18),
('Devil May Cry 5', 'Capcom', 'Capcom', '2019-03-08', 88, 'Action, Hack and Slash', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/601150/header.jpg', 'Одиночная, Кооператив', 'RE Engine', TRUE, 16),

-- 21-30
('Street Fighter 6', 'Capcom', 'Capcom', '2023-06-02', 92, 'Файтинг', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1364780/header.jpg', 'Одиночная, Мультиплеер', 'RE Engine', TRUE, 12),
('Final Fantasy VII Remake', 'Square Enix', 'Square Enix', '2021-12-16', 89, 'RPG, Action', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1462040/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 16),
('Final Fantasy XIV', 'Square Enix', 'Square Enix', '2013-08-27', 83, 'MMORPG', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/39210/header.jpg', 'Мультиплеер, MMO', 'Custom', TRUE, 16),
('Kingdom Hearts III', 'Square Enix', 'Square Enix', '2019-01-29', 83, 'RPG, Action', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2603720/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 12),
('NieR: Automata', 'PlatinumGames', 'Square Enix', '2017-03-07', 88, 'Action, RPG', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/524220/header.jpg', 'Одиночная', 'Platinum Engine', TRUE, 16),
('Persona 5 Royal', 'Atlus', 'Sega', '2022-10-21', 89, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1687950/header.jpg', 'Одиночная', 'Atlus Engine', TRUE, 16),
('Persona 4 Golden', 'Atlus', 'Sega', '2020-06-13', 85, 'RPG', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1113000/header.jpg', 'Одиночная', 'Atlus Engine', TRUE, 12),
('Yakuza: Like a Dragon', 'Ryu Ga Gotoku Studio', 'Sega', '2020-11-10', 83, 'RPG', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1235140/header.jpg', 'Одиночная', 'Dragon Engine', TRUE, 18),
('Like a Dragon: Infinite Wealth', 'Ryu Ga Gotoku Studio', 'Sega', '2024-01-26', 89, 'RPG, Action', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2079360/header.jpg', 'Одиночная', 'Dragon Engine', TRUE, 18),
('Ghost of Tsushima', 'Sucker Punch Productions', 'Sony Interactive Entertainment', '2024-05-16', 87, 'Action, Adventure', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2215430/header.jpg', 'Одиночная, Мультиплеер', 'Decima', TRUE, 18),

-- 31-40
('Spider-Man Remastered', 'Insomniac Games', 'Sony Interactive Entertainment', '2022-08-12', 87, 'Action, Adventure', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1817070/header.jpg', 'Одиночная', 'Insomniac Engine', TRUE, 16),
('Spider-Man: Miles Morales', 'Insomniac Games', 'Sony Interactive Entertainment', '2022-11-18', 84, 'Action, Adventure', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1817190/header.jpg', 'Одиночная', 'Insomniac Engine', TRUE, 16),
('Ratchet & Clank: Rift Apart', 'Insomniac Games', 'Sony Interactive Entertainment', '2023-07-26', 88, 'Action, Adventure', 'PC, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1896780/header.jpg', 'Одиночная', 'Insomniac Engine', TRUE, 12),
('Horizon Zero Dawn', 'Guerrilla Games', 'Sony Interactive Entertainment', '2020-08-07', 84, 'Action, RPG', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1151640/header.jpg', 'Одиночная', 'Decima', TRUE, 16),
('Horizon Forbidden West', 'Guerrilla Games', 'Sony Interactive Entertainment', '2024-03-21', 85, 'Action, RPG', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2420110/header.jpg', 'Одиночная', 'Decima', TRUE, 16),
('Death Stranding', 'Kojima Productions', '505 Games', '2020-07-14', 82, 'Action', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1190460/header.jpg', 'Одиночная, Мультиплеер', 'Decima', TRUE, 18),
('Death Stranding 2', 'Kojima Productions', 'Sony Interactive Entertainment', '2025-06-26', 85, 'Action', 'PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2061720/header.jpg', 'Одиночная', 'Decima', FALSE, 18),
('Metal Gear Solid V', 'Kojima Productions', 'Konami', '2015-09-01', 93, 'Action, Stealth', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/287700/header.jpg', 'Одиночная, Мультиплеер', 'Fox Engine', TRUE, 18),
('Silent Hill 2', 'Bloober Team', 'Konami', '2024-10-08', 83, 'Хоррор', 'PC, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2124690/header.jpg', 'Одиночная', 'Unreal Engine 5', TRUE, 18),
('Alan Wake 2', 'Remedy Entertainment', 'Epic Games', '2023-10-27', 89, 'Хоррор', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/108710/header.jpg', 'Одиночная', 'Northlight Engine', TRUE, 18),

-- 41-50
('Control', 'Remedy Entertainment', '505 Games', '2019-08-27', 85, 'Action, Adventure', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/870780/header.jpg', 'Одиночная', 'Northlight Engine', TRUE, 16),
('Max Payne 3', 'Remedy Entertainment', 'Rockstar Games', '2012-05-15', 87, 'Шутер, Action', 'PC, PS3, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/205100/header.jpg', 'Одиночная, Мультиплеер', 'RAGE', TRUE, 18),
('Quantum Break', 'Remedy Entertainment', 'Microsoft Studios', '2016-09-29', 77, 'Action, Adventure', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/474960/header.jpg', 'Одиночная', 'Northlight Engine', TRUE, 16),
('Deathloop', 'Arkane Studios', 'Bethesda Softworks', '2021-09-14', 88, 'Шутер, Action', 'PC, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1252330/header.jpg', 'Одиночная, Мультиплеер', 'Unreal Engine 4', TRUE, 18),
('Dishonored 2', 'Arkane Studios', 'Bethesda Softworks', '2016-11-11', 88, 'Action, Stealth', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/373370/header.jpg', 'Одиночная', 'Void Engine', TRUE, 18),
('Prey', 'Arkane Studios', 'Bethesda Softworks', '2017-05-05', 82, 'Шутер, Хоррор', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/480490/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('Doom Eternal', 'id Software', 'Bethesda Softworks', '2020-03-20', 88, 'Шутер', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/782330/header.jpg', 'Одиночная, Мультиплеер', 'id Tech 7', TRUE, 18),
('Doom (2016)', 'id Software', 'Bethesda Softworks', '2016-05-13', 85, 'Шутер', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/379720/header.jpg', 'Одиночная, Мультиплеер', 'id Tech 6', TRUE, 18),
('Wolfenstein II: The New Colossus', 'MachineGames', 'Bethesda Softworks', '2017-10-27', 87, 'Шутер', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/612880/header.jpg', 'Одиночная', 'id Tech 6', TRUE, 18),
('Hi-Fi Rush', 'Tango Gameworks', 'Bethesda Softworks', '2023-01-25', 87, 'Action, Ритм', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1817230/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 12),

-- 51-60
('The Evil Within 2', 'Tango Gameworks', 'Bethesda Softworks', '2017-10-13', 80, 'Хоррор, Выживание', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/601430/header.jpg', 'Одиночная', 'Unreal Engine 3', TRUE, 18),
('Ghostwire: Tokyo', 'Tango Gameworks', 'Bethesda Softworks', '2022-03-25', 76, 'Action, Хоррор', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1451310/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('Starfield', 'Bethesda Game Studios', 'Bethesda Softworks', '2023-09-06', 83, 'RPG, Sci-Fi', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1716740/header.jpg', 'Одиночная', 'Creation Engine 2', TRUE, 18),
('Fallout 4', 'Bethesda Game Studios', 'Bethesda Softworks', '2015-11-10', 84, 'RPG, Action', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/377160/header.jpg', 'Одиночная', 'Creation Engine', TRUE, 18),
('Fallout: New Vegas', 'Obsidian Entertainment', 'Bethesda Softworks', '2010-10-19', 84, 'RPG', 'PC, PS3, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/22380/header.jpg', 'Одиночная', 'Gamebryo', TRUE, 18),
('The Outer Worlds', 'Obsidian Entertainment', 'Private Division', '2019-10-25', 85, 'RPG', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/578650/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('Grounded', 'Obsidian Entertainment', 'Xbox Game Studios', '2022-09-27', 81, 'Выживание, Песочница', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/962130/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 12),
('Pentiment', 'Obsidian Entertainment', 'Xbox Game Studios', '2022-11-15', 82, 'RPG, Adventure', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1887720/header.jpg', 'Одиночная', 'Custom', TRUE, 16),
('Avowed', 'Obsidian Entertainment', 'Xbox Game Studios', '2025-02-18', 80, 'RPG', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2248820/header.jpg', 'Одиночная', 'Unreal Engine 5', TRUE, 18),
('Baldurs Gate 3', 'Larian Studios', 'Larian Studios', '2023-08-03', 96, 'RPG', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1086940/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Divinity Engine 4', TRUE, 18),

-- 61-70
('Divinity: Original Sin 2', 'Larian Studios', 'Larian Studios', '2017-09-14', 93, 'RPG', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/435150/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Divinity Engine 3', TRUE, 16),
('Solasta: Crown of the Magister', 'Tactical Adventures', 'Tactical Adventures', '2021-05-27', 78, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1061990/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 16),
('Pathfinder: Wrath of the Righteous', 'Owlcat Games', 'META Publishing', '2021-09-02', 80, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1184370/header.jpg', 'Одиночная', 'Unity', TRUE, 18),
('Pathfinder: Kingmaker', 'Owlcat Games', 'Deep Silver', '2018-09-25', 75, 'RPG', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/640820/header.jpg', 'Одиночная', 'Unity', TRUE, 18),
('Wasteland 3', 'inXile Entertainment', 'Deep Silver', '2020-08-28', 85, 'RPG', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/719040/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18),
('Torment: Tides of Numenera', 'Ninja Theory', 'Techland Publishing', '2017-02-28', 81, 'RPG', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/272270/header.jpg', 'Одиночная', 'Unity', TRUE, 16),
('Disco Elysium', 'ZA/UM', 'ZA/UM', '2019-10-15', 91, 'RPG', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/632470/header.jpg', 'Одиночная', 'Unity', TRUE, 18),
('Pillars of Eternity II', 'Obsidian Entertainment', 'Versus Evil', '2018-05-08', 88, 'RPG', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/560130/header.jpg', 'Одиночная', 'Unity', TRUE, 16),
('Tyranny', 'Obsidian Entertainment', 'Paradox Interactive', '2016-11-10', 80, 'RPG', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/362960/header.jpg', 'Одиночная', 'Unity', TRUE, 18),
('South Park: The Stick of Truth', 'Obsidian Entertainment', 'Ubisoft', '2014-03-04', 85, 'RPG', 'PC, PS3, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/206100/header.jpg', 'Одиночная', 'Unity', TRUE, 18),

-- 71-80
('South Park: The Fractured But Whole', 'Ubisoft San Francisco', 'Ubisoft', '2017-10-17', 85, 'RPG', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/488790/header.jpg', 'Одиночная', 'Snowdrop', TRUE, 18),
('Assassins Creed Valhalla', 'Ubisoft Montreal', 'Ubisoft', '2020-11-10', 84, 'Action, RPG', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2208920/header.jpg', 'Одиночная', 'AnvilNext 2.0', TRUE, 18),
('Assassins Creed Odyssey', 'Ubisoft Quebec', 'Ubisoft', '2018-10-05', 83, 'Action, RPG', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/812140/header.jpg', 'Одиночная', 'AnvilNext 2.0', TRUE, 18),
('Assassins Creed Origins', 'Ubisoft Montreal', 'Ubisoft', '2017-10-27', 81, 'Action, RPG', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/582160/header.jpg', 'Одиночная', 'AnvilNext 2.0', TRUE, 18),
('Far Cry 6', 'Ubisoft Toronto', 'Ubisoft', '2021-10-07', 73, 'Шутер, Action', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2369390/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Dunia', TRUE, 18),
('Far Cry 5', 'Ubisoft Montreal', 'Ubisoft', '2018-03-27', 81, 'Шутер, Action', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/552520/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Dunia', TRUE, 18),
('Watch Dogs: Legion', 'Ubisoft Toronto', 'Ubisoft', '2020-10-29', 64, 'Action, Adventure', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2239550/header.jpg', 'Одиночная, Мультиплеер', 'Disrupt', TRUE, 18),
('Rainbow Six Siege', 'Ubisoft Montreal', 'Ubisoft', '2015-12-01', 80, 'Шутер, Тактический', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/359550/header.jpg', 'Мультиплеер', 'AnvilNext 2.0', TRUE, 16),
('Prince of Persia: The Lost Crown', 'Ubisoft Montpellier', 'Ubisoft', '2024-01-15', 86, 'Action, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2279160/header.jpg', 'Одиночная', 'Ubisoft Anvil', TRUE, 12),
('Immortals Fenyx Rising', 'Ubisoft Quebec', 'Ubisoft', '2020-12-03', 77, 'Action, Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2221490/header.jpg', 'Одиночная', 'AnvilNext 2.0', TRUE, 12),

-- 81-90
('Forza Horizon 5', 'Playground Games', 'Xbox Game Studios', '2021-11-09', 92, 'Гонки', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1551360/header.jpg', 'Одиночная, Мультиплеер', 'ForzaTech', TRUE, 6),
('Forza Motorsport', 'Turn 10 Studios', 'Xbox Game Studios', '2023-10-10', 84, 'Гонки', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2036530/header.jpg', 'Одиночная, Мультиплеер', 'ForzaTech', TRUE, 6),
('Halo Infinite', '343 Industries', 'Xbox Game Studios', '2021-12-08', 87, 'Шутер', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1240440/header.jpg', 'Одиночная, Мультиплеер', 'Slipspace Engine', TRUE, 16),
('Gears 5', 'The Coalition', 'Xbox Game Studios', '2019-09-10', 84, 'Шутер', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1097840/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18),
('Sea of Thieves', 'Rare', 'Xbox Game Studios', '2018-03-20', 69, 'Action, Adventure', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1172620/header.jpg', 'Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 12),
('State of Decay 2', 'Undead Labs', 'Xbox Game Studios', '2018-05-22', 64, 'Выживание, Хоррор', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1097840/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 3', TRUE, 18),
('Microsoft Flight Simulator', 'Asobo Studio', 'Xbox Game Studios', '2020-08-18', 91, 'Симулятор', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1250410/header.jpg', 'Одиночная, Мультиплеер', 'Asobo Engine', TRUE, 6),
('Age of Empires IV', 'Relic Entertainment', 'Xbox Game Studios', '2021-10-28', 81, 'Стратегия', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1466860/header.jpg', 'Одиночная, Мультиплеер', 'Essence Engine 5', TRUE, 12),
('Starcraft II', 'Blizzard Entertainment', 'Blizzard Entertainment', '2010-07-27', 93, 'Стратегия', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/11110/header.jpg', 'Одиночная, Мультиплеер', 'Galaxy Engine', TRUE, 12),
('Diablo IV', 'Blizzard Entertainment', 'Blizzard Entertainment', '2023-06-06', 86, 'Action, RPG', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2344520/header.jpg', 'Одиночная, Мультиплеер', 'Custom', TRUE, 18),

-- 91-100
('Diablo II: Resurrected', 'Vicarious Visions', 'Blizzard Entertainment', '2021-09-23', 80, 'Action, RPG', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2107260/header.jpg', 'Одиночная, Мультиплеер', 'Custom', TRUE, 16),
('Diablo III', 'Blizzard Entertainment', 'Blizzard Entertainment', '2012-05-15', 88, 'Action, RPG', 'PC, PS3, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1085660/header.jpg', 'Одиночная, Мультиплеер', 'Custom', TRUE, 16),
('Overwatch 2', 'Blizzard Entertainment', 'Blizzard Entertainment', '2022-10-04', 79, 'Шутер', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2357570/header.jpg', 'Мультиплеер', 'Custom', TRUE, 12),
('World of Warcraft', 'Blizzard Entertainment', 'Blizzard Entertainment', '2004-11-23', 93, 'MMORPG', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1085660/header.jpg', 'Мультиплеер, MMO', 'Custom', TRUE, 12),
('Hearthstone', 'Blizzard Entertainment', 'Blizzard Entertainment', '2014-03-11', 88, 'Карточная', 'PC, Mobile', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1085660/header.jpg', 'Одиночная, Мультиплеер', 'Custom', TRUE, 12),
('Destiny 2', 'Bungie', 'Bungie', '2017-09-06', 85, 'Шутер, Action', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1085640/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Blender Engine', TRUE, 16),
('Marathon', 'Bungie', 'Bungie', '2025-07-22', 80, 'Шутер', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2744440/header.jpg', 'Мультиплеер', 'Custom', FALSE, 16),
('Hades', 'Supergiant Games', 'Supergiant Games', '2020-09-17', 93, 'Roguelike, Action', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1145360/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Hades II', 'Supergiant Games', 'Supergiant Games', '2024-05-06', 88, 'Roguelike, Action', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1145350/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Bastion', 'Supergiant Games', 'Supergiant Games', '2011-07-20', 86, 'Action, RPG', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/107100/header.jpg', 'Одиночная', 'Custom', TRUE, 12),

-- 101-110
('Transistor', 'Supergiant Games', 'Supergiant Games', '2014-05-20', 83, 'Action, RPG', 'PC, PS4, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/237930/header.jpg', 'Одиночная', 'Custom', TRUE, 16),
('Pyre', 'Supergiant Games', 'Supergiant Games', '2017-07-25', 81, 'RPG', 'PC, PS4', 'https://cdn.cloudflare.steamstatic.com/steam/apps/462770/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Dead Cells', 'Motion Twin', 'Motion Twin', '2018-08-07', 89, 'Roguelike, Action', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/588650/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Returnal', 'Housemarque', 'Sony Interactive Entertainment', '2023-02-15', 86, 'Roguelike, Шутер', 'PC, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1649240/header.jpg', 'Одиночная', 'Custom', TRUE, 16),
('Risk of Rain 2', 'Hopoo Games', 'Gearbox Publishing', '2020-08-11', 85, 'Roguelike, Шутер', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/632360/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12),
('Slay the Spire', 'MegaCrit', 'Humble Games', '2017-11-14', 89, 'Roguelike, Карточная', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/646570/header.jpg', 'Одиночная', 'LibGDX', TRUE, 12),
('Cuphead', 'Studio MDHR', 'Studio MDHR', '2017-09-29', 86, 'Action, Platformer', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/268910/header.jpg', 'Одиночная, Кооператив', 'Unity', TRUE, 12),
('Hollow Knight', 'Team Cherry', 'Team Cherry', '2017-02-24', 87, 'Metroidvania, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/367520/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Silksong', 'Team Cherry', 'Team Cherry', '2025-06-19', 85, 'Metroidvania, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1030300/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Ori and the Will of the Wisps', 'Moon Studios', 'Xbox Game Studios', '2020-03-11', 90, 'Metroidvania, Platformer', 'PC, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1057090/header.jpg', 'Одиночная', 'Unity', TRUE, 6),

-- 111-120
('Ori and the Blind Forest', 'Moon Studios', 'Xbox Game Studios', '2015-03-11', 88, 'Metroidvania, Platformer', 'PC, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/261570/header.jpg', 'Одиночная', 'Unity', TRUE, 6),
('Celeste', 'Maddy Makes Games', 'Maddy Makes Games', '2018-01-25', 92, 'Platformer', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/504230/header.jpg', 'Одиночная', 'GameMaker', TRUE, 12),
('Super Meat Boy', 'Team Meat', 'Team Meat', '2010-10-20', 87, 'Platformer', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/40800/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Super Meat Boy Forever', 'Team Meat', 'Team Meat', '2020-12-10', 65, 'Platformer', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1092720/header.jpg', 'Одиночная, Кооператив', 'Unity', TRUE, 12),
('The Binding of Isaac: Rebirth', 'Nicalis', 'Nicalis', '2014-11-04', 90, 'Roguelike', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/250900/header.jpg', 'Одиночная, Кооператив', 'Custom', TRUE, 16),
('Enter the Gungeon', 'Dodge Roll', 'Devolver Digital', '2016-04-05', 84, 'Roguelike, Шутер', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/311690/header.jpg', 'Одиночная, Кооператив', 'Unity', TRUE, 12),
('Gunfire Reborn', 'Duoyi Games', 'Duoyi Games', '2021-10-27', 82, 'Roguelike, Шутер', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1217060/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12),
('Vampire Survivors', 'poncle', 'poncle', '2022-10-20', 87, 'Roguelike, Action', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1794680/header.jpg', 'Одиночная, Кооператив', 'Custom', TRUE, 12),
('Terraria', 'Re-Logic', 'Re-Logic', '2011-05-16', 83, 'Песочница, Action', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/105600/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12),
('Stardew Valley', 'ConcernedApe', 'ConcernedApe', '2016-02-26', 89, 'Симулятор фермы, RPG', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/413150/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12),

-- 121-130
('Valheim', 'Iron Gate AB', 'Coffee Stain Publishing', '2021-02-02', 80, 'Выживание, Песочница', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/892970/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 12),
('Rust', 'Facepunch Studios', 'Facepunch Studios', '2018-02-08', 69, 'Выживание', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/252490/header.jpg', 'Мультиплеер', 'Unity', TRUE, 18),
('ARK: Survival Evolved', 'Studio Wildcard', 'Studio Wildcard', '2017-08-29', 70, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/346110/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 16),
('Conan Exiles', 'Funcom', 'Funcom', '2018-05-08', 70, 'Выживание', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/440900/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18),
('The Forest', 'Endnight Games', 'Endnight Games', '2018-04-30', 83, 'Выживание, Хоррор', 'PC, PS4', 'https://cdn.cloudflare.steamstatic.com/steam/apps/242760/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18),
('Sons of the Forest', 'Endnight Games', 'Endnight Games', '2024-02-22', 80, 'Выживание, Хоррор', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1326470/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18),
('Green Hell', 'Creepy Jar', 'Creepy Jar', '2019-09-05', 78, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/815370/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unity', TRUE, 18),
('Subnautica', 'Unknown Worlds', 'Unknown Worlds', '2018-01-23', 87, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/264710/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Subnautica: Below Zero', 'Unknown Worlds', 'Unknown Worlds', '2021-05-14', 78, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/848450/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('No Mans Sky', 'Hello Games', 'Hello Games', '2016-08-09', 71, 'Выживание, Sci-Fi', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/275850/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12),

-- 131-140
('Elite Dangerous', 'Frontier Developments', 'Frontier Developments', '2014-12-16', 82, 'Симулятор, Sci-Fi', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/359320/header.jpg', 'Одиночная, Мультиплеер', 'Custom', TRUE, 12),
('Kerbal Space Program', 'Squad', 'Private Division', '2015-04-27', 88, 'Симулятор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/220200/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Cities: Skylines', 'Colossal Order', 'Paradox Interactive', '2015-03-10', 85, 'Градостроительный симулятор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/255710/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Cities: Skylines II', 'Colossal Order', 'Paradox Interactive', '2023-10-24', 68, 'Градостроительный симулятор', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/949230/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Planet Coaster', 'Frontier Developments', 'Frontier Developments', '2016-11-17', 84, 'Симулятор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/493340/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Planet Zoo', 'Frontier Developments', 'Frontier Developments', '2019-11-05', 83, 'Симулятор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/703080/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Jurassic World Evolution 2', 'Frontier Developments', 'Frontier Developments', '2021-11-09', 76, 'Симулятор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1244460/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Two Point Hospital', 'Two Point Studios', 'Sega', '2018-08-30', 83, 'Симулятор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/535930/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Two Point Campus', 'Two Point Studios', 'Sega', '2022-08-09', 81, 'Симулятор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1288240/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('RimWorld', 'Ludeon Studios', 'Ludeon Studios', '2018-10-17', 87, 'Стратегия, Симулятор', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/294100/header.jpg', 'Одиночная', 'Custom', TRUE, 16),

-- 141-150
('Factorio', 'Wube Software', 'Wube Software', '2020-08-14', 90, 'Стратегия, Симулятор', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/427520/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12),
('Satisfactory', 'Coffee Stain Studios', 'Coffee Stain Publishing', '2024-09-10', 87, 'Симулятор', 'PC, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/526870/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 12),
('Dyson Sphere Program', 'Youthcat Studio', 'Gamera Game', '2021-01-21', 84, 'Стратегия, Симулятор', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1366540/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Oxygen Not Included', 'Klei Entertainment', 'Klei Entertainment', '2019-07-30', 85, 'Стратегия, Симулятор', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/457140/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Dont Starve Together', 'Klei Entertainment', 'Klei Entertainment', '2016-04-21', 83, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/322330/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Custom', TRUE, 12),
('Dont Starve', 'Klei Entertainment', 'Klei Entertainment', '2013-04-23', 79, 'Выживание', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/219740/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Mark of the Ninja', 'Klei Entertainment', 'Klei Entertainment', '2012-09-07', 84, 'Stealth, Platformer', 'PC, PS4, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/214490/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Invisible Inc', 'Klei Entertainment', 'Klei Entertainment', '2015-05-12', 82, 'Stealth, Стратегия', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/336140/header.jpg', 'Одиночная', 'Custom', TRUE, 16),
('Griftlands', 'Klei Entertainment', 'Klei Entertainment', '2021-06-01', 81, 'RPG, Карточная', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/601840/header.jpg', 'Одиночная, Мультиплеер', 'Custom', TRUE, 16),
('Among Us', 'Innersloth', 'Innersloth', '2018-06-15', 85, 'Социальная, Мультиплеер', 'PC, Mobile, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/945360/header.jpg', 'Мультиплеер', 'Unity', TRUE, 12),

-- 151-160
('Fall Guys', 'Mediatonic', 'Epic Games', '2020-08-04', 81, 'Party, Platformer', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1097150/header.jpg', 'Мультиплеер', 'Unity', TRUE, 6),
('Rocket League', 'Psyonix', 'Psyonix', '2015-07-07', 86, 'Спорт, Гонки', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/252950/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 3', TRUE, 6),
('FIFA 23', 'EA Vancouver', 'Electronic Arts', '2022-09-30', 77, 'Спорт', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1811260/header.jpg', 'Одиночная, Мультиплеер', 'Frostbite', TRUE, 6),
('EA Sports FC 24', 'EA Vancouver', 'Electronic Arts', '2023-09-29', 75, 'Спорт', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2195250/header.jpg', 'Одиночная, Мультиплеер', 'Frostbite', TRUE, 6),
('NBA 2K24', 'Visual Concepts', '2K Sports', '2023-09-08', 73, 'Спорт', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2344000/header.jpg', 'Одиночная, Мультиплеер', 'Custom', TRUE, 6),
('F1 23', 'Codemasters', 'EA Sports', '2023-06-16', 82, 'Гонки', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2108330/header.jpg', 'Одиночная, Мультиплеер', 'EGO', TRUE, 6),
('Dirt Rally 2.0', 'Codemasters', 'Codemasters', '2019-02-26', 84, 'Гонки', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/958400/header.jpg', 'Одиночная, Мультиплеер', 'EGO', TRUE, 6),
('Grid Legends', 'Codemasters', 'EA Sports', '2022-02-25', 77, 'Гонки', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1307710/header.jpg', 'Одиночная, Мультиплеер', 'EGO', TRUE, 6),
('Need for Speed Unbound', 'Criterion Games', 'Electronic Arts', '2022-12-02', 79, 'Гонки', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1846360/header.jpg', 'Одиночная, Мультиплеер', 'Ghost', TRUE, 12),
('Burnout Paradise', 'Criterion Games', 'Electronic Arts', '2009-04-09', 88, 'Гонки', 'PC, PS3, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/24740/header.jpg', 'Одиночная, Мультиплеер', 'RenderWare', TRUE, 12),

-- 161-170
('It Takes Two', 'Hazelight Studios', 'Electronic Arts', '2021-03-26', 88, 'Action, Adventure', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1426210/header.jpg', 'Кооператив', 'Unreal Engine 4', TRUE, 12),
('A Way Out', 'Hazelight Studios', 'Electronic Arts', '2018-03-23', 78, 'Action, Adventure', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1222700/header.jpg', 'Кооператив', 'Unreal Engine 4', TRUE, 18),
('Stray', 'BlueTwelve Studio', 'Annapurna Interactive', '2022-07-19', 83, 'Adventure', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1332010/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 12),
('Firewatch', 'Campo Santo', 'Campo Santo', '2016-02-09', 81, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/383870/header.jpg', 'Одиночная', 'Unity', TRUE, 16),
('What Remains of Edith Finch', 'Giant Sparrow', 'Annapurna Interactive', '2017-04-25', 87, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/501300/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 16),
('The Stanley Parable', 'Galactic Cafe', 'Galactic Cafe', '2013-10-17', 88, 'Adventure', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/221910/header.jpg', 'Одиночная', 'Source', TRUE, 12),
('The Stanley Parable: Ultra Deluxe', 'Galactic Cafe', 'Galactic Cafe', '2022-04-27', 85, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1703340/header.jpg', 'Одиночная', 'Unity', TRUE, 12),
('Life is Strange', 'Dontnod Entertainment', 'Square Enix', '2015-01-30', 83, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/319630/header.jpg', 'Одиночная', 'Unreal Engine 3', TRUE, 16),
('Life is Strange: True Colors', 'Deck Nine', 'Square Enix', '2021-09-10', 79, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/936790/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 16),
('Tell Me Why', 'Dontnod Entertainment', 'Xbox Game Studios', '2020-08-27', 75, 'Adventure', 'PC, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1171980/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 16),

-- 171-180
('Oxenfree', 'Night School Studio', 'Night School Studio', '2016-01-15', 81, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/388880/header.jpg', 'Одиночная', 'Unity', TRUE, 16),
('Night in the Woods', 'Infinite Fall', 'Finji', '2017-02-21', 85, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/481510/header.jpg', 'Одиночная', 'Unity', TRUE, 16),
('Gone Home', 'The Fullbright Company', 'The Fullbright Company', '2013-08-15', 75, 'Adventure', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/232430/header.jpg', 'Одиночная', 'Unity', TRUE, 16),
('Dear Esther', 'The Chinese Room', 'The Chinese Room', '2012-02-14', 77, 'Adventure', 'PC', 'https://cdn.cloudflare.steamstatic.com/steam/apps/203810/header.jpg', 'Одиночная', 'Source', TRUE, 16),
('Everybody Gone to the Rapture', 'The Chinese Room', 'Sony Interactive Entertainment', '2015-08-11', 71, 'Adventure', 'PC, PS4', 'https://cdn.cloudflare.steamstatic.com/steam/apps/416420/header.jpg', 'Одиночная', 'Custom', TRUE, 12),
('Amnesia: The Dark Descent', 'Frictional Games', 'Frictional Games', '2010-09-08', 85, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/57300/header.jpg', 'Одиночная', 'HPL Engine', TRUE, 18),
('Amnesia: Rebirth', 'Frictional Games', 'Frictional Games', '2020-10-20', 78, 'Хоррор', 'PC, PS4', 'https://cdn.cloudflare.steamstatic.com/steam/apps/997170/header.jpg', 'Одиночная', 'HPL Engine', TRUE, 18),
('Amnesia: The Bunker', 'Frictional Games', 'Frictional Games', '2023-06-06', 82, 'Хоррор, Выживание', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1944000/header.jpg', 'Одиночная', 'HPL Engine', TRUE, 18),
('SOMA', 'Frictional Games', 'Frictional Games', '2015-09-22', 84, 'Хоррор, Sci-Fi', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/282140/header.jpg', 'Одиночная', 'HPL Engine', TRUE, 18),
('Outlast', 'Red Barrels', 'Red Barrels', '2013-09-04', 80, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/238320/header.jpg', 'Одиночная', 'Unreal Engine 3', TRUE, 18),

-- 181-190
('Outlast II', 'Red Barrels', 'Red Barrels', '2017-04-25', 77, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/414700/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('The Outlast Trials', 'Red Barrels', 'Red Barrels', '2024-03-05', 78, 'Хоррор', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1398650/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18),
('Layers of Fear', 'Bloober Team', 'Bloober Team', '2016-02-16', 71, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/391720/header.jpg', 'Одиночная', 'Unity', TRUE, 18),
('Layers of Fear 2', 'Bloober Team', 'Bloober Team', '2019-06-04', 73, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/639520/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('The Medium', 'Bloober Team', 'Bloober Team', '2021-01-28', 73, 'Хоррор', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1097890/header.jpg', 'Одиночная', 'Northlight Engine', TRUE, 18),
('Blair Witch', 'Bloober Team', 'Bloober Team', '2019-08-30', 65, 'Хоррор', 'PC, PS4, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/943990/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('Observer: System Redux', 'Bloober Team', 'Bloober Team', '2017-08-15', 74, 'Хоррор, Cyberpunk', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1086000/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('Visage', 'SadSquare Studio', 'SadSquare Studio', '2020-10-30', 79, 'Хоррор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/594780/header.jpg', 'Одиночная', 'Unity', TRUE, 18),
('MADiSON', 'BLOODIOUS GAMES', 'BLOODIOUS GAMES', '2022-07-08', 76, 'Хоррор', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1331950/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('The Callisto Protocol', 'Striking Distance Studios', 'Krafton', '2022-12-02', 68, 'Хоррор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1644860/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),

-- 191-200
('Dead Space', 'Motive Studio', 'Electronic Arts', '2023-01-27', 89, 'Хоррор', 'PC, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1693980/header.jpg', 'Одиночная', 'Frostbite', TRUE, 18),
('Dead Space 2', 'Visceral Games', 'Electronic Arts', '2011-01-25', 87, 'Хоррор', 'PC, PS3, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/47780/header.jpg', 'Одиночная', 'Vicious Engine', TRUE, 18),
('Dead Space 3', 'Visceral Games', 'Electronic Arts', '2013-02-05', 78, 'Хоррор, Action', 'PC, PS3, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/174100/header.jpg', 'Одиночная, Кооператив', 'Vicious Engine', TRUE, 18),
('Alien: Isolation', 'Creative Assembly', 'Sega', '2014-10-07', 81, 'Хоррор, Выживание', 'PC, PS4, PS5, Xbox, Switch', 'https://cdn.cloudflare.steamstatic.com/steam/apps/214490/header.jpg', 'Одиночная', 'Alien Engine', TRUE, 18),
('The Evil Within', 'Tango Gameworks', 'Bethesda Softworks', '2014-10-14', 75, 'Хоррор', 'PC, PS3, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/268050/header.jpg', 'Одиночная', 'id Tech 5', TRUE, 18),
('Until Dawn', 'Supermassive Games', 'Sony Interactive Entertainment', '2024-10-04', 79, 'Хоррор', 'PC, PS4, PS5', 'https://cdn.cloudflare.steamstatic.com/steam/apps/2061390/header.jpg', 'Одиночная', 'Unreal Engine 4', TRUE, 18),
('The Quarry', 'Supermassive Games', '2K Games', '2022-06-10', 75, 'Хоррор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1244460/header.jpg', 'Одиночная, Мультиплеер', 'Unreal Engine 4', TRUE, 18),
('The Dark Pictures: Man of Medan', 'Supermassive Games', 'Bandai Namco', '2019-08-30', 69, 'Хоррор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/943980/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18),
('The Dark Pictures: Little Hope', 'Supermassive Games', 'Bandai Namco', '2020-10-15', 68, 'Хоррор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1195610/header.jpg', 'Одиночная, Мультиплеер', 'Unreal Engine 4', TRUE, 18),
('The Dark Pictures: House of Ashes', 'Supermassive Games', 'Bandai Namco', '2021-10-26', 72, 'Хоррор', 'PC, PS4, PS5, Xbox', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1281590/header.jpg', 'Одиночная, Мультиплеер, Кооператив', 'Unreal Engine 4', TRUE, 18);

-- Create indexes for sorting fields as per README requirements
CREATE INDEX idx_title ON games(title);
CREATE INDEX idx_publisher ON games(publisher);
CREATE INDEX idx_release_date ON games(release_date);
CREATE INDEX idx_metacritic_score ON games(metacritic_score);
CREATE INDEX idx_age_rating ON games(age_rating);

-- Query example with all 5 sorting fields
-- SELECT * FROM games ORDER BY title, publisher, release_date, metacritic_score, age_rating;
