// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/user_model.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:provider/provider.dart';

// final CollectionReference tasksCollection = FirebaseFirestore.instance
//     .collection('user_tasks');

// class TasksListProvider with ChangeNotifier {
//   final uidTask;
//   final String uid;
//   TasksListProvider({this.uid, this.uidTask});
//   DocumentReference doc;
//   // CREAR UNA NUEVA TAREA

//   String _title;
//   String get title => _title;
//   set title(String tit) {
//     _title = tit;
//     notifyListeners();
//   }

//   String _senderUid;
//   String get senderUid => _senderUid;
//   set senderUid(String uidSender) {
//     _senderUid = uidSender;
//     notifyListeners();
//   }

//   String _receiverUid;
//   String get receiverUid => _receiverUid;
//   set receiverUid(String uidReceiver) {
//     _receiverUid = uidReceiver;
//     notifyListeners();
//   }

//   Timestamp _deliveryTime;
//   Timestamp get deliveryTime => _deliveryTime;
//   set deliveryTime(Timestamp delivery) {
//     _deliveryTime = delivery;
//     notifyListeners();
//   }

//   Timestamp _dateTime;
//   Timestamp get dateTime => _dateTime;
//   set dateTime(Timestamp date) {
//     _dateTime = date;
//     notifyListeners();
//   }

//   String _status;
//   String get status => _status;
//   set status(String sta) {
//     _status = sta;
//     notifyListeners();
//   }

//   String _rewardDescription;
//   String get rewardDescription => _rewardDescription;
//   set rewardDescription(String rewardesc) {
//     _rewardDescription = rewardesc;
//     notifyListeners();
//   }

//   String _rewardImgurl;
//   String get rewardImgUrl => _rewardImgurl;
//   set rewardImgUrl(String img) {
//     _rewardImgurl = img;
//     notifyListeners();
//   }

//   String _idTask;
//   String get idTask => _idTask;
//   set idTask(taskID) {
//     _idTask = taskID;
//     notifyListeners();
//   }

//   String _firstFilter;
//   String get firstFilter => _firstFilter;
//   set firstFilter(String filterf) {
//     _firstFilter = filterf;
//     notifyListeners();
//   }

//   DocumentSnapshot _secondFilter;
//   DocumentSnapshot get secondFilter => _secondFilter;
//   set secondFilter(DocumentSnapshot filterS) {
//     _secondFilter = filterS;
//     notifyListeners();
//   }

//   Future createNewTask(
//     File image,
//     String title,
//     String senderUid,
//     String receiverUid,
//     DateTime deliveryTime,
//     String reward,
//   ) async {
//     DocumentReference docRef = await tasksCollection.add({
//       "title": title,
//       "sender_uid": senderUid,
//       "receiver_uid": receiverUid,
//       "delivery_time": deliveryTime,
//       "date_time": DateTime.now(),
//       'status': 'not_started',
//       'reward_description': reward,
//       'reward_img_url': '',
//       'review_value': "",
//       "review_description!": "",
//       "uid_task": "",
//     });
//     await tasksCollection.doc(docRef.docID).updateData({
//       "uid_task": docRef.docID,
//     });
//     print(docRef.docID);
//     doc = docRef;
//     final StorageReference storageReference = FirebaseStorage()
//         .ref()
//         .child('tasks_rewards')
//         .child('/${doc.docID}')
//         .child('${doc.docID}.jpg');
//     final StorageUploadTask uploadTask = storageReference.putFile(image);
//     StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//     String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
//     await tasksCollection.doc('${doc.docID}').updateData({
//       'reward_img_url': imgUrl,
//     });
//   }

//   Future updateRewardImage(String taskUid, File imageReward) async {
//     final StorageReference storageReference = FirebaseStorage()
//         .ref()
//         .child('tasks_rewards')
//         .child('/$taskUid')
//         .child('$taskUid.jpg');
//     final StorageUploadTask uploadTask = storageReference.putFile(imageReward);
//     StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//     String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
//     await tasksCollection.doc(taskUid).updateData({'reward_img_url': imgUrl});
//   }

//   Future updateTask(
//     String imgUrl,
//     String title,
//     String taskUid,
//     DateTime deliveryTime,
//     String reward,
//   ) async {
//     FirebaseFirestore.instance
//         .collection('user_tasks')
//         .doc(taskUid)
//         .updateData({
//           "title": title,
//           "delivery_time": deliveryTime,
//           'status': 'pending_receiver',
//           'reward_description': reward,
//           'reward_img_url': imgUrl,
//         });
//   }

//   Future updateStatus(String taskUid, String status) async {
//     FirebaseFirestore.instance.collection('user_tasks').doc(taskUid).updateData(
//       {'status': status},
//     );
//   }

//   Future reviewTask(String taskUid, String status, String rewardDesc) async {
//     FirebaseFirestore.instance
//         .collection('user_tasks')
//         .doc(taskUid)
//         .updateData({
//           'review_value': status,
//           'review_description!': rewardDesc,
//           'review_date': DateTime.now(),
//         });
//   }

