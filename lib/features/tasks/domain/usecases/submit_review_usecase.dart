import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';

class SubmitReviewParams {
  final String taskId;
  final String reviewValue;
  final String reviewDescription;
  final String recipientUid;
  final String actorUid;

  const SubmitReviewParams({
    required this.taskId,
    required this.reviewValue,
    required this.reviewDescription,
    required this.recipientUid,
    required this.actorUid,
  });
}

class SubmitReviewUseCase extends UseCase<void, SubmitReviewParams> {
  final TaskRepository _repository;
  final SendNotificationUseCase _sendNotification;

  SubmitReviewUseCase(this._repository, this._sendNotification);

  @override
  Future<Result<void>> call(SubmitReviewParams params) async {
    try {
      await _repository.updateStatus(params.taskId, TaskStatus.reviewed);
      await _repository.submitReview(params.taskId, params.reviewValue, params.reviewDescription);
      await _sendNotification(
        SendNotificationParams(
          recipientUid: params.recipientUid,
          actorUid: params.actorUid,
          type: 'task_status',
          taskId: params.taskId,
          status: TaskStatus.reviewed.raw,
        ),
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
