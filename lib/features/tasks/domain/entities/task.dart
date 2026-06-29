import 'package:partners_app/features/tasks/domain/entities/task_status.dart';

class Task {
  final String uidTask;
  final String title;
  final String senderUid;
  final String receiverUid;
  final DateTime? dateTime;
  final DateTime? deliveryTime;
  final TaskStatus status;
  final String rewardDescription;
  final String rewardImgUrl;
  final String reviewValue;
  final String reviewDescription;

  const Task({
    required this.uidTask,
    required this.title,
    required this.senderUid,
    required this.receiverUid,
    this.dateTime,
    this.deliveryTime,
    required this.status,
    required this.rewardDescription,
    required this.rewardImgUrl,
    required this.reviewValue,
    required this.reviewDescription,
  });

  /// Replaces the `task.senderUid == currentUid ? task.receiverUid : task.senderUid`
  /// pattern duplicated across task_list.dart, new_terms_chat.dart, etc.
  String partnerUid(String currentUid) => senderUid == currentUid ? receiverUid : senderUid;
}
