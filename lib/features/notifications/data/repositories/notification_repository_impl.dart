import 'package:partners_app/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:partners_app/features/notifications/domain/entities/app_notification.dart';
import 'package:partners_app/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remote;

  NotificationRepositoryImpl(this._remote);

  @override
  Stream<List<AppNotification>> watchNotifications(String uid) {
    return _remote.watchNotifications(uid).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<void> markAsRead(String uid, String notificationId) => _remote.markAsRead(uid, notificationId);

  @override
  Future<void> send({
    required String recipientUid,
    required String actorUid,
    required String type,
    String? taskId,
    String? status,
  }) {
    return _remote.send(recipientUid: recipientUid, actorUid: actorUid, type: type, taskId: taskId, status: status);
  }
}
