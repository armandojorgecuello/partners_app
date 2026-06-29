import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:partners_app/features/tasks/domain/entities/chat_message.dart';
import 'package:partners_app/features/tasks/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final TaskRemoteDataSource _remote;

  ChatRepositoryImpl(this._remote);

  @override
  Stream<List<ChatMessage>> watchMessages(String taskId) {
    return _remote.watchMessages(taskId).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<void> sendMessage({
    required String taskId,
    required String senderUid,
    required String receiverUid,
    required String message,
  }) {
    return _remote.sendMessage(taskId, {
      'message': message,
      'uid_sender': senderUid,
      'uid_receiver': receiverUid,
      'date_time': Timestamp.now(),
    });
  }
}
