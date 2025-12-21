// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:honeyiou/src/models/gallerie_image_model.dart';
// import 'package:honeyiou/src/models/profile_model.dart';

// class UsuarioProvider {
//   final String uid;
//   final String lang;

//   UsuarioProvider({this.uid, this.lang});

//   final CollaectionReference userCollection = FirebaseFirestore.instance
//       .collection('users');
//   Future createUserData(
//     bool allowPush,
//     String name,
//     String email,
//     String preferences,
//     String celNumber,
//     String uid,
//     String photoUrl,
//     bool partnerCheck,
//     bool aceptTerms,
//   ) async {
//     return await userCollection.doc(uid).collection(uid).doc(uid).set({
//       'name': name,
//       'email': email,
//       'preferences': preferences,
//       'cel_number': celNumber,
//       'uid': uid,
//       'photo_url': photoUrl,
//       'partner_check': partnerCheck,
//       'accept_terms': aceptTerms,
//       'allow_push': allowPush,
//       'allow_emails': true,
//       'lang': '',
//       'first_launch': true,
//     });
//   }

//   Future updateNotificationActivate(bool notificationActivate) async {
//     return await userCollection.doc(uid).collection(uid).doc(uid).updateData({
//       'allow_push': notificationActivate,
//     });
//   }

//   Future language() async {
//     return await userCollection.doc(uid).collection(uid).doc(uid).updateData({
//       'lang': lang,
//     });
//   }

//   Future updateAllowEmails(bool allowEmails) async {
//     return await userCollection.doc(uid).collection(uid).doc(uid).updateData({
//       'allow_emails': allowEmails,
//     });
//   }

//   Future updatepartnerCheck(bool partnerCheck) async {
//     return await userCollection.doc(uid).collection(uid).doc(uid).updateData({
//       'partner_check': partnerCheck,
//     });
//   }

//   Future updatacceptTerms(bool acceptTerms) async {
//     return await userCollection.doc(uid).collection(uid).doc(uid).updateData({
//       'accept_terms': acceptTerms,
//     });
//   }

//   Future user_update_data(
//     String name,
//     String email,
//     String preferences,
//     String celNumber,
//     String uid,
//   ) async {
//     UserData userData;
//     return await userCollection.doc(uid).collection(uid).doc(uid).updateData({
//       'name': name ?? userData.name,
//       'email': email ?? userData.email,
//       'preferences': preferences ?? userData.preferences,
//       'cel_number': celNumber ?? userData.celNumber,
//       'uid': uid ?? uid,

//       // 'partner_check': partnerCheck ?? userData.partnerCheck,
//       // 'accept_terms': acceptTerms ?? userData.acceptTerms,
//     });
//   }

//   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//     return UserData(
//       name: snapshot.data() as Map<String,dynamic>['name'],
//       preferences: snapshot.data() as Map<String,dynamic>['preferences'],
//       email: snapshot.data() as Map<String,dynamic>['email'],
//       uid: uid,
//       photoUrl: snapshot.data() as Map<String,dynamic>['photo_url'],
//       celNumber: snapshot.data() as Map<String,dynamic>['cel_number'],
//       partnerCheck: snapshot.data() as Map<String,dynamic>['partner_check'] ?? false,
//       acceptTerms: snapshot.data() as Map<String,dynamic>['accept_terms'] ?? false,
//       allowPush: snapshot.data() as Map<String,dynamic>['allow_push'] ?? false,
//       allowEmail: snapshot.data() as Map<String,dynamic>['allow_email'] ?? false,
//       usercode: snapshot.data() as Map<String,dynamic>['usercode'] ?? "",
//       last_free_coin: snapshot.data() as Map<String,dynamic>['last_free_coin'],
//     );
//   }

//   Stream<UserData> get userData {
//     return userCollection
//         .doc(uid)
//         .collection(uid)
//         .doc(uid)
//         .snapshots()
//         .map(_userDataFromSnapshot);
//   }

//   //Actualizar foto de Perfil
//   Future uploadProfileImage(File image, String uid) async {
//     final StorageReference storageReference = FirebaseStorage()
//         .ref()
//         .child('user_profile_image')
//         .child(uid)
//         .child('$uid.jpg');
//     final StorageUploadTask uploadTask = storageReference.putFile(image);
//     StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//     String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
//     // print(imgUrl.toString());

//     await userCollection.doc(uid).collection(uid).doc(uid).updateData({
//       'photo_url': imgUrl,
//     });
//   }

//   //Subir fotos a la galeria del usuario

//   Future uploadImageFromGalleryOrCameraStorage(File image, String uid) async {
//     //Crear documento foto falso con esqueleto
//     FirebaseFirestore.instance
//         .collection('user_gallery_images')
//         .doc(uid)
//         .collection(uid)
//         .add({"photo_url": '', "date_time": DateTime.now()})
//         .then((onValue) async {
//           onValue.docID;
//           //Subir imagen a la galeria del usuario
//           final StorageReference storageReference = FirebaseStorage()
//               .ref()
//               .child('user_gallery_images')
//               .child(uid)
//               .child('${onValue.docID}.jpg');
//           final StorageUploadTask uploadTask = storageReference.putFile(image);
//           var downloadUrl =
//               await (await uploadTask.onComplete).ref.getDownloadURL();
//           print(downloadUrl);

//           //Actualizar foto
//           FirebaseFirestore.instance
//               .collection('user_gallery_images')
//               .doc(uid)
//               .collection(uid)
//               .doc(onValue.docID)
//               .updateData({
//                 'photo_url': downloadUrl,
//                 'date_time': DateTime.now(),
//               });
//         });
//   }

//   //Obtener imagenes de la Galleria Firestore
//   Stream<List<GalleryModel>> get getUserImages async* {
//     var galleryPictureList = List<GalleryModel>();

//     var userImageList =
//         FirebaseFirestore.instance
//             .collection('user_gallery_images')
//             .doc(uid)
//             .collection(uid)
//             .snapshots();
//     var gallerieItem;
//     await for (var userImages in userImageList) {
//       for (var image in userImages.docs) {
//         gallerieItem = GalleryModel(
//           dateTime: image.data()['date_time'],
//           photoUrl: image.data()['photo_url'],
//         );
//         galleryPictureList.add(gallerieItem);
//       }
//     }
//     yield (galleryPictureList);
//   }

//   // obtener nombre del partner al enviar la solicitud

//   Stream getPartnerData(userUid) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(userUid)
//         .collection(userUid)
//         .doc(userUid)
//         .snapshots();
//   }

//   Stream<List<dynamic>> getPartnerDataList(
//     List<DocumentSnapshot> userUid,
//   ) async* {
//     List<DocumentSnapshot> listPartner = List();
//     for (var uid in userUid) {
//       DocumentSnapshot userData =
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc("${uid.docID}")
//               .collection("${uid.docID}")
//               .doc("${uid.docID}")
//               .get();
//       listPartner.add(userData);
//     }
//     yield listPartner;
//   }
// }
