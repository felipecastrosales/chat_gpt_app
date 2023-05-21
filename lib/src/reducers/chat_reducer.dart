import 'dart:async';

import 'package:chat_gpt_app/src/atoms/chat_atom.dart';
import 'package:chat_gpt_app/src/environments/env.dart';
import 'package:chat_gpt_app/src/models/chat_model.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ChatReducer extends RxReducer {
  ChatReducer() {
    on(() => [sendMessageAction.value], sendMessage);
  }

  void sendMessage() async {
    final message = sendMessageAction.value;
    final chatGPT = ChatGpt(apiKey: Env.chatGPTKey);

    if (message.isEmpty) {
      return;
    }

    chatLoading.value = true;
    chatsState.value.insert(0, ChatModel(text: message, isSender: true));
    chatsState.value.insert(0, ChatModel(text: '...', isSender: false));
    chatsState();

    final request = CompletionRequest(
      stream: true,
      maxTokens: 4000,
      model: ChatGptModel.gpt35Turbo,
      messages: [
        Message(role: Role.user.name, content: message),
      ],
    );

    final stream = await chatGPT.createChatCompletionStream(request);

    if (stream == null) {
      chatLoading.value = false;
      return;
    }

    final completer = Completer();
    final buffer = StringBuffer();

    final sup = stream.listen((event) {
      if (event.streamMessageEnd) {
        chatLoading.value = false;
        completer.complete();
      }

      final buffedMessage = event.choices?.first.delta?.content ?? '';
      buffer.write(buffedMessage);
      chatsState.value[0] = chatsState.value[0].copyWith(
        text: buffer.toString(),
      );
      chatsState();
    });

    await completer.future;
    await sup.cancel();
  }
}
