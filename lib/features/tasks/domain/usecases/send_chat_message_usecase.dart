import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/tasks/domain/repositories/chat_repository.dart';

class SendChatMessageParams {
  final String taskId;
  final String senderUid;
  final String receiverUid;
  final String message;

  const SendChatMessageParams({
    required this.taskId,
    required this.senderUid,
    required this.receiverUid,
    required this.message,
  });
}

class SendChatMessageUseCase extends UseCase<void, SendChatMessageParams> {
  final ChatRepository _repository;
  final SendNotificationUseCase _sendNotification;

  SendChatMessageUseCase(this._repository, this._sendNotification);

  @override
  Future<Result<void>> call(SendChatMessageParams params) async {
    try {
      await _repository.sendMessage(
        taskId: params.taskId,
        senderUid: params.senderUid,
        receiverUid: params.receiverUid,
        message: params.message,
      );
      await _sendNotification(
        SendNotificationParams(
          recipientUid: params.receiverUid,
          actorUid: params.senderUid,
          type: 'chat_message',
          taskId: params.taskId,
        ),
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
