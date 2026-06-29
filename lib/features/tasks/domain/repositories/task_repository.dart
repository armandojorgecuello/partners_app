import 'dart:io';

import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';

abstract class TaskRepository {
  Stream<List<Task>> watchTasks(String uid);

  Future<Task?> getTask(String taskId);

  Future<String> createTask({
    required File image,
    required String title,
    required String senderUid,
    required String receiverUid,
    required DateTime deliveryTime,
    required String reward,
  });

  Future<void> updateStatus(String taskId, TaskStatus status);

  Future<void> submitReview(String taskId, String reviewValue, String reviewDescription);

  Future<void> updateRewardImage(String taskId, File image);

  /// Used by features/partners when a partner link is removed, to cascade
  /// delete every task shared between the two users.
  Future<void> deleteTasksBetween(String uidA, String uidB);
}
