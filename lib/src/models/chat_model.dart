class ChatModel {
  ChatModel({
    required this.text,
    this.isSender = true,
  });

  final String text;
  final bool isSender;

  ChatModel copyWith({
    String? text,
    bool? isSender,
  }) {
    return ChatModel(
      text: text ?? this.text,
      isSender: isSender ?? this.isSender,
    );
  }
}
