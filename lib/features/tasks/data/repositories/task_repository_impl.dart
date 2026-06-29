import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:partners_app/features/tasks/data/datasources/task_storage_data_source.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remote;
  final TaskStorageDataSource _storage;

  TaskRepositoryImpl(this._remote, this._storage);

  @override
  Stream<List<Task>> watchTasks(String uid) {
    return _remote.watchTasks(uid).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Task?> getTask(String taskId) async {
    final model = await _remote.getTask(taskId);
    return model?.toEntity();
  }

  @override
  Future<String> createTask({
    required File image,
    required String title,
    required String senderUid,
    required String receiverUid,
    required DateTime deliveryTime,
    required String reward,
  }) async {
    final docRef = await _remote.createTask({
      'title': title,
      'sender_uid': senderUid,
      'receiver_uid': receiverUid,
      'delivery_time': Timestamp.fromDate(deliveryTime),
      'date_time': Timestamp.now(),
      'status': TaskStatus.notStarted.raw,
      'reward_description': reward,
      'reward_img_url': '',
      'review_value': '',
      'review_description': '',
      'uid_task': '',
    });
    await _remote.updateTask(docRef.id, {'uid_task': docRef.id});

    final imgUrl = await _storage.uploadRewardImage(docRef.id, image);
    await _remote.updateTask(docRef.id, {'reward_img_url': imgUrl});
    return docRef.id;
  }

  @override
  Future<void> updateStatus(String taskId, TaskStatus status) {
    return _remote.updateTask(taskId, {'status': status.raw});
  }

  @override
  Future<void> submitReview(String taskId, String reviewValue, String reviewDescription) {
    return _remote.updateTask(taskId, {
      'review_value': reviewValue,
      'review_description': reviewDescription,
    });
  }

  @override
  Future<void> updateRewardImage(String taskId, File image) async {
    final imgUrl = await _storage.uploadRewardImage(taskId, image);
    await _remote.updateTask(taskId, {'reward_img_url': imgUrl});
  }

  @override
  Future<void> deleteTasksBetween(String uidA, String uidB) => _remote.deleteTasksBetween(uidA, uidB);
}
