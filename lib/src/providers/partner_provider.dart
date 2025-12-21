// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honey_iou_updated/src/models/partner_model.dart';

// final CollectionReference partnerRequestCollection = FirebaseFirestore.instance
//     .collection('partner_requests');
// final CollectionReference partnerAcceptedCollection = FirebaseFirestore.instance
//     .collection('partners_accepted');

// class PartnerProvider with ChangeNotifier {
//   final String? uid;
//   final String? receiverUid;

//   PartnerProvider({this.uid, this.receiverUid});
//   // Crear solicitud de partner
//   Future createPartnerRequest(
//     String receiverUid,
//     String senderUid,
//     DateTime datetime,
//   ) async {
//     return await partnerRequestCollection
//         .doc(receiverUid)
//         .collection(receiverUid)
//         .doc(senderUid)
//         .set({
//           "sender_uid": senderUid,
//           "receiver_uid": receiverUid,
//           "date_time": DateTime.now(),
//         });
//   }

//   // Obtener Lista de Solicitud a Partners
//   Stream get partnerRequestList {
//     return FirebaseFirestore.instance
//         .collection('partner_requests')
//         .doc(uid)
//         .collection(uid!)
//         .snapshots();
//   }

//   //Obtener Datos del aspirante a Partner
//   Future partnerData(String partnerUID) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(partnerUID)
//         .collection(partnerUID)
//         .doc(partnerUID)
//         .get();
//   }

//   // Crear Lista de Partner Aceptados
//   Future<DocumentReference> acceptPartnerRequestReceiver(
//     String preferences,
//     String uid,
//     String partnerUid,
//     String name,
//     String photoUrl,
//   ) async {
//     var updatePartner = partnerAcceptedCollection.doc(uid)
//       ..collection(uid).doc(partnerUid).set({
//         "uid": uid,
//         "partner_uid": partnerUid,
//         "date_time": DateTime.now(),
//         'name': name,
//         'photo_url': photoUrl,
//         'preferences': preferences,
//       });
//     return updatePartner;
//   }

//   Future acceptPartnerRequestSender(
//     String preferences,
//     String uid,
//     String partnerUid,
//     String name,
//     String photoUrl,
//   ) async {
//     var updatePartner = partnerAcceptedCollection.doc(uid)
//       ..collection(uid).doc(partnerUid).set({
//         "uid": uid,
//         "partner_uid": partnerUid,
//         "date_time": DateTime.now(),
//         'name': name,
//         'photo_url': photoUrl,
//         'preferences': preferences,
//       });
//     return updatePartner;
//   }

//   //Eliminar Solucitd de Partner
//   Future deletePartnerRequest(String uid, String partnerUid) async {
//     await partnerRequestCollection
//         .doc(uid)
//         .collection(uid)
//         .doc(partnerUid)
//         .delete();
//   }

//   Stream<List<PartnerList>> test() {
//     Stream<QuerySnapshot> stream =
//         FirebaseFirestore.instance
//             .collection('partners_accepted')
//             .doc(uid)
//             .collection(uid!)
//             .snapshots();
//     return stream.map(
//       (dataMap) =>
//           dataMap.docs
//               .map(
//                 (partnerData) => PartnerList(
//                   (partnerData.data() as Map<String, dynamic>)['partner_uid'],
//                   (partnerData.data() as Map<String, dynamic>)['uid'],
//                 ),
//               )
//               .toList(),
//     );
//   }

//   Stream<PartnerListData> partnerAcceptedData(uidRequest) {
//     Stream<DocumentSnapshot> stream1 =
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(uidRequest)
//             .collection(uidRequest)
//             .doc(uidRequest)
//             .snapshots();
//     return stream1.map(
//       (partnerData) => PartnerListData(
//         (partnerData.data() as Map<String, dynamic>)['name'],
//         (partnerData.data() as Map<String, dynamic>)['photo_url'],
//         (partnerData.data() as Map<String, dynamic>)['cel_number'],
//         (partnerData.data() as Map<String, dynamic>)['preferences'],
//       ),
//     );
//   }

//   Stream get partnerAcceptedList {
//     return FirebaseFirestore.instance
//         .collection('partners_accepted')
//         .doc(uid)
//         .collection(uid!)
//         .snapshots();
//   }

//   //Eliminar Partner Aceptado
//   Future deletePartnerAccepted(String uid, String partnerUid) async {
//     await partnerAcceptedCollection
//         .doc(uid)
//         .collection(uid)
//         .doc(partnerUid)
//         .delete();
//     await partnerAcceptedCollection
//         .doc(partnerUid)
//         .collection(partnerUid)
//         .doc(uid)
//         .delete();
//   }

//   //Eliminar Tareas de un Partner

//   Future deleteTasksPartner(String uid, String partnerUid) async {
//     var deleteTasks =
//         await FirebaseFirestore.instance
//             .collection('user_tasks')
//             .where('receiver_uid', isEqualTo: uid)
//             .where('sender_uid', isEqualTo: partnerUid)
//             .get();

//     for (var document in deleteTasks.docs) {
//       document.reference.delete();
//     }

//     var deleteTasks1 =
//         await FirebaseFirestore.instance
//             .collection('user_tasks')
//             .where('receiver_uid', isEqualTo: partnerUid)
//             .where('sender_uid', isEqualTo: uid)
//             .get();

//     for (var document in deleteTasks1.docs) {
//       document.reference.delete();
//     }
//   }
// }
