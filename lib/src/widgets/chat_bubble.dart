import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_gpt_app/src/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.model,
  });

  final ChatModel model;

  @override
  Widget build(BuildContext context) {
    if (model.isSender) {
      return BubbleSpecialThree(
        tail: false,
        text: model.text,
        isSender: model.isSender,
        color: const Color(0xFF1B97F3),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    }

    return BubbleSpecialThree(
      tail: false,
      text: model.text,
      isSender: model.isSender,
      color: const Color(0xFFE8E8EE),
    );
  }
}
