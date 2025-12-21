// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SupportProvider with ChangeNotifier {
//   final String userUid;
//   // final String taskUid;

//   SupportProvider(this.userUid);
//   static String docReference;

//   Future createSupportMessage(String subject, String description) async {
//     DocumentReference docRef = await FirebaseFirestore.instance
//         .collection('support_message')
//         .doc(userUid)
//         .collection(userUid)
//         .add({
//           'subject': subject,
//           'description': description,
//           'date_time': DateTime.now(),
//           'sender_uid': userUid,
//           // 'task_id'     : taskUid,
//           'ticket_id': '',
//           'status': 'Active',
//         });
//     docReference = '${docRef.docID}';
//     FirebaseFirestore.instance
//         .collection('support_message')
//         .doc(userUid)
//         .collection(userUid)
//         .doc(docRef.docID)
//         .updateData({'ticket_id': docRef.docID});
//   }

//   Stream<DocumentSnapshot> get getSupportTicketNumber {
//     return FirebaseFirestore.instance
//         .collection('support_message')
//         .doc(userUid)
//         .collection(userUid)
//         .doc(docReference)
//         .snapshots();
//   }
// }
