// import 'package:cloud_firestore/cloud_firestore.dart';

// CollectionReference userNoti = FirebaseFirestore.instance.collection(
//   'users_notifications',
// );

// class ShowNotificationsProvider {
//   final String uid;

//   ShowNotificationsProvider(this.uid);

//   Stream<QuerySnapshot> notiData() {
//     return userNoti
//         .where('receiver_uid', isEqualTo: uid)
//         .orderBy("datetime")
//         .snapshots();

//     // Stream stream1 =  userNoti.where('sender_uid', isEqualTo: '$uid').snapshots();
//     // return StreamZip<QuerySnapshot>([stream,stream1]).asBroadcastStream();
//   }

//   Stream userNotiInfo(String userUid) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(userUid)
//         .collection(userUid)
//         .doc(userUid)
//         .snapshots();
//   }

//   updateNotificationsCount(userUid, int notificationsLenth) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(userUid)
//         .collection(userUid)
//         .doc(userUid)
//         .updateData({'notification_count': notificationsLenth});
//   }
// }
