// import 'package:flutter/material.dart';

// import 'package:demoji/demoji.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:honeyiou/src/models/profile_model.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/utils/partner_request_validation.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:clipboard/clipboard.dart';

// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class AddPartner extends StatefulWidget {
//   const AddPartner({Key key}) : super(key: key);

//   @override
//   _AddPartnerState createState() => _AddPartnerState();
// }

// class _AddPartnerState extends State<AddPartner> with TickerProviderStateMixin {
//   String futureString;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   BuildContext scaffoldContext;
//   bool sendingRequest = false;
//   bool sendingRequestI = false;

//   AnimationController _controller;
//   Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();
//   }

//   //
//   // @override
//   // void dispose() {
//   // _controller.dispose();
//   // super.dispose();
//   // }
//   //
//   String _userCode;
//   String userCode;
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final query = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: _appBar(localizations),
//         backgroundColor: Color(0xff282828),
//         // backgroundColor: Color(0xff393939),
//         body: Builder(
//           builder: (BuildContext context) {
//             scaffoldContext = context;
//             final pref = UserPreferences();
//             String user = pref.uid;
//             // String uidUser = user.uid;
//             return SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: Stack(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: <Widget>[
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.05,
//                           ),
//                           FadeTransition(
//                             opacity: _animation,
//                             child: QrImage(
//                               backgroundColor: Colors.white,
//                               data: user,
//                               version: QrVersions.auto,
//                               size: MediaQuery.of(context).size.width * 0.85,
//                             ),
//                           ),
//                           SizedBox(height: 40.0),
//                           Center(
//                             child: FadeTransition(
//                               opacity: _animation,
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.85,
//                                 child: Text(
//                                   localizations.t('addPartners.text'),
//                                   textAlign: TextAlign.center,
//                                   // "Use your partners app to scan this QR Code \n and start enjoying favors",
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.03,
//                           ),
//                           Container(
//                             child: FadeTransition(
//                               opacity: _animation,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.only(
//                                         left: 10.0,
//                                         right: 10.0,
//                                       ),
//                                       child: Divider(color: Colors.white),
//                                     ),
//                                   ),
//                                   Text(
//                                     localizations.t(
//                                       "addPartners.userCodeDesc0",
//                                     ),
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.only(
//                                         left: 10.0,
//                                         right: 10.0,
//                                       ),
//                                       child: Divider(color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20.0),
//                           StreamBuilder(
//                             stream: UsuarioProvider(uid: user).userData,
//                             builder: (_, AsyncSnapshot<UserData> snap) {
//                               if (snap.hasData) {
//                                 userCode = snap.data.usercode;
//                                 return InkWell(
//                                   onTap: () {
//                                     FlutterClipboard.copy(
//                                       snap.data.usercode,
//                                     ).then(
//                                       (value) => showSnackBar(localizations),
//                                     );
//                                     setState(() {
//                                       _userCode = snap.data.usercode;
//                                     });
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(5.0),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(50.0),
//                                       color: Colors.grey[200],
//                                     ),
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.6,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.person),
//                                         Text(snap.data.usercode),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 return Container(
//                                   child: Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                           SizedBox(height: 20.0),
//                           Center(
//                             child: FadeTransition(
//                               opacity: _animation,
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.85,
//                                 child: Text(
//                                   localizations.t("addPartners.userCodeDesc") +
//                                       " " +
//                                       Demoji.wink +
//                                       ")." +
//                                       " " +
//                                       localizations.t(
//                                         "addPartners.userCodeDescI",
//                                       ),
//                                   // "Use your partners app to scan this QR Code \n and start enjoying favors",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                           ),
//                           Center(
//                             child: FadeTransition(
//                               opacity: _animation,
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     _bottom(query, context, localizations),
//                                     // Expanded(child: Container(),),
//                                     _addWithUser(
//                                       query,
//                                       context,
//                                       localizations,
//                                       userCode,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.05,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _appBar(localizations) {
//     return AppBar(
//       titleSpacing: 10.0,
//       title: Row(
//         children: [
//           GestureDetector(
//             child: FadeTransition(
//               opacity: _animation,
//               child: SizedBox(
//                 height: 40.0,
//                 width: MediaQuery.of(context).size.width * 0.21,
//                 // color:Colors.white,
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.arrow_back_ios, color: Colors.white),
//                     Text(
//                       localizations.t('partnersAccepted.back'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             onTap: () => Navigator.of(context).pop(),
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.13),
//           Text(localizations.t('addPartners.title')),
//           Expanded(child: Container()),
//           FadeTransition(
//             opacity: _animation,
//             child: IconButton(
//               icon: Icon(FontAwesomeIcons.userFriends),
//               onPressed:
//                   () => Navigator.of(context).pushNamed('partners_request'),
//             ),
//           ),
//         ],
//       ),
//       centerTitle: false,
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color(0xff7a1418),
//     );
//   }

