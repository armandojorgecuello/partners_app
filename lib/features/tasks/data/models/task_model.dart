import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';

class TaskModel {
  final String uidTask;
  final String title;
  final String senderUid;
  final String receiverUid;
  final Timestamp? dateTime;
  final Timestamp? deliveryTime;
  final String status;
  final String rewardDescription;
  final String rewardImgUrl;
  final String reviewValue;
  final String reviewDescription;

  const TaskModel({
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

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    uidTask: json['uid_task'] ?? '',
    title: json['title'] ?? '',
    senderUid: json['sender_uid'] ?? '',
    receiverUid: json['receiver_uid'] ?? '',
    dateTime: json['date_time'],
    deliveryTime: json['delivery_time'],
    status: json['status'] ?? 'not_started',
    rewardDescription: json['reward_description'] ?? '',
    rewardImgUrl: json['reward_img_url'] ?? '',
    reviewValue: json['review_value'] ?? '',
    reviewDescription: json['review_description'] ?? '',
  );

  Task toEntity() => Task(
    uidTask: uidTask,
    title: title,
    senderUid: senderUid,
    receiverUid: receiverUid,
    dateTime: dateTime?.toDate(),
    deliveryTime: deliveryTime?.toDate(),
    status: TaskStatusMapping.fromRaw(status),
    rewardDescription: rewardDescription,
    rewardImgUrl: rewardImgUrl,
    reviewValue: reviewValue,
    reviewDescription: reviewDescription,
  );
}
