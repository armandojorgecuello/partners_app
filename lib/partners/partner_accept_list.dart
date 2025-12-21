// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:honeyiou/src/models/partner_model.dart';
// import 'package:honeyiou/src/providers/partner_provider.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class PartnersAccepted extends StatefulWidget {
//   final String previewPage;

//   const PartnersAccepted({Key key, this.previewPage}) : super(key: key);
//   @override
//   _PartnersAcceptedState createState() => _PartnersAcceptedState();
// }

// class _PartnersAcceptedState extends State<PartnersAccepted>
//     with TickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool delete = false;
//   AnimationController _controller;
//   Animation<double> _animation;
//   Animation<Offset> _offsetFloatButtom;
//   Animation<Offset> _offsetFloatLeading;
//   Animation<Offset> _offsetFloatProflePicture;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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

//     _offsetFloatLeading = Tween<Offset>(
//       begin: Offset(1.0, 0.0),
//       end: Offset.zero,
//     ).animate(_controller);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     var partnerAccepted = PartnerProvider(uid: user).test();

//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: _appBar(localizations),
//         backgroundColor: Color(0xff282828),
//         body: Stack(
//           children: <Widget>[
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.9,
//               width: MediaQuery.of(context).size.width,
//               child: StreamBuilder<List<PartnerList>>(
//                 stream: partnerAccepted,
//                 builder: (context, snapshotPartnerAccep) {
//                   if (snapshotPartnerAccep.connectionState ==
//                       ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshotPartnerAccep.connectionState ==
//                       ConnectionState.active) {
//                     if (snapshotPartnerAccep.data.length == 0) {
//                       return Column(
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.4,
//                           ),
//                           Center(
//                             child: FadeTransition(
//                               opacity: _animation,
//                               child: Text(
//                                 localizations.t(
//                                   'partnersAccepted.messageEmptyList',
//                                 ),
//                                 // "",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12.0,
//                                   fontFamily: 'SansLightItalic',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     } else {
//                       TextStyle style = TextStyle(
//                         color: Colors.white,
//                         fontSize: 12.0,
//                         fontFamily: 'SansRegularlight',
//                       );
//                       TextStyle styleName = TextStyle(
//                         color: Colors.white,
//                         fontSize: 12.0,
//                         fontFamily: 'SansSemiBold',
//                       );
//                       return SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * 0.9,
//                         child: ListView.builder(
//                           itemCount: snapshotPartnerAccep.data.length,
//                           itemBuilder: (_, int index) {
//                             var data = snapshotPartnerAccep.data() as Map<String,dynamic>[index];
//                             if (data.uid == user) {
//                               var dataPartner = PartnerProvider()
//                                   .partnerAcceptedData('${data.uidPartner}');
//                               return StreamBuilder<PartnerListData>(
//                                 stream: dataPartner,
//                                 builder: (_, snapshot) {
//                                   var partnerData = snapshot.data;
//                                   if (snapshot.data == null) {
//                                     return Container(
//                                       child: Center(
//                                         child: CircularProgressIndicator(),
//                                       ),
//                                     );
//                                   }
//                                   return FadeTransition(
//                                     opacity: _animation,
//                                     child: Slidable(
//                                       delegate: SlidableDrawerDelegate(),
//                                       secondaryActions: <Widget>[
//                                         IconSlideAction(
//                                           caption: localizations.t(
//                                             'partnersAccepted.deleteButtom',
//                                           ),
//                                           color: Colors.red,
//                                           icon: Icons.delete,
//                                           onTap: () {
//                                             deletePartner(
//                                               '${data.uidPartner}',
//                                               localizations,
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                       child: Container(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                             0.1,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                           color: Color(0xff393939),
//                                           border: Border(
//                                             bottom: BorderSide(
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             SinglePartner.uid = data.uid;
//                                             SinglePartner.uidPartner =
//                                                 data.uidPartner;
//                                             Navigator.of(
//                                               context,
//                                             ).pushNamed('new_task');
//                                           },
//                                           child: Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceAround,
//                                             children: [
//                                               partnerData.photoUrl != null
//                                                   ? CircleAvatarWidget(
//                                                     radius: 25.0,
//                                                     imageUrl:
//                                                         partnerData.photoUrl,
//                                                   )
//                                                   : CircleAvatar(
//                                                     backgroundImage: AssetImage(
//                                                       "assets/image/no_image.png",
//                                                     ),
//                                                     radius: 25,
//                                                   ),
//                                               Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: <Widget>[
//                                                   SizedBox(height: 5.0),
//                                                   SizedBox(
//                                                     width:
//                                                         MediaQuery.of(
//                                                           context,
//                                                         ).size.width *
//                                                         0.5,
//                                                     height: 20.0,
//                                                     child: Text(
//                                                       partnerData.name +
//                                                               ' ' +
//                                                               partnerData
//                                                                   .phoneNumber ??
//                                                           'N/A',
//                                                       style: styleName,
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 5.0),
//                                                   Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: <Widget>[
//                                                       Text(
//                                                         localizations.t(
//                                                               'partnersAccepted.preferences',
//                                                             ) +
//                                                             ': ',
//                                                         style: TextStyle(
//                                                           fontFamily: "Sans",
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 10.0,
//                                                           color: Colors.white,
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width:
//                                                             MediaQuery.of(
//                                                               context,
//                                                             ).size.width *
//                                                             0.32,
//                                                         child:
//                                                             partnerData.preferences !=
//                                                                     ""
//                                                                 ? Text(
//                                                                   partnerData
//                                                                       .preferences,
//                                                                   style: style,
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                 )
//                                                                 : Text(
//                                                                   localizations.t(
//                                                                     "partnersAccepted.textEmptyPreferences",
//                                                                   ),
//                                                                   style: TextStyle(
//                                                                     fontFamily:
//                                                                         "SansLightItalic",
//                                                                     fontSize:
//                                                                         10.0,
//                                                                     color:
//                                                                         Colors
//                                                                             .white,
//                                                                   ),
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                 ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                               trailing(localizations),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 // }
//                               );
//                             } else if (data.uidPartner == user) {
//                               var dataPartner = PartnerProvider()
//                                   .partnerAcceptedData('${data.uid}');
//                               return StreamBuilder<PartnerListData>(
//                                 stream: dataPartner,
//                                 builder: (_, snapshot) {
//                                   print(snapshot.data);
//                                   var partnerData = snapshot.data;
//                                   return FadeTransition(
//                                     opacity: _animation,
//                                     child: Slidable(
//                                       delegate: SlidableDrawerDelegate(),
//                                       secondaryActions: <Widget>[
//                                         IconSlideAction(
//                                           caption: localizations.t(
//                                             'partnersAccepted.deleteButtom',
//                                           ),
//                                           color: Colors.red,
//                                           icon: Icons.delete,
//                                           onTap: () {
//                                             deletePartner(
//                                               '${data.uidPartner}',
//                                               localizations,
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                       child: Container(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                             0.1,
//                                         decoration: BoxDecoration(
//                                           color: Color(0xff393939),
//                                           border: Border(
//                                             bottom: BorderSide(
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ),
//                                         child: ListTile(
//                                           onTap: () {
//                                             SinglePartner.uid = data.uidPartner;
//                                             SinglePartner.uidPartner = data.uid;
//                                             Navigator.of(
//                                               context,
//                                             ).pushNamed('new_task');
//                                           },
//                                           leading: CircleAvatarWidget(
//                                             radius: 25.0,
//                                             imageUrl: partnerData.photoUrl,
//                                           ),
//                                           title: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: <Widget>[
//                                               SizedBox(height: 5.0),
//                                               Text(
//                                                 partnerData.name +
//                                                         ' ' +
//                                                         partnerData
//                                                             .phoneNumber ??
//                                                     'N/A',
//                                                 style: styleName,
//                                               ),
//                                               SizedBox(height: 5.0),
//                                               Row(
//                                                 children: <Widget>[
//                                                   Text(
//                                                     localizations.t(
//                                                           'partnersAccepted.preferences',
//                                                         ) +
//                                                         ': ',
//                                                     style: style,
//                                                   ),
//                                                   SizedBox(
//                                                     width:
//                                                         MediaQuery.of(
//                                                           context,
//                                                         ).size.width *
//                                                         0.32,
//                                                     child: Text(
//                                                       partnerData.preferences ??
//                                                           'N/A',
//                                                       style: style,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           trailing: trailing(localizations),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             } else {
//                               return Container();
//                             }
//                           },
//                         ),
//                       );
//                     }
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ),
//             Positioned(
//               left: 10.0,
//               right: 10.0,
//               bottom: MediaQuery.of(context).size.height * 0.04,
//               child: FadeTransition(
//                 opacity: _animation,
//                 child: _bottom(context, localizations),
//               ),
//             ),
//           ],
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
//           Text(localizations.t('partnersAccepted.title')),
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

