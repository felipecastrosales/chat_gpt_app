import 'package:chat_gpt_app/src/models/chat_model.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// atoms
final chatsState = RxNotifier<List<ChatModel>>([]);
final chatLoading = RxNotifier(false);

/// action
final sendMessageAction = RxNotifier<String>('');
