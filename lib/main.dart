import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'src/pages/home_page.dart';

void main() {
  runApp(const RxRoot(child: ChatApp()));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat GPT App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