//   Widget trailing(localizations) {
//     return Container(
//       child: ElevatedButton(
//         color: Color.fromRGBO(135, 135, 135, 0.1),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//         onPressed: () {
//           setState(() {
//             delete = true;
//           });
//         },
//         child: Text(
//           localizations.t('partnersAccepted.acceptedButtom'),
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'SansRegularlight',
//             fontSize: 14.0,
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool> deletePartner(String partnerUid, localizations) async {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return await showGeneralDialog<bool>(
//       context: context,
//       barrierDismissible: false,
//       transitionDuration: Duration(milliseconds: 200),
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
//               ),
//               backgroundColor: Colors.grey[800],
//               title: Center(
//                 child: Text(
//                   localizations.t('partnersAccepted.textDelete'),
//                   // '',
//                   style: TextStyle(
//                     fontSize: 14.0,
//                     fontFamily: 'Sans',
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               content: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: Text(
//                         localizations.t('partnersAccepted.textDelete2'),
//                         // '.'
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 14.0,
//                           fontFamily: 'SansRegular',
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30.0),
//                     Text(
//                       localizations.t('partnersAccepted.textDelete3'),
//                       // '',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.0,
//                         fontFamily: 'SansRegular',
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           color: Colors.red,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                           child: Text(
//                             localizations.t('partnersAccepted.continueButtom'),
//                             // 'Continue',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14.0,
//                               fontFamily: 'SansRegular',
//                             ),
//                           ),
//                           onPressed: () {
//                             //ELIMINAR EL PARTNER JUTO CON LAS TAREAS ASIGNADAS A DICHO PARTNER Y LAS QUE NOS HA ASIGNADO A NOSOTROSO
//                             PartnerProvider().deletePartnerAccepted(
//                               user,
//                               partnerUid,
//                             );
//                             PartnerProvider().deleteTasksPartner(
//                               user,
//                               partnerUid,
//                             );
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       pageBuilder: (context, animation1, animation2) {
//         return Sizedbox();
//       },
//     );
//   }

//   Widget _bottom(context, localizations) {
//     return ElevatedButton(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
//       elevation: 0.0,
//       color: const Color(0xff7A1418),
//       padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       child: Container(
//         child: Text(
//           localizations.t('partnersAccepted.addPartner'),
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 15.0,
//             fontFamily: 'SansRegularlight',
//           ),
//         ),
//       ),
//       onPressed: () {
//         Navigator.pushNamed(context, "add_partners");
//       },
//     );
//   }
// }
