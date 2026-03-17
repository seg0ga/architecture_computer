# Запись №1
### 13.03.2026 Демин С. - Начата работа над базой данных
#### Структура БД
|id|title|developer|publisher|release_date|metacritic_score|genre|platform|cover|game_modes|engine|russian_language|age_rating|system_requirements|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| 1 | Phasmophobia | Kinetic Games | Kinetic Games | 2020-09-18 | 79 | Хоррор, Симулятор | PC ||Одиночная, Мультиплеер, Кооператив |Unity|✅|12|-|
| 2 | Cyberpunk 2077 | CD Projekt Red | CD Projekt | 2020-12-10 | 86 | RPG, Open World | PC, PS5, Xbox ||Одиночная |REDengine 4|✅|18|-|
|...|...|...|...|...|...|...|...|...|...|
| n | CS2 | Valve | Valve | 2023-09-27 | 83 | Шутер, Тактический | PC | | Мультиплеер |Source 2|✅|16|-|

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


#### Сортировка
Сортрировка **должна** осуществляться по 5 полям:
1. По названию Quick Sort)
2. По издателю (Quick Sort)
3. По дате выхода (Digital Sort)
4. По оценке не метакритике (Digital Sort)
5. По возрастным ограничениям (Digital Sort)

#### Построение дерева оптимального поиска
Построение дерева должно производится по:
1. Названию + издателю
2. Рейтинг + названию


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
21. Street Fighter 6
22. Final Fantasy VII Remake
23. Final Fantasy XIV
24. Kingdom Hearts III
25. NieR: Automata
26. Persona 5 Royal
27. Persona 4 Golden
28. Yakuza: Like a Dragon
29. Like a Dragon: Infinite Wealth
30. Ghost of Tsushima
31. Spider-Man Remastered
32. Spider-Man: Miles Morales
33. Ratchet & Clank: Rift Apart
34. Horizon Zero Dawn
35. Horizon Forbidden West
36. Death Stranding
37. Death Stranding 2
38. Metal Gear Solid V
39. Silent Hill 2
40. Alan Wake 2
41. Control
42. Max Payne 3
43. Quantum Break
44. Deathloop
45. Dishonored 2
46. Prey
47. Doom Eternal
48. Doom (2016)
49. Wolfenstein II: The New Colossus
50. Hi-Fi Rush
51. The Evil Within 2
52. Ghostwire: Tokyo
53. Starfield
54. Fallout 4
55. Fallout: New Vegas
56. The Outer Worlds
57. Grounded
58. Pentiment
59. Avowed
60. Baldurs Gate 3
61. Divinity: Original Sin 2
62. Solasta: Crown of the Magister
63. Pathfinder: Wrath of the Righteous
64. Pathfinder: Kingmaker
65. Wasteland 3
66. Torment: Tides of Numenera
67. Disco Elysium
68. Pillars of Eternity II
69. Tyranny
70. South Park: The Stick of Truth
71. South Park: The Fractured But Whole
72. Assassins Creed Valhalla
73. Assassins Creed Odyssey
74. Assassins Creed Origins
75. Far Cry 6
76. Far Cry 5
77. Watch Dogs: Legion
78. Rainbow Six Siege
79. Prince of Persia: The Lost Crown
80. Immortals Fenyx Rising
81. Forza Horizon 5
82. Forza Motorsport
83. Halo Infinite
84. Gears 5
85. Sea of Thieves
86. State of Decay 2
87. Microsoft Flight Simulator
88. Age of Empires IV
89. Starcraft II
90. Diablo IV
91. Diablo II: Resurrected
92. Diablo III
93. Overwatch 2
94. World of Warcraft
95. Hearthstone
96. Destiny 2
97. Marathon
98. Hades
99. Hades II
100. Bastion
101. Transistor
102. Pyre
103. Dead Cells
104. Returnal
105. Risk of Rain 2
106. Slay the Spire
107. Cuphead
108. Hollow Knight
109. Silksong
110. Ori and the Will of the Wisps
111. Ori and the Blind Forest
112. Celeste
113. Super Meat Boy
114. Super Meat Boy Forever
115. The Binding of Isaac: Rebirth
116. Enter the Gungeon
117. Gunfire Reborn
118. Vampire Survivors
119. Terraria
120. Stardew Valley
121. Valheim
122. Rust
123. ARK: Survival Evolved
124. Conan Exiles
125. The Forest
126. Sons of the Forest
127. Green Hell
128. Subnautica
129. Subnautica: Below Zero
130. No Mans Sky
131. Elite Dangerous
132. Kerbal Space Program
133. Cities: Skylines
134. Cities: Skylines II
135. Planet Coaster
136. Planet Zoo
137. Jurassic World Evolution 2
138. Two Point Hospital
139. Two Point Campus
140. RimWorld
141. Factorio
142. Satisfactory
143. Dyson Sphere Program
144. Oxygen Not Included
145. Dont Starve Together
146. Dont Starve
147. Mark of the Ninja
148. Invisible Inc
149. Griftlands
150. Among Us
151. Fall Guys
152. Rocket League
153. FIFA 23
154. EA Sports FC 24
155. NBA 2K24
156. F1 23
157. Dirt Rally 2.0
158. Grid Legends
159. Need for Speed Unbound
160. Burnout Paradise
161. It Takes Two
162. A Way Out
163. Stray
164. Firewatch
165. What Remains of Edith Finch
166. The Stanley Parable
167. The Stanley Parable: Ultra Deluxe
168. Life is Strange
169. Life is Strange: True Colors
170. Tell Me Why
171. Oxenfree
172. Night in the Woods
173. Gone Home
174. Dear Esther
175. Everybody's Gone to the Rapture
176. Amnesia: The Dark Descent
177. Amnesia: Rebirth
178. Amnesia: The Bunker
179. SOMA
180. Outlast
181. Outlast II
182. The Outlast Trials
183. Layers of Fear
184. Layers of Fear 2
185. The Medium
186. Blair Witch
187. Observer: System Redux
188. Visage
189. MADiSON
190. The Callisto Protocol
191. Dead Space
192. Dead Space 2
193. Dead Space 3
194. Alien: Isolation
195. The Evil Within
196. Until Dawn
197. The Quarry
198. The Dark Pictures: Man of Medan
199. The Dark Pictures: Little Hope
200. The Dark Pictures: House of Ashes
