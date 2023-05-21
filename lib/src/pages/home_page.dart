import 'package:chat_gpt_app/src/models/chat_model.dart';
import 'package:chat_gpt_app/src/widgets/chat_bubble.dart';
import 'package:chat_gpt_app/src/widgets/chat_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mockChatModels = [
    ChatModel(
      text: 'Hi, I am GPT-3, nice to meet you!',
      isSender: false,
    ),
    ChatModel(text: 'What do you do?', isSender: true),
    ChatModel(
      text: 'I am an artificial intelligence language model',
      isSender: false,
    ),
    ChatModel(text: 'Oh, cool. How are you?', isSender: true),
    ChatModel(
      text: 'I am fine, thanks. What about you?',
      isSender: false,
    ),
    ChatModel(text: 'I am fine too, thanks.', isSender: true),
  ];

  bool isLoading = false;

  void sendMessage(String message) {
    setState(() {
      isLoading = true;
      mockChatModels.insert(
        0,
        ChatModel(text: message, isSender: true),
      );
    });
    Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Chat GPT App',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            child: Icon(
              Icons.rocket,
              size: 300,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
          ),
          ListView.builder(
            reverse: true,
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: mockChatModels.length,
            itemBuilder: (context, index) {
              return ChatBubble(model: mockChatModels[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatField(
              sendEnabled: !isLoading,
              onMessage: sendMessage,
            ),
          ),
          if (isLoading)
            const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
