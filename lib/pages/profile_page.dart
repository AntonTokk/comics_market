import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Akito'; // Устанавливаем имя по умолчанию
  final TextEditingController _nameController = TextEditingController(); // Контроллер для TextField

  @override
  void initState() {
    super.initState();
    _nameController.text = name; // Устанавливаем начальное значение в TextField
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20), // Добавляем отступ
            TextField(
              controller: _nameController, // Устанавливаем контроллер
              decoration: InputDecoration(
                labelText: 'Имя',
                border: OutlineInputBorder(), // Добавляем рамку для поля ввода
              ),
              onChanged: (value) {
                setState(() {
                  name = value; // Обновляем имя при изменении текста
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}