//   // OBTENER TODAS LAS TAREAS
//   Stream<List<TaskData>> getTasks(String user) async* {
//     List<TaskData> taskList = List();
//     QuerySnapshot sendByMe =
//         await FirebaseFirestore.instance
//             .collection('user_tasks')
//             .where('sender_uid', isEqualTo: user)
//             .get();
//     if (sendByMe.docs.isNotEmpty) {
//       for (var sendbyMeData in sendByMe.docs) {
//         TaskData temporalTaskSendByMe = TaskData.fromJson(sendbyMeData.data);
//         taskList.add(temporalTaskSendByMe);
//       }
//     }
//     QuerySnapshot receivedForMe =
//         await FirebaseFirestore.instance
//             .collection('user_tasks')
//             .where('receiver_uid', isEqualTo: user)
//             .get();
//     if (receivedForMe.docs.isNotEmpty) {
//       for (var receivedForMeData in receivedForMe.docs) {
//         TaskData temporalTaskReceiveByMe = TaskData.fromJson(
//           receivedForMeData.data,
//         );
//         taskList.add(temporalTaskReceiveByMe);
//       }
//     }
//     yield taskList;
//   }

//   List<TaskData> listTaskData(
//     List<TaskData> taskSnapshot,
//     String firstFilter,
//     String secondFilter,
//     context,
//   ) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     List<TaskData> listTask = List();
//     for (TaskData task in taskSnapshot) {
//       if (firstFilter == localizations.t('home_page.allTask')) {
//         if (secondFilter == task.senderUid ||
//             secondFilter == task.receiverUid) {
//           listTask.add(task);
//         }
//       }
//       return listTask;
//     }
//   }

//   Stream<QuerySnapshot> getTaskWhereReceiver(String user) {
//     return FirebaseFirestore.instance
//         .collection('user_tasks')
//         .where('receiver_uid', isEqualTo: user)
//         .orderBy('date_time', descending: true)
//         .snapshots();
//   }

//   // obtener tarea sleccionada
//   Stream<DocumentSnapshot> get getSelectedTask {
//     return FirebaseFirestore.instance
//         .collection('user_tasks')
//         .doc(uidTask)
//         .snapshots();
//   }

//   Future sendMessage(
//     String senderUid,
//     String message,
//     String receiverUid,
//     String taskId,
//   ) async {
//     FirebaseFirestore.instance
//         .collection('task_chatrooms')
//         .doc(taskId)
//         .collection(taskId)
//         .doc()
//         .set({
//           'uid_receiver': receiverUid,
//           'uid_sender': senderUid,
//           'message': message,
//           'date_time': DateTime.now(),
//           'status': 'not_seen',
//         });
//   }

//   Future actualWindowandIdTask(
//     String uidUser,
//     String actualWidonw,
//     String idTask,
//   ) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(uidUser)
//         .collection(uidUser)
//         .doc(uidUser)
//         .updateData({'windows_type': actualWidonw, 'window_id': idTask});
//   }

//   //list filter
//   List<TaskData> filterList(
//     List<TaskData> taskSnapshot,
//     context,
//     String userUid,
//     Function function,
//     bool filterVisibility,
//     String search,
//   ) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     String firstFilter = Provider.of<TasksListProvider>(context).firstFilter;
//     DocumentSnapshot secondFilter =
//         Provider.of<TasksListProvider>(context).secondFilter;
//     List<TaskData> finalList = List();
//     for (TaskData task in taskSnapshot) {
//       if (filterVisibility == true) {
//         if (firstFilter == localizations.t('home_page.allTask')) {
//           if (secondFilter.docID == task.senderUid ||
//               secondFilter.docID == task.receiverUid) {
//             finalList.add(task);
//           }
//         } else if (firstFilter ==
//             localizations.t('home_page.openNegociation')) {
//           if (task.status == "open" ||
//               task.status == "paid_upfront" ||
//               task.status == "rejected" ||
//               task.status == "pending_receiver") {
//             if (secondFilter.docID == task.senderUid ||
//                 secondFilter.docID == task.receiverUid) {
//               finalList.add(task);
//             }
//           }
//         } else if (firstFilter ==
//             localizations.t('home_page.receiveFromPartner')) {
//           if (secondFilter.docID == task.senderUid) {
//             finalList.add(task);
//           }
//         } else if (firstFilter == localizations.t('home_page.sendByMe')) {
//           if (secondFilter.docID == task.receiverUid) {
//             finalList.add(task);
//           }
//         } else if (firstFilter == localizations.t('home_page.expired')) {
//           if (task.deliveryTime != null) {
//             DateTime baseTime = DateTime.now();
//             Timestamp time = task.deliveryTime;
//             DateTime date = time.toDate();
//             if (date.compareTo(baseTime) < 0) {
//               if (secondFilter.docID == task.senderUid ||
//                   secondFilter.docID == task.receiverUid) {
//                 finalList.add(task);
//               }
//             }
//           }
//         } else if (firstFilter == localizations.t('home_page.endingSoon')) {
//           if (task.deliveryTime != null) {
//             DateTime baseTime = DateTime.now();
//             Timestamp time = task.deliveryTime;
//             DateTime date = time.toDate();
//             if (date.compareTo(baseTime) > 0) {
//               if (secondFilter.docID == task.senderUid ||
//                   secondFilter.docID == task.receiverUid) {
//                 finalList.add(task);
//               }
//             }
//           }
//         } else {
//           Provider.of<TasksListProvider>(
//             context,
//             listen: false,
//           ).firstFilter = localizations.t('home_page.receiveFromPartner');
//           if (userUid == task.receiverUid) {
//             finalList.add(task);
//           }
//         }
//       } else {
//         if (task.title.contains(search)) {
//           finalList.add(task);
//         }
//       }
//     }
//     return finalList;
//   }
// }
