import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/notifications/domain/entities/app_notification.dart';

class AppNotificationModel {
  final String id;
  final String type;
  final String actorUid;
  final String? taskId;
  final String? status;
  final Timestamp? dateTime;
  final bool read;

  const AppNotificationModel({
    required this.id,
    required this.type,
    required this.actorUid,
    this.taskId,
    this.status,
    this.dateTime,
    this.read = false,
  });

  factory AppNotificationModel.fromSnapshot(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>? ?? {};
    return AppNotificationModel(
      id: doc.id,
      type: json['type'] ?? '',
      actorUid: json['actor_uid'] ?? '',
      taskId: json['task_id'],
      status: json['status'],
      dateTime: json['date_time'],
      read: json['read'] ?? false,
    );
  }

  AppNotification toEntity() => AppNotification(
    id: id,
    type: type,
    actorUid: actorUid,
    taskId: taskId,
    status: status,
    dateTime: dateTime?.toDate(),
    read: read,
  );
}
