import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'CHAT_GPT_KEY', obfuscate: true)
  static String chatGPTKey = _Env.chatGPTKey;
}
