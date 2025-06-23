import 'package:flutter/material.dart';

import '../model/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(offset: Offset(-4, -4), color: Colors.white),
            BoxShadow(offset: Offset(4, 4), color: Colors.grey),
          ],
          color: message.isUser ? Colors.green : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
