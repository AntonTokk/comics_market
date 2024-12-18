import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final Timestamp createdAt;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.createdAt,
  });
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start, 
        children: [
          if (!message.isMe) 
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(message.isMe ? 'Я' : 'П'),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: message.isMe ? Colors.blue : Colors.grey[300], // Цвет сообщения
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isMe ? Colors.white : Colors.black, // Цвет текста
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message.isMe ? 'Я' : 'Продавец',
                  style: Theme.of(context).textTheme.bodySmall, // Стиль автора сообщения
                ),
              ],
            ),
          ),
          if (message.isMe) 
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                child: Text('Я'),
              ),
            ),
        ],
      ),
    );
  }
}