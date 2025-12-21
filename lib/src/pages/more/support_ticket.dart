// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:intl/intl.dart';

// class SupportTicketsPage extends StatelessWidget {
//   const SupportTicketsPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
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
//                         localizations.t('support.back'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () => Navigator.pushNamed(context, "setting"),
//               ),
//               SizedBox(width: 15.0),
//               Text(localizations.t('support.title')),
//             ],
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//         ),
//         backgroundColor: Color(0xff393939),
//         body: _body(context, localizations),
//       ),
//     );
//   }

//   Widget _body(context, localizations) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       child: Stack(
//         children: <Widget>[
//           StreamBuilder<QuerySnapshot>(
//             stream:
//                 FirebaseFirestore.instance
//                     .collection('support_message')
//                     .doc(user)
//                     .collection(user)
//                     .orderBy('date_time', descending: true)
//                     .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.data.docs.isEmpty) {
//                   return Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.35,
//                         ),
//                         Center(
//                           child: Text(
//                             localizations.t('support.emptyListMessage'),
//                             // " ",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.3,
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.8,
//                   child: ListView.builder(
//                     itemCount: snapshot.data.docs.length,
//                     itemBuilder: (context, index) {
//                       DocumentSnapshot doc = snapshot.data.docs[index];
//                       String formattedDate;
//                       DateTime dateTime = doc.data() as Map<String,dynamic>['date_time'].toDate();
//                       var formatter = DateFormat("MMM d' at 'HH':'mm aaa");
//                       formattedDate = formatter.format(dateTime);
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10.0,
//                           vertical: 5.0,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Row(
//                               children: <Widget>[
//                                 Container(
//                                   child: Text(
//                                     'Ticket: ' + doc.data() as Map<String,dynamic>['ticket_id'] ?? '',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Sans',
//                                       fontSize: 14.0,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5.0),
//                                 Container(
//                                   child: Text(
//                                     doc.data() as Map<String,dynamic>['status'] ?? '',
//                                     style: TextStyle(
//                                       color: Colors.greenAccent,
//                                       fontFamily: 'Sans',
//                                       fontSize: 14.0,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Container(
//                                 child: Text(
//                                   localizations.t('support.date') + ': ',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'SansRegular',
//                                     fontSize: 14.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               child: Text(
//                                 formattedDate,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'SansRegular',
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10.0),
//                               child: Container(
//                                 child: Text(
//                                   localizations.t('support.subject'),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'SansRegular',
//                                     fontSize: 14.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               child: Text(
//                                 doc.data() as Map<String,dynamic>['subject'] ?? '',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'SansRegular',
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10.0),
//                               child: Container(
//                                 child: Text(
//                                   localizations.t('support.description'),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'SansRegular',
//                                     fontSize: 14.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               child: Text(
//                                 doc.data() as Map<String,dynamic>['description'] ?? '',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'SansRegular',
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(0.0),
//                               child: Divider(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 return Container();
//               }
//             },
//           ),
//           Positioned(
//             bottom: 30.0,
//             left: 10.0,
//             right: 10.0,
//             child: ElevatedButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(70.0),
//               ),
//               color: const Color(0xff7a1418),
//               child: Container(
//                 child: Center(
//                   child: Text(
//                     localizations.t('support.submitTicket'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontFamily: 'SansRegularlight',
//                     ),
//                   ),
//                 ),
//               ),
//               onPressed:
//                   () => Navigator.pushNamed(context, 'send_support_ticket'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
