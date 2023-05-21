import 'package:chat_gpt_app/src/commons/typedefs.dart';
import 'package:flutter/material.dart';

class ChatField extends StatefulWidget {
  const ChatField({
    super.key,
    required this.onMessage,
    this.sendEnabled = true,
  });

  final OnMessage onMessage;
  final bool sendEnabled;

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  bool get isButtonEnabled =>
      textController.text.isNotEmpty && widget.sendEnabled;

  void _senderMessage() {
    if (widget.sendEnabled) {
      final message = textController.text;
      if (message.isNotEmpty) {
        widget.onMessage(message);
        textController.text = '';
      }
    }
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        focusNode: focusNode,
        controller: textController,
        onSubmitted: (value) => _senderMessage(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          hintText: 'Pergunte...',
          suffixIcon: AnimatedBuilder(
            animation: textController,
            builder: (context, _) => IconButton(
              onPressed: isButtonEnabled ? _senderMessage : null,
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}
