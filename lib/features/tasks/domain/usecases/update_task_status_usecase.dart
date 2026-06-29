import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';

class UpdateTaskStatusParams {
  final String taskId;
  final TaskStatus status;
  final String recipientUid;
  final String actorUid;

  const UpdateTaskStatusParams({
    required this.taskId,
    required this.status,
    required this.recipientUid,
    required this.actorUid,
  });
}

/// Covers every status transition that used to be a one-off
/// `TasksListProvider.updateStatus(...)` + `ShowNotificationsProvider.notify(...)`
/// pair duplicated across new_terms_chat.dart (accept/reject),
/// start_negociation_task.dart (open) and pay_your_partner.dart (paid_upfront).
class UpdateTaskStatusUseCase extends UseCase<void, UpdateTaskStatusParams> {
  final TaskRepository _repository;
  final SendNotificationUseCase _sendNotification;

  UpdateTaskStatusUseCase(this._repository, this._sendNotification);

  @override
  Future<Result<void>> call(UpdateTaskStatusParams params) async {
    try {
      await _repository.updateStatus(params.taskId, params.status);
      await _sendNotification(
        SendNotificationParams(
          recipientUid: params.recipientUid,
          actorUid: params.actorUid,
          type: 'task_status',
          taskId: params.taskId,
          status: params.status.raw,
        ),
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
