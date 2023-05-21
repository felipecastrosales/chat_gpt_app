import 'package:chat_gpt_app/src/atoms/chat_atom.dart';
import 'package:chat_gpt_app/src/widgets/chat_bubble.dart';
import 'package:chat_gpt_app/src/widgets/chat_field.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void sendMessage(String message) {
    sendMessageAction.value = message;
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [chatsState.value, chatLoading.value]);
    final chatModels = chatsState.value;
    final isLoading = chatLoading.value;

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              sendMessageAction.value = '';
              chatLoading.value = false;
              chatsState.value = [];
            },
          ),
        ],
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
            itemCount: chatModels.length,
            itemBuilder: (context, index) {
              return ChatBubble(model: chatModels[index]);
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
