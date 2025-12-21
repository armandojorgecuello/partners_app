// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/providers/support_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class SendSupportTicketsPage extends StatefulWidget {
//   const SendSupportTicketsPage({super.key});

//   @override
//   _SendSupportTicketsPageState createState() => _SendSupportTicketsPageState();
// }

// class _SendSupportTicketsPageState extends State<SendSupportTicketsPage> {
//   String subject, description;

//   final _formKey = GlobalKey<FormState>();
//   bool send = false;
//   DateTime date_time;

//   get_subject(subject) {
//     this.subject = subject;
//   }

//   get_description(description) {
//     this.description = description;
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             children: [
//               GestureDetector(
//                 child: SizedBox(
//                   height: 40.0,
//                   width: 100.0,
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.arrow_back_ios, color: Colors.white),
//                       Text(
//                         localizations.t('messageSupport.back'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () => Navigator.of(context).pop(),
//               ),
//               SizedBox(width: 10.0),
//               Text(localizations.t('messageSupport.title')),
//             ],
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//           // backgroundColor : Colors.red,
//           automaticallyImplyLeading: false,
//         ),
//         backgroundColor: Color(0xff393939),
//         body: SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: body(localizations),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget body(localizations) {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10.0),
//               child: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 0.0, right: 0.0),
//                   child: Text(
//                     localizations.t('messageSupport.message'),
//                     // "",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'SansRegularlight',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: Text(
//                 localizations.t('messageSupport.subject'),
//                 style: TextStyle(
//                   fontFamily: 'Sans',
//                   color: Colors.white,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: TextFormField(
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return "Subject is empty";
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   hintText: localizations.t('messageSupport.error'),
//                   // "",
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14.0,
//                     fontFamily: 'SansRegularlight',
//                   ),
//                   // border: InputBorder(borderSide: BorderSide(color: Colors.white)),
//                   // border: UnderlineInputBorder(
//                   //   borderSide: BorderSide(color: Colors.white),
//                   // )
//                 ),
//                 onChanged: (String subject) {
//                   get_subject(subject);
//                 },
//                 cursorColor: Colors.grey,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: Text(
//                 localizations.t('messageSupport.description'),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14.0,
//                   fontFamily: 'Sans',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   hintText: localizations.t('messageSupport.descriptionHint'),
//                   // " ",
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14.0,
//                     fontFamily: 'SansRegularlight',
//                   ),
//                   // border: InputBorder(borderSide: BorderSide(color: Colors.white)),
//                   // border: UnderlineInputBorder(
//                   //   borderSide: BorderSide(color: Colors.white),
//                   // )
//                 ),
//                 maxLines: 8,
//                 onChanged: (String description) {
//                   get_description(description);
//                 },
//                 cursorColor: Colors.grey,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.36),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child:
//                     send
//                         ? Center(child: CircularProgressIndicator())
//                         : ElevatedButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(70.0),
//                           ),
//                           elevation: 0.0,
//                           color: Color(0xff7A1418),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 10.0,
//                             vertical: 10.0,
//                           ),
//                           child: Container(
//                             child: Column(
//                               children: <Widget>[
//                                 Text(
//                                   localizations.t('messageSupport.submit'),
//                                   // "Scan QR Code",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15.0,
//                                     fontFamily: 'SansRegularlight',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           onPressed: () {
//                             _sendTask(localizations);
//                             setState(() {
//                               send = true;
//                             });
//                           },
//                         ),
//               ),
//             ),
//             // Expanded(child:Container()),
//           ],
//         ),
//       ),
//     );
//   }

//   _sendTask(localizations) async {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     if (_formKey.currentState!.validate()) {
//       SupportProvider(user)
//           .createSupportMessage(subject, description)
//           .whenComplete(() => _showDialog(localizations));
//       setState(() {});
//     }
//   }

//   _showDialog(localizations) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (context) => AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             backgroundColor: Color(0xff282828),
//             content: Container(
//               child: StreamBuilder(
//                 stream: SupportProvider(user).getSupportTicketNumber,
//                 builder: (context, AsyncSnapshot snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.connectionState ==
//                       ConnectionState.active) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Center(
//                           child: Container(
//                             child: Text(
//                               localizations.t('messageSupport.dialogTitle'),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Sans',
//                                 fontSize: 14.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20.0),
//                         Container(
//                           child: Text(
//                             localizations.t('messageSupport.dialogsubTitle'),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'SansRegularlight',
//                               fontSize: 14.0,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30.0),
//                         Center(
//                           child: Container(
//                             width: 120.0,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               // border:Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(50.0),
//                             ),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.popAndPushNamed(
//                                   context,
//                                   'support_tiquet',
//                                 );
//                               },
//                               child: Text(
//                                 localizations.t('messageSupport.buttomDialog'),
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ),
//           ),
//     );
//   }
// }
