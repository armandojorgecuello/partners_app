// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/providers/partner_provider.dart';
// import 'package:honeyiou/src/widget/appbar_widget.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class PartnersRequest extends StatefulWidget {
//   const PartnersRequest({super.key});

//   @override
//   _PartnersRequestState createState() => _PartnersRequestState();
// }

// class _PartnersRequestState extends State<PartnersRequest>
//     with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _animation;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     super.initState();
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           child: AppBarWidget(
//             title: localizations.t('partnersRequest.title'),
//             buttontext: localizations.t('partnersRequest.back'),
//           ),
//           preferredSize: Size.fromHeight(55.0),
//         ),
//         backgroundColor: Color(0xff282828),
//         body: Stack(children: <Widget>[listPartner(localizations)]),
//       ),
//     );
//   }

//   Widget listPartner(localizations) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     var partnerRequest = PartnerProvider(uid: user).partnerRequestList;
//     return StreamBuilder<QuerySnapshot>(
//       stream: partnerRequest,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.connectionState == ConnectionState.active) {
//           if (snapshot.data.docs.isNotEmpty) {
//             return ListView.builder(
//               itemCount: snapshot.data.docs.length,
//               itemBuilder: (_, index) {
//                 DocumentSnapshot listPartner = snapshot.data.docs[index];
//                 print(listPartner.docID);
//                 return FutureBuilder(
//                   future: PartnerProvider().partnerData(listPartner.docID),
//                   builder: (_, snapshot) {
//                     if (snapshot.hasData) {
//                       return FadeTransition(
//                         opacity: _animation,
//                         child: Container(
//                           height: 120.0,
//                           padding: EdgeInsets.only(top: 10.0, left: 5.0),
//                           child: Container(
//                             padding: EdgeInsets.only(top: 10.0),
//                             height: 90.0,
//                             width: 200.0,
//                             child: Stack(
//                               children: [
//                                 CircleAvatarWidget(
//                                   imageUrl: snapshot.data() as Map<String,dynamic>['photo_url'],
//                                   radius: 35.0,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     top: 100.0,
//                                     left: 5.0,
//                                     right: 5.0,
//                                   ),
//                                   child: Divider(color: Colors.white),
//                                 ),
//                                 Positioned(
//                                   left: 80.0,
//                                   top: 10.0,
//                                   child: Text(
//                                     snapshot.data() as Map<String,dynamic>['name'],
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   left: 80.0,
//                                   top: 40.0,
//                                   child: Text(
//                                     localizations.t(
//                                               'partnersRequest.preferences',
//                                             ) +
//                                             ': ' +
//                                             snapshot.data() as Map<String,dynamic>['preferences'] ??
//                                         'N/A',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 10.0,
//                                   right: 5.0,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20.0),
//                                     ),
//                                     child: ElevatedButton(
//                                       color: const Color(0xff7a1418),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                           20.0,
//                                         ),
//                                       ),
//                                       onPressed: () async {
//                                         String name = snapshot.data() as Map<String,dynamic>['name'];

//                                         PartnerProvider(uid: user)
//                                             .acceptPartnerRequestReceiver(
//                                               snapshot.data() as Map<String,dynamic>['preferences'],
//                                               user,
//                                               listPartner.docID,
//                                               snapshot.data() as Map<String,dynamic>['name'],
//                                               snapshot.data() as Map<String,dynamic>['photo_url'],
//                                             )
//                                             .whenComplete(
//                                               () => _showDialogII(
//                                                 name,
//                                                 context,
//                                                 localizations,
//                                               ),
//                                             );
//                                         PartnerProvider(
//                                           uid: user,
//                                         ).acceptPartnerRequestSender(
//                                           snapshot.data() as Map<String,dynamic>['preferences'],
//                                           listPartner.docID,
//                                           user,
//                                           snapshot.data() as Map<String,dynamic>['name'],
//                                           snapshot.data() as Map<String,dynamic>['photo_url'],
//                                         );
//                                         await PartnerProvider()
//                                             .deletePartnerRequest(
//                                               user,
//                                               listPartner.docID,
//                                             );
//                                       },
//                                       child: Text(
//                                         localizations.t(
//                                           'partnersRequest.buttomAccept',
//                                         ),
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return SizedBox(
//                         width: 30.0,
//                         height: 30.0,
//                         child: Center(child: CircularProgressIndicator()),
//                       );
//                     }
//                   },
//                 );
//               },
//             );
//           } else {
//             return FadeTransition(
//               opacity: _animation,
//               child: Center(
//                 child: Text(
//                   localizations.t('partnersRequest.messageEmptyList'),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12.0,
//                     fontFamily: 'SansLightItalic',
//                   ),
//                 ),
//               ),
//             );
//           }
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

//   _showDialogII(String name, context, localizations) {
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
//                   content: PopupWidgetI(),
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

//   // _showDialog(String name, BuildContext context, localizations){
//   //     return showDialog(
//   //       context: context,
//   //       barrierDismissible: true,
//   //       builder: (context) =>  AlertDialog(
//   //       backgroundColor: Color(0xff282828),
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(20.0)
//   //       ),
//   //       content: Container(
//   //         child:  Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: <Widget>[
//   //                 Container(
//   //                   child: Text(
//   //                     localizations.t('partnersRequest.messageAccept'),
//   //                   style: TextStyle(color:Colors.white, fontFamily: 'Sans', fontSize: 12.0),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 10.0,),
//   //                 Container(
//   //                   child: Text(
//   //                     localizations.t('partnersRequest.messageDialogAccept') + " " + name + " " + localizations.t('partnersRequest.messageDialogAccept2'),
//   //                   style: TextStyle(color:Colors.white, fontFamily: 'SansRegularlight', fontSize: 12.0),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 10.0,),
//   //               Center(
//   //                 child: Container(
//   //                   height: 33.0,
//   //                   decoration: BoxDecoration(
//   //                     borderRadius: BorderRadius.circular(50.0),
//   //                     color:Color(0xffBF2328)
//   //                   ),
//   //                   child: ElevatedButton(
//   //                   onPressed: (){
//   //                     Navigator.of(context).pop();
//   //                   }, child: Text('Ok', style: TextStyle(color:Colors.white, fontFamily: 'SansRegularlight'),)),
//   //                 ),
//   //               )

//   //               ],
//   //             )
//   //         ),
//   //     ));
//   //   }

//   Widget _bottom(context, localizations) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 450.0, left: 20.0, right: 20.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.9,
//         height: MediaQuery.of(context).size.height * 0.1,
//         child: ElevatedButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(70.0),
//           ),
//           elevation: 0.0,
//           color: const Color(0xff7a1418),

//           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   localizations.t('partnersRequest.buttomText'),
//                   style: TextStyle(color: Colors.white, fontSize: 15.0),
//                 ),
//               ],
//             ),
//           ),
//           onPressed: () {
//             Navigator.pushNamed(context, "add_partners");
//           },
//         ),
//       ),
//     );
//   }
// }

// class PopupWidgetI extends StatefulWidget {
//   final String name;

//   const PopupWidgetI({Key key, this.name}) : super(key: key);

//   @override
//   _PopupWidgetIState createState() => _PopupWidgetIState();
// }

// class _PopupWidgetIState extends State<PopupWidgetI>
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
//   String username;
//   getusername(String name) {
//     username = name;
//   }

//   bool existUsername;

//   @override
//   Widget build(BuildContext context) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SingleChildScrollView(
//       child: Form(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               localizations.t("partnersReques.messageDialogAccept") +
//                   widget.name,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: 'Sans',
//                 fontSize: 16.0,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 15.0),
//             Text(
//               localizations.t("partnersReques.description") + widget.name,
//               style: TextStyle(color: Colors.white, fontSize: 12.0),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10.0),
//             ElevatedButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50.0),
//               ),
//               color: Colors.grey[800],
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 "Ok",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'SansRegularlight',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
