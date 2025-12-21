// import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String task_name;
  String send_uid;
  String receiver_uid;
  DateTime dateTime;
  String delivery_time;

  Task(
    this.task_name,
    this.send_uid,
    this.receiver_uid,
    this.dateTime,
    this.delivery_time,
  );
}

// class UserInfo {
//   static DocumentSnapshot? documentSnapshot;
// }

// class SingleModalsPartner {
//   static DocumentSnapshot? documentSnapshot;
// }

// class DocTaskSelected {
//   static DocumentSnapshot? documentSnapshot;
// }

// class SenderTask {
//   static QuerySnapshot? documentSnapshot;
// }

// class ReceiverTask {
//   static QuerySnapshot? documentSnapshot;
// }

// // class PhoneUser{
// //   static User user;
// // }
