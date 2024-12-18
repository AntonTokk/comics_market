import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'pages/auth_screen.dart'; // Импорт экрана авторизации
import 'pages/home_page.dart'; // Импорт главной страницы

void main() async {
  // Убедитесь, что Flutter связывается с платформой
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Firebase
  await Firebase.initializeApp();

  // Запуск приложения
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин комиксов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthStateListener(), // Используем отдельный виджет для прослушивания состояния аутентификации
    );
  }
}

class AuthStateListener extends StatelessWidget {
  const AuthStateListener({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Показываем индикатор загрузки, пока проверяем состояние аутентификации
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Если пользователь авторизован, переходим на главную страницу
        if (snapshot.hasData) {
          return const HomePage();
        }

        // Если пользователь не авторизован, показываем экран авторизации
        return const AuthScreen();
      },
    );
  }
}