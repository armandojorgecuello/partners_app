import 'dart:io';

import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';

class CreateTaskParams {
  final File image;
  final String title;
  final String senderUid;
  final String receiverUid;
  final DateTime deliveryTime;
  final String reward;

  const CreateTaskParams({
    required this.image,
    required this.title,
    required this.senderUid,
    required this.receiverUid,
    required this.deliveryTime,
    required this.reward,
  });
}

class CreateTaskUseCase extends UseCase<String, CreateTaskParams> {
  final TaskRepository _repository;
  final SendNotificationUseCase _sendNotification;

  CreateTaskUseCase(this._repository, this._sendNotification);

  @override
  Future<Result<String>> call(CreateTaskParams params) async {
    try {
      final taskId = await _repository.createTask(
        image: params.image,
        title: params.title,
        senderUid: params.senderUid,
        receiverUid: params.receiverUid,
        deliveryTime: params.deliveryTime,
        reward: params.reward,
      );
      await _sendNotification(
        SendNotificationParams(recipientUid: params.receiverUid, actorUid: params.senderUid, type: 'new_task'),
      );
      return Result.ok(taskId);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
