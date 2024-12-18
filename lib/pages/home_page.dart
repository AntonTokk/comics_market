import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Импортируйте файлы с экранами
import 'catalog_page.dart';
import 'favorites_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'chat_screen.dart';

// Импортируйте модель Comic
import '../models/comic.dart';

// Определите список comics
final List<Comic> comics = [
  Comic(
    title: 'Spider-Man: Blue',
    author: 'Jeph Loeb',
    price: 14.99 * 70,
    imageUrl: 'https://i.pinimg.com/736x/1d/a4/3d/1da43d8742b591be0dd6557410e701b7.jpg',
    category: 'Spider-Man',
    description: 'Это трогательная история о Питере Паркере и Гвен Стейси.',
    quantity: 5,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'Batman: Year One',
    author: 'Frank Miller',
    price: 19.99 * 70,
    imageUrl: 'https://s3.amazonaws.com/www.covernk.com/Covers/L/B/Batman+Year+One/batmanyearonetradepaperback1.jpg',
    category: 'Batman',
    description: 'Происхождение Бэтмена.',
    quantity: 7,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'Batman: The Long Halloween',
    author: 'Jeph Loeb',
    price: 22.99 * 70,
    imageUrl: 'https://static.tvtropes.org/pmwiki/pub/images/batman_long_halloween_cover.jpg',
    category: 'Batman',
    description: 'Годовая тайна для Бэтмена.',
    quantity: 4,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'Teenage Mutant Ninja Turtles: City at War',
    author: 'Kevin Eastman',
    price: 15.99 * 70,
    imageUrl: 'https://vignette.wikia.nocookie.net/tmnt/images/b/b0/Idw91.jpg/revision/latest?cb=20190214074102',
    category: 'Ninja Turtles',
    description: 'Черепашки сталкиваются с городской войной.',
    quantity: 6,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'Teenage Mutant Ninja Turtles: The Last Ronin',
    author: 'Kevin Eastman',
    price: 24.99 * 70,
    imageUrl: 'https://i.dailymail.co.uk/1s/2024/04/11/21/83526179-13298943-image-a-142_1712867277901.jpg',
    category: 'Ninja Turtles',
    description: 'Последний выживший Черепашка ищет мести.',
    quantity: 2,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'X-Men: Days of Future Past',
    author: 'Chris Claremont',
    price: 18.99 * 70,
    imageUrl: 'https://static.wikia.nocookie.net/marveldatabase/images/5/5b/True_Believers_X-Men_-_Pyro_Vol_1_1.jpg/revision/latest?cb=20191004182739',
    category: 'X-Men',
    description: 'Путешествие во времени, чтобы изменить будущее мутантов.',
    quantity: 4,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'X-Men: The Dark Phoenix Saga',
    author: 'Chris Claremont',
    price: 21.99 * 70,
    imageUrl: 'https://cdn.marvel.com/u/prod/marvel/i/mg/9/20/58b5d00e39b3c/clean.jpg',
    category: 'X-Men',
    description: 'История о разрушительной силе Темной Феникс.',
    quantity: 3,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'Avengers: Infinity War',
    author: 'Jonathan Hickman',
    price: 23.99 * 70,
    imageUrl: 'https://static.wikia.nocookie.net/marveldatabase/images/0/05/Infinity_War_Vol_1_2.jpg/revision/latest/scale-to-width-down/650?cb=20190417003856',
    category: 'Avengers',
    description: 'Битва за судьбу вселенной против Таноса.',
    quantity: 5,
    isFavorite: false,
    isInCart: false,
  ),
  Comic(
    title: 'Avengers: Endgame',
    author: 'Jason Aaron',
    price: 25.99 * 70,
    imageUrl: 'https://i.pinimg.com/736x/7c/f5/55/7cf55562edf630e4cf5d734ab34da648.jpg',
    category: 'Avengers',
    description: 'Финальная битва за восстановление вселенной.',
    quantity: 6,
    isFavorite: false,
    isInCart: false,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Список страниц, которые будут отображаться в BottomNavigationBar
  final List<Widget> _pages = [
    CatalogPage(comics: comics), // Передайте comics в CatalogPage
    FavoritesPage(comics: comics), // Передайте comics в FavoritesPage
    CartPage(comics: comics), // Передайте comics в CartPage
    ProfilePage(), // Профиль не требует comics
    ChatScreen(), // Чат не требует comics
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Магазин комиксов'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex], // Отображаем текущую страницу
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Обновляем текущий индекс
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: const Color.fromARGB(255, 77, 77, 77)), // Белый цвет иконки
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: const Color.fromARGB(255, 210, 14, 14)), // Белый цвет иконки
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: const Color.fromARGB(255, 12, 132, 231)), // Белый цвет иконки
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: const Color.fromARGB(255, 127, 10, 215)), // Белый цвет иконки
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: const Color.fromARGB(255, 31, 30, 30)), // Белый цвет иконки
            label: 'Чат',
          ),
        ],
        selectedItemColor: Colors.blue, // Цвет выбранной иконки
        unselectedItemColor: Colors.white, // Цвет невыбранных иконок
        backgroundColor: Colors.black, // Фон BottomNavigationBar
      ),
    );
  }
}