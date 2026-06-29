import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class TaskStorageDataSource {
  final FirebaseStorage _storage;

  TaskStorageDataSource(this._storage);

  Future<String> uploadRewardImage(String taskId, File image) async {
    final ref = _storage.ref().child('tasks_rewards').child(taskId).child('$taskId.jpg');
    final snapshot = await ref.putFile(image);
    return snapshot.ref.getDownloadURL();
  }
}
