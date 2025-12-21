// import 'dart:io';
// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';

// class ProfilePicture extends StatefulWidget {
//   const ProfilePicture({super.key});

//   @override
//   Picture createState() {
//     return Picture();
//   }
// }

// class Picture extends State<ProfilePicture> {
//   static File galleryFile;
//   static Future<File> imageFile;
//   //seleccionar foto de la galeria o camara
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return StreamBuilder<DocumentSnapshot>(
//       stream:
//           FirebaseFirestore.instance
//               .collection('users')
//               .doc(user)
//               .collection(user)
//               .doc(user)
//               .snapshots(),
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting)
//           return Container(child: Center(child: CircularProgressIndicator()));
//         if (snapshot.data.exists) {
//           return Container(
//             child: GestureDetector(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 8.0),
//                   Container(
//                     height: 100.0,
//                     width: 100.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(150.0),
//                       // image: DecorationImage(
//                       // fit: BoxFit.cover,
//                       // image:
//                       // ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(150.0),
//                       child: FadeInImage(
//                         placeholder: AssetImage("assets/loading/loading.gif"),
//                         image:
//                             snapshot.data() as Map<String,dynamic>['photo_url'] == null
//                                 ? AssetImage("assets/image/no_image.png")
//                                 : NetworkImage('${snapshot.data() as Map<String,dynamic>['photo_url']}'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Center(
//                     child: Text(
//                       snapshot.data() as Map<String,dynamic>['photo_url'] == null
//                           ? "Seleccionar foto"
//                           : localizations.t('profileInputs.pictureProfileText'),
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 _select(localizations);
//               },
//             ),
//           );
//         } else {
//           return Container(
//             child: GestureDetector(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 8.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10.0,
//                       horizontal: 130.0,
//                     ),
//                     child: Container(
//                       height: 100.0,
//                       width: 100.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(150.0),
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage('assets/image/no_image.png'),
//                         ),
//                       ),
//                     ),
//                     // backgroundColor: Colors.grey[600],
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 _select(localizations);
//               },
//             ),
//           );
//         }
//       },
//     );
//   }

//   Future<void> _select(localizations) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final pref = UserPreferences();
//         String user = pref.uid;
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 GestureDetector(
//                   child: Text("Camera"),
//                   onTap:
//                       () => [
//                         pickImageFrom(ImageSource.camera, user, localizations),
//                         Navigator.of(context).pop(),
//                       ],
//                 ),
//                 SizedBox(height: 05.0),
//                 Divider(),
//                 SizedBox(height: 05.0),
//                 GestureDetector(
//                   child: Text("Gallery"),
//                   onTap:
//                       () => [
//                         pickImageFrom(ImageSource.gallery, user, localizations),
//                         Navigator.of(context).pop(),
//                       ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future pickImageFrom(ImageSource source, String uid, localizations) async {
//     var imageFile = await ImagePicker.pickImage(source: source);
//     setState(() {
//       galleryFile = imageFile;
//       UsuarioProvider()
//           .uploadProfileImage(galleryFile, uid)
//           .whenComplete(
//             () => Scaffold.of(context).showSnackBar(
//               SnackBar(
//                 duration: Duration(seconds: 4),
//                 content: (Text(
//                   localizations.t('profileInputs.snakbarPictureUpdate'),
//                   style: TextStyle(color: Colors.white),
//                 )),
//               ),
//             ),
//           );
//     });
//   }
// }
