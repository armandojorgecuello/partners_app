import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/notifications/data/models/app_notification_model.dart';

class NotificationRemoteDataSource {
  final FirebaseFirestore _firestore;

  NotificationRemoteDataSource(this._firestore);

  CollectionReference _itemsFor(String uid) =>
      _firestore.collection('notifications').doc(uid).collection('items');

  Stream<List<AppNotificationModel>> watchNotifications(String uid) {
    return _itemsFor(uid).orderBy('date_time', descending: true).snapshots().map(
      (snap) => snap.docs.map(AppNotificationModel.fromSnapshot).toList(),
    );
  }

  Future<void> markAsRead(String uid, String notificationId) {
    return _itemsFor(uid).doc(notificationId).update({'read': true});
  }

  Future<void> send({
    required String recipientUid,
    required String actorUid,
    required String type,
    String? taskId,
    String? status,
  }) {
    return _itemsFor(recipientUid).add({
      'type': type,
      'actor_uid': actorUid,
      'task_id': taskId,
      'status': status,
      'date_time': Timestamp.now(),
      'read': false,
    });
  }
}