//   void showSnackBar(localizations) {
//     _scaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(localizations.t("addPartners.snackbarCopyCode"))),
//     );
//   }

//   Widget _addWithUser(query, context, localizations, String userCode) {
//     return SizedBox(
//       width: query.width * 0.43,
//       child: ElevatedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(70.0),
//         ),
//         elevation: 0.0,
//         color: Colors.grey[800],
//         padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5.0),
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               Text(
//                 localizations.t("addPartners.buttomII"),
//                 // "Scan QR Code",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14.0,
//                   fontFamily: 'SansRegularlight',
//                 ),
//               ),
//             ],
//           ),
//         ),
//         onPressed: () {
//           setState(() {
//             sendingRequestI = true;
//           });
//           _showDialogII(context, localizations, userCode);
//         },
//       ),
//     );
//   }

//   Widget _bottom(query, context, localizations) {
//     return SizedBox(
//       width: query.width * 0.43,
//       child:
//           sendingRequest
//               ? Center(child: CircularProgressIndicator())
//               : ElevatedButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(70.0),
//                 ),
//                 elevation: 0.0,
//                 color: Color(0xff7A1418),
//                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
//                 child: Container(
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         localizations.t('addPartners.buttomText'),
//                         // "Scan QR Code",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14.0,
//                           fontFamily: 'SansRegularlight',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     sendingRequest = true;
//                   });
//                   scanQr(context, localizations);
//                 },
//               ),
//     );
//   }

//   scanQr(context, localizations) async {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     String info;
//     DocumentSnapshot namePartner;
//     // await print(info);
//     try {
//       futureString = await BarcodeScanner.scan();
//       if (user != futureString) {
//         ValidatePartnerReques().validate(user, futureString, context);
//         _showDialog(
//           localizations.t("addPartners.sameUserCodeTitle"),
//           localizations.t("addPartners.sameUserCodeDesc"),
//           context,
//           localizations,
//         );
//       }
//       print(namePartner);
//     } catch (e) {
//       futureString = e.toString();
//       _showDialog(
//         localizations.t("addPartners.dialogCancelScan"),
//         localizations.t("addPartners.dialogCancelScanDesc"),
//         context,
//         localizations,
//       );
//     }
//   }

//   _showDialog(String title, String desc, BuildContext context, localizations) {
//     return showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               backgroundColor: Color(0xff282828),
//               // backgroundColor: ,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               content: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegular',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   Text(
//                     desc,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegularlight',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       setState(() {
//                         sendingRequest = false;
//                       });
//                     },
//                     child: Text(
//                       localizations.t('addPartners.showDialogButtom'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'SansRegularlight',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return Sizedbox();
//       },
//     );
//   }

//   // _showDialog(String info, BuildContext context, localizations){
//   //   return showGeneralDialog(
//   //     transitionBuilder: (context, a1, a2, widget){
//   //       final curvedValue = Curves.easeInOutBack.transform ( 1.0) - (a1.value);
//   //       return Transform(
//   //         transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//   //         child: Opacity(
//   //           opacity: a1.value,
//   //           child:  AlertDialog(
//   //             backgroundColor: Color(0xff282828),
//   //             // backgroundColor: ,
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(20.0)
//   //             ),
//   //             content: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 Text(info, style: TextStyle(color:Colors.white, fontFamily: 'SansRegular'),),
//   //                 SizedBox(height: 20.0,),
//   //                 ElevatedButton(
//   //                   color: Color(0xff7A1418),
//   //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
//   //                 onPressed: (){
//   //                   setState(() {
//   //                     sendingRequest = false;
//   //                   });
//   //                   Navigator.of(context).pop();
//   //                 }, child: Text(localizations.t('addPartners.showDialogButtom'), style: TextStyle(color:Colors.white, fontFamily: 'SansRegularlight'),))

//   //               ],
//   //             ),
//   //           ),
//   //         )
//   //       );
//   //     },
//   //     transitionDuration: Duration(milliseconds: 200),
//   //     barrierDismissible: true,
//   //     barrierLabel: '',
//   //     context: context,
//   //     pageBuilder: (context, animation1, animation2) {return SizedBox();}
//   //   );
//   //  }

//   _showDialogII(context, localizations, String userCode) {
//     return showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: StatefulBuilder(
//               builder: (context, setState) {
//                 return AlertDialog(
//                   backgroundColor: Color(0xff282828),
//                   // backgroundColor: ,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   content: PopupWidget(usercode: userCode),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return Sizedbox();
//       },
//     );
//   }
// }

// class PopupWidget extends StatefulWidget {
//   final String usercode;

//   const PopupWidget({Key key, this.usercode}) : super(key: key);

//   @override
//   _PopupWidgetState createState() => _PopupWidgetState();
// }

// class _PopupWidgetState extends State<PopupWidget>
//     with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _animation;
//   Animation<Offset> _offsetFloatTitle;
//   Animation<Offset> _offsetFloatProflePicture;
//   Animation<Offset> _offsetFloatButtom;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     _offsetFloatTitle = Tween<Offset>(
//       begin: Offset(0.0, -2),
//       end: Offset(0.0, 0),
//     ).animate(_controller);
//     _controller.forward();

//     _offsetFloatProflePicture = Tween<Offset>(
//       begin: Offset(-1, 0.0),
//       end: Offset(0.0, 0.0),
//     ).animate(_controller);
//     _controller.forward();

//     _offsetFloatButtom = Tween<Offset>(
//       begin: Offset(0.0, 1),
//       end: Offset(0.0, 0),
//     ).animate(_controller);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   final formKey = GlobalKey<FormState>();
//   String userCode;
//   getuserCode(String code) {
//     userCode = code;
//   }

//   bool existUserCode;

//   @override
//   Widget build(BuildContext context) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             localizations.t("addPartners.addPopupText"),
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Sans',
//               fontSize: 16.0,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             localizations.t("addPartners.addPopupTextI"),
//             style: TextStyle(color: Colors.white, fontSize: 12.0),
//             textAlign: TextAlign.center,
//           ),
//           TextField(
//             onChanged: (String val) {
//               getuserCode(val);
//             },
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Center(
//             child: SizedBox(
//               height: 40.0,
//               width: MediaQuery.of(context).size.width * 0.6,
//               child: Text(
//                 existUserCode == false
//                     ? localizations.t("addPartners.errortext")
//                     : "",
//                 style: TextStyle(
//                   color: Color(0xff7A1418),
//                   fontFamily: 'SansRegularlight',
//                   fontSize: 12.0,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(width: 10.0),
//               ElevatedButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50.0),
//                 ),
//                 color: Colors.grey[800],
//                 onPressed: () {
//                   FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(user)
//                       .collection(user)
//                       .doc(user)
//                       .get()
//                       .then((value) {
//                         // widget.onPressed();
//                         Navigator.pop(context);
//                       });
//                 },
//                 child: Text(
//                   "Cancelar",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SansRegularlight',
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10.0),
//               ElevatedButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50.0),
//                 ),
//                 color: Color(0xff7A1418),
//                 onPressed: () async {
//                   if (widget.usercode != userCode) {
//                     FirebaseFirestore.instance
//                         .collection('usercodes')
//                         .doc(userCode)
//                         .get()
//                         .then((queryUSerCode) {
//                           if (queryUSerCode.exists) {
//                             setState(() {
//                               existUserCode = queryUSerCode.exists;
//                             });
//                             ValidatePartnerReques().validate(
//                               user,
//                               "${queryUSerCode.data() as Map<String,dynamic>["uid"]}",
//                               context,
//                             );
//                           } else {}
//                         });
//                   } else {
//                     Navigator.of(context).pop();
//                     _showDialog(
//                       localizations.t("addPartners.sameUserCodeTitle"),
//                       localizations.t("addPartners.sameUserCodeDesc"),
//                       context,
//                       localizations,
//                     );
//                   }
//                 },
//                 child: Text(
//                   "Aceptar",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SansRegularlight',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   _showDialog(String title, String desc, BuildContext context, localizations) {
//     return showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               backgroundColor: Color(0xff282828),
//               // backgroundColor: ,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               content: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegular',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   Text(
//                     desc,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegularlight',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       localizations.t('addPartners.showDialogButtom'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'SansRegularlight',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return Sizedbox();
//       },
//     );
//   }

//   showDialogAfterScan(
//     String uidSender,
//     String uidReceiver,
//     localizations,
//     context,
//     String nameSender,
//     Function onPressed,
//   ) {
//     return showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               backgroundColor: Color(0xff282828),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               content: PopUpElement(
//                 nameSender: nameSender,
//                 onPressed: onPressed,
//                 uidReceiver: uidReceiver,
//                 uidSender: uidSender,
//               ),
//             ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       // barrierColor: Color(0xff282828),
//       pageBuilder: (context, animation1, animation2) {
//         return Sizedbox();
//       },
//     );
//   }

//   Widget popUpEleent(
//     String uidReceiver,
//     String uidSender,
//     offsetFloatLeading,
//     String nameSender,
//     Function onPressed,
//   ) {
//     final user = UsuarioProvider();
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return Stack(
//       children: [
//         Positioned(
//           left: 77,
//           child: StreamBuilder(
//             stream: user.getPartnerData(uidReceiver),
//             builder: (_, snapshot) {
//               // snapshot.connectionState == ConnectionState.waiting ? return
//               return snapshot.data() as Map<String,dynamic>["photo_url"] != null
//                   ? FadeTransition(
//                     opacity: _animation,
//                     child: CircleAvatarWidget(
//                       imageUrl: snapshot.data() as Map<String,dynamic>["photo_url"],
//                       radius: 30.0,
//                     ),
//                   )
//                   : Container();
//               //
//             },
//           ),
//         ),
//         Positioned(
//           right: 77.0,
//           child: StreamBuilder(
//             stream: user.getPartnerData(uidSender),
//             builder: (_, snapshot) {
//               return snapshot.data() as Map<String,dynamic>["photo_url"] != null
//                   ? FadeTransition(
//                     opacity: _animation,
//                     child: CircleAvatarWidget(
//                       imageUrl: snapshot.data() as Map<String,dynamic>["photo_url"],
//                       radius: 30.0,
//                     ),
//                   )
//                   : Container();
//               //
//             },
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//             Center(
//               child: Container(
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Text(
//                     localizations.t('addPartners.textDialogAfterScan1') +
//                         " " +
//                         nameSender +
//                         " " +
//                         localizations.t('addPartners.textDialogAfterScan2'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Sans',
//                       fontSize: 12.0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             SizedBox(height: 10.0),
//             Center(
//               child: Container(
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Text(
//                     localizations.t('addPartners.textDialogAfterScan3'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 12.0,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             SizedBox(height: 20.0),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(width: 10.0),
//                   Container(
//                     height: 33.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50.0),
//                       color: Color(0xffBF2328),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         onPressed();
//                       },
//                       child: Text(
//                         localizations.t('startNegociation.okButtonDialog'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SansRegularlight',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
