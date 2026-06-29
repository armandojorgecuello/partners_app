import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:partners_app/features/tasks/data/models/chat_message_model.dart';
import 'package:partners_app/features/tasks/data/models/task_model.dart';

class TaskRemoteDataSource {
  final FirebaseFirestore _firestore;

  TaskRemoteDataSource(this._firestore);

  CollectionReference get _tasks => _firestore.collection('user_tasks');

  CollectionReference _messages(String taskId) => _tasks.doc(taskId).collection('messages');

  Stream<List<TaskModel>> watchTasks(String uid) {
    final sentByMe = _tasks.where('sender_uid', isEqualTo: uid).snapshots();
    final receivedByMe = _tasks.where('receiver_uid', isEqualTo: uid).snapshots();
    return Rx.combineLatest2(sentByMe, receivedByMe, (QuerySnapshot a, QuerySnapshot b) {
      final tasks = [
        ...a.docs.map((d) => TaskModel.fromJson(d.data() as Map<String, dynamic>)),
        ...b.docs.map((d) => TaskModel.fromJson(d.data() as Map<String, dynamic>)),
      ];
      tasks.sort((x, y) {
        final xDate = x.dateTime?.toDate() ?? DateTime(0);
        final yDate = y.dateTime?.toDate() ?? DateTime(0);
        return yDate.compareTo(xDate);
      });
      return tasks;
    });
  }

  Future<TaskModel?> getTask(String taskId) async {
    final doc = await _tasks.doc(taskId).get();
    if (!doc.exists) return null;
    return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<DocumentReference> createTask(Map<String, dynamic> data) => _tasks.add(data);

  Future<void> updateTask(String taskId, Map<String, dynamic> data) => _tasks.doc(taskId).update(data);

  Future<void> sendMessage(String taskId, Map<String, dynamic> data) => _messages(taskId).add(data);

  Stream<List<ChatMessageModel>> watchMessages(String taskId) {
    return _messages(taskId).orderBy('date_time').snapshots().map(
      (snap) => snap.docs.map((d) => ChatMessageModel.fromJson(d.data() as Map<String, dynamic>)).toList(),
    );
  }

  Future<void> deleteTasksBetween(String uidA, String uidB) async {
    final forward = await _tasks.where('receiver_uid', isEqualTo: uidA).where('sender_uid', isEqualTo: uidB).get();
    for (final doc in forward.docs) {
      await doc.reference.delete();
    }
    final backward = await _tasks.where('receiver_uid', isEqualTo: uidB).where('sender_uid', isEqualTo: uidA).get();
    for (final doc in backward.docs) {
      await doc.reference.delete();
    }
  }
}
