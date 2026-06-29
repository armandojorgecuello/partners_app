import 'package:partners_app/features/notifications/domain/entities/app_notification.dart';

abstract class NotificationRepository {
  Stream<List<AppNotification>> watchNotifications(String uid);

  Future<void> markAsRead(String uid, String notificationId);

  /// Depended on by features/tasks and features/partners (one-directional:
  /// they depend on this domain interface, never the reverse).
  Future<void> send({
    required String recipientUid,
    required String actorUid,
    required String type,
    String? taskId,
    String? status,
  });
}
