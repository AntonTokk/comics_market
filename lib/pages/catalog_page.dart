import 'package:flutter/material.dart';
import '../models/comic.dart';
import '../widgets/comic_card.dart';

class CatalogPage extends StatefulWidget {
  final List<Comic> comics;

  const CatalogPage({super.key, required this.comics});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  void _toggleFavorite(Comic comic) {
    setState(() {
      comic.isFavorite = !comic.isFavorite;
    });
  }

  void _toggleCart(Comic comic) {
    setState(() {
      comic.isInCart = !comic.isInCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог комиксов'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        padding: EdgeInsets.all(8.0),
        itemCount: widget.comics.length,
        itemBuilder: (context, index) {
          return ComicCard(
            comic: widget.comics[index],
            onFavoriteTap: _toggleFavorite,
            onCartTap: _toggleCart,
          );
        },
      ),
    );
  }
}