import 'package:flutter/material.dart';
import '../models/comic.dart';

class CartPage extends StatefulWidget {
  final List<Comic> comics;

  const CartPage({super.key, required this.comics});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  // Функция для вычисления общей суммы заказа
  double getTotalPrice() {
    double total = 0;
    for (var comic in widget.comics) {
      if (comic.isInCart) {
        total += comic.price;
      }
    }
    return total;
  }

  // Функция для оформления заказа
  void _placeOrder() {
    // Фильтруем только те комиксы, которые находятся в корзине
    final cartComics = widget.comics.where((comic) => comic.isInCart).toList();

    if (cartComics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ваша корзина пуста')),
      );
      return;
    }

    // Показываем диалоговое окно с подтверждением заказа
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Подтверждение заказа'),
          content: Text('Вы уверены, что хотите оформить заказ на сумму ${getTotalPrice().toStringAsFixed(2)} ₽?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрываем диалог
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                // Очищаем корзину после оформления заказа
                setState(() {
                  for (var comic in cartComics) {
                    comic.isInCart = false;
                  }
                });
                Navigator.of(context).pop(); // Закрываем диалог
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Заказ успешно оформлен!')),
                );
              },
              child: Text('Оформить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartComics = widget.comics.where((comic) => comic.isInCart).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartComics.isEmpty
                ? Center(child: Text('Корзина пуста'))
                : ListView.builder(
                    itemCount: cartComics.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          cartComics[index].imageUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartComics[index].title),
                        subtitle: Text('${cartComics[index].price.toStringAsFixed(2)} ₽'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            _toggleCart(cartComics[index]); // Удаляем из корзины
                          },
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Общая сумма: ${getTotalPrice().toStringAsFixed(2)} ₽',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _placeOrder, // Вызываем функцию оформления заказа
                  child: Text('Оформить заказ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}