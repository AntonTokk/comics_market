import 'package:flutter/material.dart';
import '../models/comic.dart';
import '../widgets/comic_card.dart';

class FavoritesPage extends StatefulWidget {
  final List<Comic> comics;

  const FavoritesPage({super.key, required this.comics});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void _toggleFavorite(Comic comic) {
    setState(() {
      comic.isFavorite = !comic.isFavorite; // Переключаем состояние избранного
    });
  }

  void _toggleCart(Comic comic) {
    setState(() {
      comic.isInCart = !comic.isInCart; // Переключаем состояние корзины
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteComics = widget.comics.where((comic) => comic.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: favoriteComics.isEmpty
          ? Center(child: Text('Нет избранных комиксов'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              padding: EdgeInsets.all(8.0),
              itemCount: favoriteComics.length,
              itemBuilder: (context, index) {
                return ComicCard(
                  comic: favoriteComics[index],
                  onFavoriteTap: _toggleFavorite, // Передаем функцию для избранного
                  onCartTap: _toggleCart, // Передаем функцию для корзины
                );
              },
            ),
    );
  }
}