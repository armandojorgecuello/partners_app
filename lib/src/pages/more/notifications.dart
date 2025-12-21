// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/pages/others/settings_app.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({Key key}) : super(key: key);

//   @override
//   _NotificationsPageState createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   bool _notificationActivate = true;
//   bool _allowEmails = true;
//   var snapshotUser;
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             children: [
//               GestureDetector(
//                 child: SizedBox(
//                   height: 40.0,
//                   width: 100.0,
//                   // color:Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.arrow_back_ios, color: Colors.white),
//                       Text(
//                         localizations.t('notifications.back'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap:
//                     () => Navigator.of(context).push(
//                       CupertinoPageRoute(builder: (context) => Settings()),
//                     ),
//               ),
//               SizedBox(width: 25.0),
//               Text(localizations.t('notifications.title')),
//             ],
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//           // backgroundColor: Colors.red,
//           automaticallyImplyLeading: false,
//         ),
//         backgroundColor: Color(0xff393939),
//         // backgroundColor: Colors.grey[900],
//         body: StreamBuilder<DocumentSnapshot>(
//           stream:
//               FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user)
//                   .collection(user)
//                   .doc(user)
//                   .snapshots(),
//           builder: (context, snapshot) {
//             snapshotUser = snapshot.data;
//             return ListView(
//               children: <Widget>[
//                 SizedBox(height: 10.0),
//                 _allowPushSwitch(localizations),
//                 Divider(color: Colors.grey),
//                 _allowEmailsSwitch(localizations),
//                 Divider(color: Colors.grey),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _allowPushSwitch(localizations) {
//     // var user = Provider.of<LoginState>(context, listen: false).currentUser();
//     // print(userData.allowPush.toString());
//     final pref = UserPreferences();
//     String user = pref.uid;

//     return SwitchListTile(
//       activeColor: Colors.white,
//       activeTrackColor: Colors.red,
//       title: Text(
//         localizations.t('notifications.pushNotifi'),
//         style: TextStyle(
//           color: Colors.grey,
//           fontFamily: 'SansRegularlight',
//           fontSize: 14,
//         ),
//       ),
//       value: snapshotUser['allow_push'] ?? _notificationActivate,
//       onChanged: (valor) async {
//         setState(() {
//           _notificationActivate = valor;

//           UsuarioProvider(
//             uid: user,
//           ).updateNotificationActivate(_notificationActivate);
//         });
//       },
//     );
//   }

//   Widget _allowEmailsSwitch(localizations) {
//     final pref = UserPreferences();
//     String user = pref.uid; // print(userData.allowPush.toString());
//     return SwitchListTile(
//       activeColor: Colors.white,
//       activeTrackColor: Colors.red,
//       title: Text(
//         localizations.t('notifications.emailNotifi'),
//         style: TextStyle(
//           color: Colors.grey,
//           fontFamily: 'SansRegularlight',
//           fontSize: 14,
//         ),
//       ),
//       value: snapshotUser['allow_emails'] ?? _allowEmails,
//       onChanged: (valor) async {
//         setState(() {
//           _allowEmails = valor;
//           UsuarioProvider(uid: user).updateAllowEmails(_allowEmails);
//         });
//       },
//     );
//   }
// }
