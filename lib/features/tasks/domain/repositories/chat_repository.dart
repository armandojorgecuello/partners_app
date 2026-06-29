import 'package:partners_app/features/tasks/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> watchMessages(String taskId);

  Future<void> sendMessage({
    required String taskId,
    required String senderUid,
    required String receiverUid,
    required String message,
  });
}
