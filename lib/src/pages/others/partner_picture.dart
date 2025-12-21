// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class PartnerPicture extends StatefulWidget {
//   const PartnerPicture({super.key});

//   @override
//   PicturePartner createState() {
//     return PicturePartner();
//   }
// }

// class PicturePartner extends State<PartnerPicture> {
//   @override
//   Widget build(BuildContext context) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return StreamBuilder(
//       stream:
//           FirebaseFirestore.instance
//               .collection('users_partner')
//               .doc(user)
//               .collection(user)
//               .doc(user)
//               .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.data != null) {
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
//                           image: NetworkImage('${snapshot.data() as Map<String,dynamic>['photo_url']}'),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Change profile picture',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//               onTap: () {},
//             ),
//           );
//         } else {
//           return GestureDetector(
//             child: Column(
//               children: <Widget>[
//                 CircularProgressIndicator(),
//                 Text(
//                   'Change Profile Picture',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             onTap: () {},
//           );
//         }
//       },
//     );
//   }
// }
