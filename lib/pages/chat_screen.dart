import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat_message.dart'; // Импортируйте файл chat_message.dart

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = _auth.currentUser!.uid; // Получаем ID текущего пользователя
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    _firestore.collection('messages').add({
      'text': text,
      'createdAt': Timestamp.now(),
      'userId': _userId,
    });

    _controller.clear();

    // Автоматический ответ продавца
    _sendAutoReply(text);
  }

  void _sendAutoReply(String userMessage) {
    String autoReply = '';

    // Логика автоматического ответа
    if (userMessage.toLowerCase().contains('привет')) {
      autoReply = 'Привет! Чем могу помочь?';
    } else if (userMessage.toLowerCase().contains('заказ')) {
      autoReply = 'Спасибо за заказ! Мы скоро свяжемся с вами.';
    } else if (userMessage.toLowerCase().contains('проблема')) {
      autoReply = 'Ой, что случилось? Расскажите подробнее.';
    } else {
      autoReply = 'Я вас не совсем понял. Пожалуйста, уточните вопрос.';
    }

    // Отправляем автоматический ответ
    _firestore.collection('messages').add({
      'text': autoReply,
      'createdAt': Timestamp.now(),
      'userId': 'seller', // Уникальный ID продавца
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Чат с продавцом'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message['userId'] == _userId;
                    return ChatMessageWidget(
                      message: ChatMessage(
                        text: message['text'],
                        isMe: isMe,
                        createdAt: message['createdAt'],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: _sendMessage,
                decoration: InputDecoration.collapsed(hintText: 'Отправить сообщение'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _sendMessage(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}