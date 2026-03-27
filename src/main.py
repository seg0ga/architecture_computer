import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext
import sys
import os
import urllib.request
import io
import json
from PIL import Image, ImageTk, ImageDraw, ImageFont
import threading
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.db_manager import DatabaseManager
from src.game_index import GameIndex


class ImageCache:
    """Кэш для изображений"""
    def __init__(self):
        self.cache = {}
        self.loading = set()
    
    def get(self, title):
        return self.cache.get(title)
    
    def set(self, title, image):
        self.cache[title] = image
    
    def is_loading(self, title):
        return title in self.loading
    
    def set_loading(self, title, is_loading):
        if is_loading:
            self.loading.add(title)
        else:
            self.loading.discard(title)


class GameApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Game Library")
        self.root.geometry("1500x900")
        self.root.configure(bg='#0a0e1a')
        self.root.minsize(1200, 700)

        # Профессиональная цветовая схема
        self.colors = {
            'bg_primary': '#0a0e1a',      # Глубокий тёмный
            'bg_card': '#111827',          # Карточки
            'bg_input': '#1f2937',         # Поля ввода
            'border': '#374151',           # Границы
            'accent': '#6366f1',           # Индиго акцент
            'accent_hover': '#818cf8',     # Акцент hover
            'success': '#10b981',          # Зелёный
            'warning': '#f59e0b',          # Янтарный
            'danger': '#ef4444',           # Красный
            'text_primary': '#f9fafb',     # Белый текст
            'text_secondary': '#9ca3af',   # Серый текст
            'text_muted': '#6b7280',       # Приглушённый
        }

        self.image_cache = ImageCache()
        self.selected_game = None
        self.current_image = None

        self._setup_styles()
        self._create_header()

        self.db = DatabaseManager()
        if not self.db.connect():
            messagebox.showerror("Ошибка", "Не могу подключиться к базе данных!")
            root.destroy()
            return

        self.db.init_database()
        self.games = self.db.get_all_games()
        self.index = GameIndex(self.games)

        self._create_main_content()
        self._create_status_bar()

        self.show_sorted_list('title')

    def _setup_styles(self):
        style = ttk.Style()
        style.theme_use('clam')
        
        style.configure('TNotebook', background=self.colors['bg_primary'], borderwidth=0)
        style.configure('TNotebook.Tab', 
                       font=('Segoe UI', 11, 'bold'), 
                       padding=[25, 12],
                       background=self.colors['bg_card'], 
                       foreground=self.colors['text_secondary'],
                       borderwidth=0,
                       lightcolor=self.colors['bg_card'],
                       darkcolor=self.colors['bg_card'])
        style.map('TNotebook.Tab', 
                 background=[('selected', self.colors['bg_primary'])],
                 foreground=[('selected', self.colors['accent'])])
        
        style.configure('Treeview', 
                       background=self.colors['bg_card'], 
                       foreground=self.colors['text_primary'],
                       fieldbackground=self.colors['bg_card'], 
                       font=('Segoe UI', 10),
                       rowheight=40,
                       borderwidth=0,
                       relief=tk.FLAT)
        style.configure('Treeview.Heading', 
                       font=('Segoe UI', 10, 'bold'), 
                       background=self.colors['bg_card'],
                       foreground=self.colors['text_secondary'],
                       borderwidth=0,
                       relief=tk.FLAT,
                       padding=10)
        style.map('Treeview', 
                 background=[('selected', self.colors['accent'])],
                 foreground=[('selected', '#ffffff')])
        
        style.configure('Vertical.TScrollbar', 
                       background=self.colors['bg_card'],
                       troughcolor=self.colors['bg_primary'],
                       borderwidth=0,
                       arrowcolor=self.colors['text_muted'])

    def _create_header(self):
        header = tk.Frame(self.root, bg=self.colors['bg_card'], height=70)
        header.pack(fill=tk.X)
        header.pack_propagate(False)
        
        title_frame = tk.Frame(header, bg=self.colors['bg_card'])
        title_frame.pack(side=tk.LEFT, padx=30)
        
        tk.Label(title_frame, text="GAME", 
                font=('Segoe UI', 20, 'bold'), 
                bg=self.colors['bg_card'], 
                fg=self.colors['text_primary']).pack(side=tk.LEFT)
        tk.Label(title_frame, text="LIBRARY", 
                font=('Segoe UI', 20, 'bold'), 
                bg=self.colors['bg_card'], 
                fg=self.colors['accent']).pack(side=tk.LEFT, padx=8)
        
        # Разделитель
        tk.Frame(header, bg=self.colors['border'], height=1).pack(side=tk.BOTTOM, fill=tk.X)

    def _create_main_content(self):
        main_frame = tk.Frame(self.root, bg=self.colors['bg_primary'])
        main_frame.pack(fill=tk.BOTH, expand=True, padx=25, pady=25)

        self.notebook = ttk.Notebook(main_frame)
        self.notebook.pack(fill=tk.BOTH, expand=True)

        self._create_list_tab()
        self._create_search_tab()
        self._create_add_tab()
        self._create_stats_tab()

    def _create_list_tab(self):
        tab = tk.Frame(self.notebook, bg=self.colors['bg_primary'])
        self.notebook.add(tab, text="ВСЕ ИГРЫ")

        # Панель сортировки
        sort_frame = tk.Frame(tab, bg=self.colors['bg_card'])
        sort_frame.pack(fill=tk.X, pady=0)

        tk.Label(sort_frame, text="СОРТИРОВКА:", 
                font=('Segoe UI', 9, 'bold'), 
                bg=self.colors['bg_card'], 
                fg=self.colors['text_muted']).pack(side=tk.LEFT, padx=20, pady=15)

        sorts = [
            ("Название", 'title'),
            ("Издатель", 'publisher_title'),
            ("Дата", 'release_title'),
            ("Рейтинг", 'metacritic_title'),
            ("Возраст", 'age_title')
        ]

        self.sort_buttons = {}
        for text, sort_type in sorts:
            btn = tk.Button(sort_frame, text=text, 
                           font=('Segoe UI', 9, 'bold'),
                           bg=self.colors['bg_input'], 
                           fg=self.colors['text_primary'],
                           activebackground=self.colors['accent'],
                           activeforeground='#ffffff',
                           relief=tk.FLAT,
                           padx=20, pady=10,
                           cursor='hand2',
                           borderwidth=0,
                           command=lambda st=sort_type: self.show_sorted_list(st))
            btn.pack(side=tk.LEFT, padx=6, pady=12)
            self.sort_buttons[sort_type] = btn

        # Контент
        content_frame = tk.Frame(tab, bg=self.colors['bg_primary'])
        content_frame.pack(fill=tk.BOTH, expand=True, pady=15)

        # Список игр
        list_container = tk.Frame(content_frame, bg=self.colors['bg_card'])
        list_container.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        # Заголовки таблицы
        header_frame = tk.Frame(list_container, bg=self.colors['bg_input'], height=45)
        header_frame.pack(fill=tk.X)
        header_frame.pack_propagate(False)
        
        headers = [("НАЗВАНИЕ", 300), ("ИЗДАТЕЛЬ", 200), ("ДАТА", 120), ("РЕЙТИНГ", 90)]
        for text, width in headers:
            tk.Label(header_frame, text=text, 
                    font=('Segoe UI', 9, 'bold'),
                    bg=self.colors['bg_input'], 
                    fg=self.colors['text_muted'],
                    anchor=tk.W).pack(side=tk.LEFT, padx=20, fill=tk.X)

        tree_frame = tk.Frame(list_container, bg=self.colors['bg_card'])
        tree_frame.pack(fill=tk.BOTH, expand=True)

        self.list_tree = ttk.Treeview(tree_frame, 
                                      columns=('title', 'publisher', 'date', 'score'), 
                                      show='headings',
                                      height=20,
                                      selectmode='browse')
        
        for col in ['title', 'publisher', 'date', 'score']:
            self.list_tree.heading(col, text='')
        
        self.list_tree.column('title', width=300, minwidth=200)
        self.list_tree.column('publisher', width=200, minwidth=100)
        self.list_tree.column('date', width=120, minwidth=80)
        self.list_tree.column('score', width=90, minwidth=50)

        scroll_y = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL, command=self.list_tree.yview)
        self.list_tree.configure(yscrollcommand=scroll_y.set)

        self.list_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scroll_y.pack(side=tk.RIGHT, fill=tk.Y)

        # Панель деталей
        self._create_details_panel(content_frame)
        self.list_tree.bind('<<TreeviewSelect>>', self.on_game_select)

    def _create_details_panel(self, parent):
        details_frame = tk.Frame(parent, bg=self.colors['bg_primary'], width=520)
        details_frame.pack(side=tk.RIGHT, fill=tk.BOTH, padx=(20, 0))
        details_frame.pack_propagate(False)

        # Заголовок
        tk.Label(details_frame, text="ИНФОРМАЦИЯ", 
                font=('Segoe UI', 12, 'bold'), 
                bg=self.colors['bg_primary'], 
                fg=self.colors['text_muted']).pack(anchor=tk.W, padx=5, pady=(0, 10))

        # Изображение
        image_container = tk.Frame(details_frame, bg='#000000', height=260)
        image_container.pack(fill=tk.X)
        image_container.pack_propagate(False)
        
        self.image_label = tk.Label(image_container, bg='#000000')
        self.image_label.pack(expand=True)
        
        self.loading_label = tk.Label(details_frame, text="", 
                                     font=('Segoe UI', 9), 
                                     bg=self.colors['bg_primary'], 
                                     fg=self.colors['text_muted'])
        self.loading_label.pack(pady=5)

        # Прокручиваемая информация
        info_container = tk.Frame(details_frame, bg=self.colors['bg_primary'])
        info_container.pack(fill=tk.BOTH, expand=True)
        
        self.info_canvas = tk.Canvas(info_container, bg=self.colors['bg_primary'], 
                                     highlightthickness=0, borderwidth=0)
        scrollbar = ttk.Scrollbar(info_container, orient=tk.VERTICAL, command=self.info_canvas.yview)
        
        self.info_frame = tk.Frame(self.info_canvas, bg=self.colors['bg_primary'])
        
        self.info_frame.bind(
            "<Configure>",
            lambda e: self.info_canvas.configure(scrollregion=self.info_canvas.bbox("all"))
        )
        
        self.canvas_window = self.info_canvas.create_window((0, 0), window=self.info_frame, anchor="nw")
        self.info_canvas.configure(yscrollcommand=scrollbar.set)
        
        self.info_canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        
        # Прокрутка колесом мыши
        def _on_mousewheel(event):
            self.info_canvas.yview_scroll(int(-1*(event.delta/120)), "units")
        self.info_canvas.bind_all("<MouseWheel>", _on_mousewheel)
        
        # Поля информации
        self.game_info = {}
        fields = ['title', 'developer', 'publisher', 'release_date', 'metacritic_score', 
                  'genre', 'platform', 'engine', 'age_rating', 'russian_language', 'game_modes']

        labels = {
            'title': ('', 14, 'bold', self.colors['accent']),
            'developer': ('Разработчик', 10, 'normal', self.colors['text_secondary']),
            'publisher': ('Издатель', 10, 'normal', self.colors['text_secondary']),
            'release_date': ('Дата выхода', 10, 'normal', self.colors['text_secondary']),
            'metacritic_score': ('Metacritic', 11, 'bold', self.colors['warning']),
            'genre': ('Жанр', 10, 'normal', self.colors['text_secondary']),
            'platform': ('Платформы', 10, 'normal', self.colors['text_secondary']),
            'engine': ('Движок', 10, 'normal', self.colors['text_secondary']),
            'age_rating': ('Возраст', 10, 'normal', self.colors['text_secondary']),
            'russian_language': ('Русский язык', 10, 'normal', self.colors['text_secondary']),
            'game_modes': ('Режимы', 10, 'normal', self.colors['text_secondary']),
        }

        for field in fields:
            lbl_text, size, weight, color = labels[field]
            label = tk.Label(self.info_frame, text="", 
                           font=('Segoe UI', size, weight), 
                           bg=self.colors['bg_primary'],
                           fg=color,
                           wraplength=460, 
                           justify=tk.LEFT, 
                           anchor=tk.W,
                           pady=4)
            label.pack(fill=tk.X, pady=3)
            self.game_info[field] = (label, lbl_text)

        self.details_frame = details_frame

    def _create_search_tab(self):
        tab = tk.Frame(self.notebook, bg=self.colors['bg_primary'])
        self.notebook.add(tab, text="ПОИСК")

        # Контейнер
        container = tk.Frame(tab, bg=self.colors['bg_primary'])
        container.pack(fill=tk.BOTH, expand=True)

        # Поиск по названию
        title_card = tk.Frame(container, bg=self.colors['bg_card'])
        title_card.pack(fill=tk.X, padx=20, pady=15)

        tk.Label(title_card, text="ПОИСК ПО НАЗВАНИЮ", 
                font=('Segoe UI', 11, 'bold'), 
                bg=self.colors['bg_card'], 
                fg=self.colors['text_primary']).pack(anchor=tk.W, padx=20, pady=(20, 10))

        search_container = tk.Frame(title_card, bg=self.colors['bg_card'])
        search_container.pack(fill=tk.X, padx=20, pady=(0, 20))

        self.title_entry = tk.Entry(search_container, 
                                   font=('Segoe UI', 11), 
                                   bg=self.colors['bg_input'], 
                                   fg=self.colors['text_primary'],
                                   insertbackground=self.colors['text_primary'],
                                   relief=tk.FLAT,
                                   highlightthickness=1,
                                   highlightbackground=self.colors['border'],
                                   highlightcolor=self.colors['accent'])
        self.title_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(0, 10), pady=8)
        self.title_entry.bind('<Return>', lambda e: self.do_search_title())

        tk.Button(search_container, text="НАЙТИ", 
                 font=('Segoe UI', 10, 'bold'),
                 bg=self.colors['accent'], 
                 fg='#ffffff',
                 activebackground=self.colors['accent_hover'],
                 activeforeground='#ffffff',
                 relief=tk.FLAT,
                 padx=25, pady=10,
                 cursor='hand2',
                 borderwidth=0,
                 command=self.do_search_title).pack(side=tk.LEFT)

        # Поиск по издателю
        pub_card = tk.Frame(container, bg=self.colors['bg_card'])
        pub_card.pack(fill=tk.X, padx=20, pady=15)

        tk.Label(pub_card, text="ПОИСК ПО ИЗДАТЕЛЮ", 
                font=('Segoe UI', 11, 'bold'), 
                bg=self.colors['bg_card'], 
                fg=self.colors['text_primary']).pack(anchor=tk.W, padx=20, pady=(20, 10))

        search_container2 = tk.Frame(pub_card, bg=self.colors['bg_card'])
        search_container2.pack(fill=tk.X, padx=20, pady=(0, 20))

        self.pub_entry = tk.Entry(search_container2, 
                                 font=('Segoe UI', 11), 
                                 bg=self.colors['bg_input'], 
                                 fg=self.colors['text_primary'],
                                 insertbackground=self.colors['text_primary'],
                                 relief=tk.FLAT,
                                 highlightthickness=1,
                                 highlightbackground=self.colors['border'],
                                 highlightcolor=self.colors['accent'])
        self.pub_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(0, 10), pady=8)
        self.pub_entry.bind('<Return>', lambda e: self.do_search_publisher())

        tk.Button(search_container2, text="НАЙТИ", 
                 font=('Segoe UI', 10, 'bold'),
                 bg=self.colors['accent'], 
                 fg='#ffffff',
                 activebackground=self.colors['accent_hover'],
                 activeforeground='#ffffff',
                 relief=tk.FLAT,
                 padx=25, pady=10,
                 cursor='hand2',
                 borderwidth=0,
                 command=self.do_search_publisher).pack(side=tk.LEFT)

        # Результаты
        result_card = tk.Frame(container, bg=self.colors['bg_card'])
        result_card.pack(fill=tk.BOTH, expand=True, padx=20, pady=15)

        tk.Label(result_card, text="РЕЗУЛЬТАТЫ", 
                font=('Segoe UI', 11, 'bold'), 
                bg=self.colors['bg_card'], 
                fg=self.colors['text_primary']).pack(anchor=tk.W, padx=20, pady=(20, 10))

        tree_frame = tk.Frame(result_card, bg=self.colors['bg_card'])
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=(0, 20))

        self.search_tree = ttk.Treeview(tree_frame, 
                                        columns=('title', 'publisher', 'date', 'score', 'age'),
                                        show='headings',
                                        height=18)
        
        cols = [('title', 'Название', 300), ('publisher', 'Издатель', 180),
                ('date', 'Дата', 120), ('score', 'Рейтинг', 90), ('age', 'Возраст', 80)]
        for col, name, width in cols:
            self.search_tree.heading(col, text=name)
            self.search_tree.column(col, width=width)

        scroll = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL, command=self.search_tree.yview)
        self.search_tree.configure(yscrollcommand=scroll.set)

        self.search_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)

    def _create_add_tab(self):
        tab = tk.Frame(self.notebook, bg=self.colors['bg_primary'])
        self.notebook.add(tab, text="ДОБАВИТЬ")

        # Canvas с прокруткой
        canvas = tk.Canvas(tab, bg=self.colors['bg_primary'], highlightthickness=0, borderwidth=0)
        scrollbar = ttk.Scrollbar(tab, orient=tk.VERTICAL, command=canvas.yview)
        
        form_frame = tk.Frame(canvas, bg=self.colors['bg_primary'])
        
        form_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas_window = canvas.create_window((0, 0), window=form_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=25, pady=25)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y, pady=25)
        
        # Прокрутка колесом мыши
        def _on_mousewheel_add(event):
            canvas.yview_scroll(int(-1*(event.delta/120)), "units")
        canvas.bind_all("<MouseWheel>", _on_mousewheel_add)

        # Заголовок
        tk.Label(form_frame, text="НОВАЯ ИГРА", 
                font=('Segoe UI', 16, 'bold'), 
                bg=self.colors['bg_primary'], 
                fg=self.colors['text_primary']).pack(anchor=tk.W, pady=(0, 25))

        fields = [
            ('Название игры *', 'title'),
            ('Разработчик', 'developer'),
            ('Издатель', 'publisher'),
            ('Дата выхода (ГГГГ-ММ-ДД)', 'release_date'),
            ('Оценка Metacritic (0-100)', 'metacritic_score'),
            ('Возрастной рейтинг', 'age_rating'),
            ('Жанр', 'genre'),
            ('Платформы', 'platform'),
            ('Режимы игры', 'game_modes'),
            ('Движок', 'engine'),
        ]

        self.add_entries = {}
        for label_text, key in fields:
            container = tk.Frame(form_frame, bg=self.colors['bg_primary'])
            container.pack(fill=tk.X, pady=10)
            
            tk.Label(container, text=label_text, 
                    font=('Segoe UI', 10, 'bold'), 
                    bg=self.colors['bg_primary'], 
                    fg=self.colors['text_secondary'],
                    anchor=tk.W).pack(fill=tk.X, pady=(0, 8))
            
            entry = tk.Entry(container, 
                            font=('Segoe UI', 11), 
                            bg=self.colors['bg_card'], 
                            fg=self.colors['text_primary'],
                            insertbackground=self.colors['text_primary'],
                            relief=tk.FLAT,
                            highlightthickness=1,
                            highlightbackground=self.colors['border'],
                            highlightcolor=self.colors['accent'])
            entry.pack(fill=tk.X, pady=(0, 5))
            self.add_entries[key] = entry

        # Чекбокс
        check_frame = tk.Frame(form_frame, bg=self.colors['bg_primary'])
        check_frame.pack(fill=tk.X, pady=20)
        
        self.russian_var = tk.BooleanVar()
        check = tk.Checkbutton(check_frame, 
                              text="Есть русский язык", 
                              variable=self.russian_var,
                              bg=self.colors['bg_primary'], 
                              fg=self.colors['text_primary'],
                              selectcolor=self.colors['bg_card'],
                              activebackground=self.colors['bg_primary'],
                              activeforeground=self.colors['text_primary'],
                              font=('Segoe UI', 11),
                              relief=tk.FLAT,
                              cursor='hand2',
                              highlightthickness=0,
                              borderwidth=0)
        check.pack()

        # Кнопка
        tk.Button(form_frame, text="ДОБАВИТЬ ИГРУ", 
                 font=('Segoe UI', 12, 'bold'),
                 bg=self.colors['success'], 
                 fg='#ffffff',
                 activebackground='#059669',
                 activeforeground='#ffffff',
                 relief=tk.FLAT,
                 padx=50, pady=15,
                 cursor='hand2',
                 borderwidth=0,
                 command=self.add_game).pack(pady=30)

        self.add_status = tk.Label(form_frame, text="", 
                                  bg=self.colors['bg_primary'], 
                                  fg=self.colors['success'], 
                                  font=('Segoe UI', 10))
        self.add_status.pack()

    def _create_stats_tab(self):
        tab = tk.Frame(self.notebook, bg=self.colors['bg_primary'])
        self.notebook.add(tab, text="СТАТИСТИКА")

        container = tk.Frame(tab, bg=self.colors['bg_primary'])
        container.pack(fill=tk.BOTH, expand=True, padx=25, pady=25)

        # Заголовок и кнопка
        header_frame = tk.Frame(container, bg=self.colors['bg_primary'])
        header_frame.pack(fill=tk.X, pady=(0, 20))

        tk.Label(header_frame, text="СТАТИСТИКА ДЕРЕВЬЕВ", 
                font=('Segoe UI', 16, 'bold'), 
                bg=self.colors['bg_primary'], 
                fg=self.colors['text_primary']).pack(side=tk.LEFT)

        tk.Button(header_frame, text="ОБНОВИТЬ", 
                 font=('Segoe UI', 10, 'bold'),
                 bg=self.colors['accent'], 
                 fg='#ffffff',
                 activebackground=self.colors['accent_hover'],
                 activeforeground='#ffffff',
                 relief=tk.FLAT,
                 padx=25, pady=10,
                 cursor='hand2',
                 borderwidth=0,
                 command=self.show_stats).pack(side=tk.RIGHT)

        # Карточка статистики
        stats_card = tk.Frame(container, bg=self.colors['bg_card'])
        stats_card.pack(fill=tk.BOTH, expand=True)

        self.stats_text = scrolledtext.ScrolledText(stats_card, 
                                                    width=60, 
                                                    height=20, 
                                                    font=('Consolas', 10),
                                                    bg=self.colors['bg_card'], 
                                                    fg=self.colors['text_primary'],
                                                    insertbackground=self.colors['text_primary'],
                                                    relief=tk.FLAT,
                                                    padx=20,
                                                    pady=20,
                                                    highlightthickness=0,
                                                    borderwidth=0)
        self.stats_text.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        self.show_stats()

    def _create_status_bar(self):
        self.status = tk.Label(self.root, 
                              text="Готов", 
                              bd=0, 
                              relief=tk.FLAT, 
                              anchor=tk.W, 
                              bg=self.colors['bg_card'], 
                              fg=self.colors['text_muted'],
                              font=('Segoe UI', 9),
                              padx=25,
                              pady=8)
        self.status.pack(side=tk.BOTTOM, fill=tk.X)

    def get_steam_image(self, game_title):
        try:
            search_term = game_title.replace(' ', '%20')
            search_url = f"https://store.steampowered.com/api/storesearch/?term={search_term}&l=english&cc=us"
            
            req = urllib.request.Request(search_url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, timeout=8) as response:
                data = json.loads(response.read().decode())
                
                items = data.get('items', [])
                if items:
                    app_id = items[0].get('id')
                    if app_id:
                        detail_url = f"https://store.steampowered.com/api/appdetails?appids={app_id}"
                        detail_req = urllib.request.Request(detail_url, headers={'User-Agent': 'Mozilla/5.0'})
                        with urllib.request.urlopen(detail_req, timeout=8) as detail_resp:
                            detail_data = json.loads(detail_resp.read().decode())
                            if detail_data.get(str(app_id), {}).get('success'):
                                header_image = detail_data[str(app_id)]['data'].get('header_image')
                                if header_image:
                                    img_req = urllib.request.Request(header_image, headers={'User-Agent': 'Mozilla/5.0'})
                                    with urllib.request.urlopen(img_req, timeout=8) as img_resp:
                                        image_data = img_resp.read()
                                        image = Image.open(io.BytesIO(image_data))
                                        image = image.resize((400, 225), Image.Resampling.LANCZOS)
                                        return ImageTk.PhotoImage(image)
        except Exception as e:
            print(f"Image error for '{game_title}': {e}")
        
        return self._create_placeholder_image(game_title)

    def _create_placeholder_image(self, title):
        img = Image.new('RGB', (400, 225), color='#4f46e5')
        
        for i in range(225):
            for j in range(400):
                r = int(79 + (i / 225) * 50)
                g = int(70 + (i / 225) * 30)
                b = int(229 + (i / 225) * 26)
                img.putpixel((j, i), (min(r, 255), min(g, 255), min(b, 255)))
        
        try:
            draw = ImageDraw.Draw(img)
            
            font_sizes = [90, 80, 70, 60, 50]
            font = None
            for size in font_sizes:
                try:
                    font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", size)
                    break
                except:
                    try:
                        font = ImageFont.truetype("arial.ttf", size)
                        break
                    except:
                        continue
            
            if font is None:
                font = ImageFont.load_default()
            
            first_letter = title[0].upper() if title else '?'
            
            bbox = draw.textbbox((0, 0), first_letter, font=font)
            text_width = bbox[2] - bbox[0]
            text_height = bbox[3] - bbox[1]
            x = (400 - text_width) // 2
            y = (225 - text_height) // 2
            
            draw.text((x, y), first_letter, fill='white', font=font)
            
            short_title = title[:25] + '...' if len(title) > 28 else title
            small_font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 14) if font else ImageFont.load_default()
            bbox = draw.textbbox((0, 0), short_title, font=small_font)
            text_width = bbox[2] - bbox[0]
            draw.text(((400 - text_width) // 2, 195), short_title, fill='rgba(255,255,255,0.8)', font=small_font)
            
        except Exception as e:
            print(f"Placeholder error: {e}")
        
        return ImageTk.PhotoImage(img)

    def load_and_show_image(self, title):
        cached = self.image_cache.get(title)
        if cached:
            self.root.after(0, lambda: [self._update_image(cached), self.loading_label.config(text="")])
            return
        
        if self.image_cache.is_loading(title):
            return
        
        self.image_cache.set_loading(title, True)
        
        photo = self.get_steam_image(title)
        
        self.image_cache.set_loading(title, False)
        
        if photo:
            self.image_cache.set(title, photo)
            self.root.after(0, lambda: [self._update_image(photo), self.loading_label.config(text="")])

    def _update_image(self, photo):
        self.current_image = photo
        self.image_label.config(image=photo)

    def on_game_select(self, event):
        selection = self.list_tree.selection()
        if not selection:
            return

        item = self.list_tree.item(selection[0])
        title = item['values'][0]

        for game in self.games:
            if game['title'] == title or title.startswith(game['title'][:30]):
                self.selected_game = game
                self.show_game_details(game)
                break

    def show_game_details(self, game):
        """Показать информацию об игре"""
        # Название
        label, lbl_text = self.game_info['title']
        label.config(text=game['title'] if game['title'] else 'Не указано')
        
        # Разработчик
        label, lbl_text = self.game_info['developer']
        label.config(text=f"{lbl_text}: {game['developer'] if game['developer'] else 'Не указано'}")
        
        # Издатель
        label, lbl_text = self.game_info['publisher']
        label.config(text=f"{lbl_text}: {game['publisher'] if game['publisher'] else 'Не указано'}")
        
        # Дата выхода
        label, lbl_text = self.game_info['release_date']
        label.config(text=f"{lbl_text}: {game['release_date'] if game['release_date'] else 'Не указано'}")
        
        # Metacritic
        label, lbl_text = self.game_info['metacritic_score']
        score = game['metacritic_score'] if game['metacritic_score'] else 'Нет оценки'
        label.config(text=f"{lbl_text}: {score}")
        
        # Жанр
        label, lbl_text = self.game_info['genre']
        label.config(text=f"{lbl_text}: {game['genre'] if game['genre'] else 'Не указано'}")
        
        # Платформы
        label, lbl_text = self.game_info['platform']
        label.config(text=f"{lbl_text}: {game['platform'] if game['platform'] else 'Не указано'}")
        
        # Движок
        label, lbl_text = self.game_info['engine']
        label.config(text=f"{lbl_text}: {game['engine'] if game['engine'] else 'Не указано'}")
        
        # Возраст
        label, lbl_text = self.game_info['age_rating']
        age = f"{game['age_rating']}+" if game['age_rating'] else 'Не указано'
        label.config(text=f"{lbl_text}: {age}")
        
        # Русский язык
        label, lbl_text = self.game_info['russian_language']
        ru = "Есть" if game['russian_language'] else "Отсутствует"
        label.config(text=f"{lbl_text}: {ru}")
        
        # Режимы
        label, lbl_text = self.game_info['game_modes']
        label.config(text=f"{lbl_text}: {game['game_modes'] if game['game_modes'] else 'Не указано'}")

        # Обновляем canvas
        self.info_frame.update_idletasks()
        self.info_canvas.configure(scrollregion=self.info_canvas.bbox("all"))
        
        # Загружаем изображение
        self.image_label.config(image='')
        self.loading_label.config(text="Загрузка...")
        threading.Thread(target=self.load_and_show_image, args=(game['title'],), daemon=True).start()

    def show_sorted_list(self, sort_type):
        self.status.config(text=f"Сортировка: {sort_type}...")
        self.root.update()

        start = time.time()
        games = self.index.get_sorted_by(sort_type)
        elapsed = time.time() - start

        for item in self.list_tree.get_children():
            self.list_tree.delete(item)

        for game in games:
            score = f"{game['metacritic_score']}" if game['metacritic_score'] else '-'
            self.list_tree.insert('', tk.END, values=(
                game['title'][:45],
                game['publisher'][:30],
                str(game['release_date'])[:10],
                score
            ))

        for st, btn in self.sort_buttons.items():
            if st == sort_type:
                btn.config(bg=self.colors['accent'], fg='#ffffff')
            else:
                btn.config(bg=self.colors['bg_input'], fg=self.colors['text_primary'])

        self.status.config(text=f"Показано {len(games)} игр | {elapsed:.4f} сек")

    def do_search_title(self):
        query = self.title_entry.get().strip()
        if not query:
            messagebox.showinfo("Инфо", "Введите название для поиска")
            return

        start = time.time()
        results = self.index.search_by_title(query)
        elapsed = time.time() - start

        self.show_search_results(results)
        self.status.config(text=f"Найдено {len(results)} игр за {elapsed:.4f} сек")

    def do_search_publisher(self):
        query = self.pub_entry.get().strip()
        if not query:
            messagebox.showinfo("Инфо", "Введите издателя для поиска")
            return

        start = time.time()
        results = self.index.search_by_publisher(query)
        elapsed = time.time() - start

        self.show_search_results(results)
        self.status.config(text=f"Найдено {len(results)} игр за {elapsed:.4f} сек")

    def show_search_results(self, results):
        for item in self.search_tree.get_children():
            self.search_tree.delete(item)

        for game in results:
            score = f"{game['metacritic_score']}" if game['metacritic_score'] else '-'
            age = f"{game['age_rating']}+" if game['age_rating'] else '-'
            self.search_tree.insert('', tk.END, values=(
                game['title'][:45],
                game['publisher'][:30],
                str(game['release_date'])[:10],
                score,
                age
            ))

    def add_game(self):
        try:
            title = self.add_entries['title'].get().strip()
            if not title:
                messagebox.showerror("Ошибка", "Название игры обязательно!")
                return

            # Получаем значения
            developer = self.add_entries['developer'].get().strip() or None
            publisher = self.add_entries['publisher'].get().strip() or None
            release_date = self.add_entries['release_date'].get().strip() or None
            genre = self.add_entries['genre'].get().strip() or None
            platform = self.add_entries['platform'].get().strip() or None
            game_modes = self.add_entries['game_modes'].get().strip() or None
            engine = self.add_entries['engine'].get().strip() or None
            
            # Обработка числовых полей - 0 если пусто
            metacritic_str = self.add_entries['metacritic_score'].get().strip()
            metacritic = int(metacritic_str) if metacritic_str else 0
            
            age_str = self.add_entries['age_rating'].get().strip()
            age = int(age_str) if age_str else 0

            # Валидация
            if metacritic < 0 or metacritic > 100:
                messagebox.showerror("Ошибка", "Оценка Metacritic должна быть от 0 до 100")
                return
            
            if age < 0 or age > 100:
                messagebox.showerror("Ошибка", "Возрастной рейтинг должен быть от 0 до 100")
                return

            # Проверка формата даты
            if release_date:
                try:
                    from datetime import datetime
                    datetime.strptime(release_date, '%Y-%m-%d')
                except ValueError:
                    messagebox.showerror("Ошибка", "Дата должна быть в формате ГГГГ-ММ-ДД (например, 2024-01-15)")
                    return

            success, error = self.db.add_game(
                    title=title,
                    developer=developer,
                    publisher=publisher,
                    release_date=release_date,
                    metacritic_score=metacritic,
                    genre=genre,
                    platform=platform,
                    game_modes=game_modes,
                    engine=engine,
                    russian_language=self.russian_var.get(),
                    age_rating=age
            )
            
            if success:
                self.games = self.db.get_all_games()
                self.index = GameIndex(self.games)
                self.add_status.config(text="✓ Игра добавлена", fg=self.colors['success'])

                # Очищаем поля
                for entry in self.add_entries.values():
                    entry.delete(0, tk.END)
                self.russian_var.set(False)

                # Обновляем список
                self.show_sorted_list('title')
                messagebox.showinfo("Успех", f"Игра '{title}' добавлена!")
            else:
                messagebox.showerror("Ошибка добавления", error or "Не удалось добавить игру в базу данных")
                
        except ValueError as e:
            messagebox.showerror("Ошибка", f"Неверный формат данных:\n{e}")
        except Exception as e:
            messagebox.showerror("Ошибка", f"Произошла ошибка:\n{str(e)}")

    def show_stats(self):
        self.stats_text.delete(1.0, tk.END)
        stats = self.index.get_statistics()

        names = {
            'title': 'По названию',
            'publisher_title': 'По издателю + названию',
            'release_title': 'По дате выхода + названию',
            'metacritic_title': 'По Metacritic + названию',
            'age_title': 'По возрасту + названию'
        }

        self.stats_text.insert(tk.END, "=" * 58 + "\n")
        self.stats_text.insert(tk.END, "СТАТИСТИКА ДЕРЕВЬЕВ ПОИСКА\n")
        self.stats_text.insert(tk.END, "=" * 58 + "\n\n")

        for key, data in stats.items():
            name = names.get(key, key)
            self.stats_text.insert(tk.END, f"• {name}\n")
            self.stats_text.insert(tk.END, f"  Игр: {data['nodes']}\n")
            self.stats_text.insert(tk.END, f"  Высота: {data['height']}\n")
            self.stats_text.insert(tk.END, f"  Средняя высота: {data['avg_weighted_height']:.3f}\n\n")

        self.stats_text.insert(tk.END, "=" * 58 + "\n")
        self.stats_text.insert(tk.END, f"Всего игр: {len(self.games)}\n")


def main():
    root = tk.Tk()
    app = GameApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
