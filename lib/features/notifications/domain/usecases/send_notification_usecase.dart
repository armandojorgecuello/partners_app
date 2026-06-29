import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/notifications/domain/repositories/notification_repository.dart';

class SendNotificationParams {
  final String recipientUid;
  final String actorUid;
  final String type;
  final String? taskId;
  final String? status;

  const SendNotificationParams({
    required this.recipientUid,
    required this.actorUid,
    required this.type,
    this.taskId,
    this.status,
  });

  /// Value equality so callers (and tests) can compare/verify params without
  /// caring about instance identity.
  @override
  bool operator ==(Object other) =>
      other is SendNotificationParams &&
      other.recipientUid == recipientUid &&
      other.actorUid == actorUid &&
      other.type == type &&
      other.taskId == taskId &&
      other.status == status;

  @override
  int get hashCode => Object.hash(recipientUid, actorUid, type, taskId, status);
}

class SendNotificationUseCase extends UseCase<void, SendNotificationParams> {
  final NotificationRepository _repository;

  SendNotificationUseCase(this._repository);

  @override
  Future<Result<void>> call(SendNotificationParams params) async {
    try {
      await _repository.send(
        recipientUid: params.recipientUid,
        actorUid: params.actorUid,
        type: params.type,
        taskId: params.taskId,
        status: params.status,
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
