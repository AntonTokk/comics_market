import 'package:flutter/material.dart';
import '../models/comic.dart'; 

class ComicCard extends StatelessWidget {
  final Comic comic;
  final Function(Comic) onFavoriteTap; // Функция для добавления/удаления из избранного
  final Function(Comic) onCartTap; // Функция для добавления/удаления из корзины

  const ComicCard({super.key, 
    required this.comic,
    required this.onFavoriteTap,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Показываем описание комикса при нажатии
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(comic.title),
                content: Text(comic.description),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Закрываем диалог
                    },
                    child: Text('Закрыть'),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                comic.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comic.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${comic.price.toStringAsFixed(2)} ₽',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          comic.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: comic.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          onFavoriteTap(comic); // Вызываем функцию для добавления/удаления из избранного
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          comic.isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                          color: comic.isInCart ? Colors.blue : null,
                        ),
                        onPressed: () {
                          onCartTap(comic); // Вызываем функцию для добавления/удаления из корзины
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}