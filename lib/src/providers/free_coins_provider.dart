// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class FreeCoinsProvider with ChangeNotifier {
//   final dbRef = FirebaseFirestore.instance;
//   Stream getLimitVideoCoins() {
//     return dbRef.collection("free_coins_limit").doc("values").snapshots();
//     // var  limitvideoCoins;
//     // limit.forEach((element) {
//     //   limitvideoCoins = FreeCoinsLimit.fromJson(element.data);
//     // });
//     // return limitvideoCoins;
//   }

//   getCoins(String userUid) {
//     return dbRef
//         .collection("free_coins_user_history")
//         .doc(userUid)
//         .collection("coins")
//         .snapshots();
//   }

//   getLastCoins(String userUid) {
//     return dbRef
//         .collection("free_coins_user_history")
//         .doc(userUid)
//         .collection("coins")
//         .orderBy("datetime", descending: true)
//         .limit(1)
//         .snapshots();
//   }

//   freeCoinsuserHistory(String uidUser) {
//     dbRef
//         .collection("free_coins_user_history")
//         .doc(uidUser)
//         .collection("coins")
//         .doc()
//         .set({"datetime": DateTime.now().toUtc()});
//     dbRef
//         .collection("users")
//         .doc(uidUser)
//         .collection(uidUser)
//         .doc(uidUser)
//         .updateData({"last_free_coin": DateTime.now().toUtc()});
//   }

//   updateLastFreeCoin(String uidUser) {
//     dbRef
//         .collection("users")
//         .doc(uidUser)
//         .collection(uidUser)
//         .doc(uidUser)
//         .updateData({"last_free_coin": DateTime.now().toUtc()});
//   }

//   consumeCredits(String uidUser) {
//     dbRef
//         .collection("free_coins_user_history")
//         .doc(uidUser)
//         .collection("coins")
//         .limit(1)
//         .get()
//         .then((value) {
//           value.docs.forEach((element) {
//             dbRef
//                 .collection("free_coins_user_history")
//                 .doc(uidUser)
//                 .collection("coins")
//                 .doc("${element.docID}")
//                 .delete();
//           });
//         });
//   }
// }
