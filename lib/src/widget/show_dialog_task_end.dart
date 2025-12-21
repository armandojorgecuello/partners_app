// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demoji/demoji.dart';
// import 'package:flutter/material.dart';
// import 'package:honey_iou_updated/src/providers/tasks_provider.dart';
// import 'package:honey_iou_updated/src/providers/usuarios_provider.dart';

// import 'background_image.dart';
// import 'circle_avatar_widget.dart';

// class ShowDialogBoxFinish {
//   String? review_description;

//   Animation<Offset>? _offsetFloatTitle;
//   Animation<Offset>? _offsetFloatProflePicture;

//   animation(controller) {
//     _offsetFloatTitle = Tween<Offset>(
//       begin: Offset(0.0, -2),
//       end: Offset(0.0, 0),
//     ).animate(controller);
//     controller.forward();

//     _offsetFloatProflePicture = Tween<Offset>(
//       begin: Offset(-1, 0.0),
//       end: Offset(0.0, 0.0),
//     ).animate(controller);
//     controller.forward();
//   }

//   getReward(reward) {
//     review_description = reward;
//   }

//   showDialogTaskFinished(
//     String reviewValue,
//     String reviewDescription,
//     String status,
//     String taskDate,
//     String taskTitle,
//     String uidTask,
//     String uidReceiver,
//     localizations,
//     context,
//   ) {
//     final formKey = GlobalKey<FormState>();
//     return showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child:
//                 status != "reviewed"
//                     ? AlertDialog(
//                       backgroundColor: Color(0xff282828),
//                       // backgroundColor: ,f
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       content: Form(
//                         key: formKey,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Row(
//                               children: [
//                                 StreamBuilder(
//                                   stream:
//                                       FirebaseFirestore.instance
//                                           .collection("users")
//                                           .doc(uidReceiver)
//                                           .collection(uidReceiver)
//                                           .doc(uidReceiver)
//                                           .snapshots(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Container(
//                                         child: Center(
//                                           child: CircularProgressIndicator(),
//                                         ),
//                                       );
//                                     }
//                                     return Container(
//                                       child: CircleAvatarWidget(
//                                         radius: 27.0,
//                                         imageUrl:
//                                             snapshot.data?['photo_url'] ??
//                                             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.calendar_today,
//                                             color: Colors.white,
//                                             size: 12,
//                                           ),
//                                           SizedBox(width: 10.0),
//                                           Container(
//                                             child: Text(
//                                               taskDate,
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontFamily: 'SansRegularLight',
//                                                 fontSize: 12.0,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Container(
//                                         child: Text(
//                                           taskTitle,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: 'Sans',
//                                             fontSize: 12.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(width: 10.0),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 child: Text(
//                                   localizations.t(
//                                     'home_page.textDialogTaskCompleted',
//                                   ),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'Sans',
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextFormField(
//                                 maxLines: 3,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Review is empty";
//                                   }
//                                   return null;
//                                 },
//                                 style: TextStyle(color: Colors.white),
//                                 onChanged: (String rewardDesc) {
//                                   getReward(rewardDesc);
//                                 },
//                                 decoration: InputDecoration(
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               localizations.t("home_page.askEndTaskreview"),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Sans',
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                             SizedBox(height: 20.0),
//                             Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Container(
//                                     height: 33.0,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(50.0),
//                                       color: Color(0xffBF2328),
//                                     ),
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         if (formKey.currentState!.validate()) {
//                                           TasksListProvider().updateStatus(
//                                             uidTask,
//                                             'reviewed',
//                                           );
//                                           TasksListProvider().reviewTask(
//                                             uidTask,
//                                             'like',
//                                             review_description!,
//                                           );
//                                           Navigator.of(context).pop();
//                                         }
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             localizations.t(
//                                               'home_page.buttonTaskCompletedDialogYes',
//                                             ),
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontFamily: 'SansRegularlight',
//                                             ),
//                                           ),
//                                           SizedBox(width: 10.0),
//                                           Text(Demoji.grin),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 10.0),
//                                   Container(
//                                     height: 33.0,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(50.0),
//                                       color: Color(0xffBF2328),
//                                     ),
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         if (formKey.currentState!.validate()) {
//                                           TasksListProvider().updateStatus(
//                                             uidTask,
//                                             'reviewed',
//                                           );
//                                           TasksListProvider().reviewTask(
//                                             uidTask,
//                                             'unlike',
//                                             review_description!,
//                                           );
//                                           Navigator.of(context).pop();
//                                         }
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             localizations.t(
//                                               'home_page.buttonTaskCompletedDialogNo',
//                                             ),
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontFamily: 'SansRegularlight',
//                                             ),
//                                           ),
//                                           SizedBox(width: 10.0),
//                                           Text(Demoji.slightly_frowning_face),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                     : AlertDialog(
//                       backgroundColor: Color(0xff282828),
//                       // backgroundColor: ,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       content: Form(
//                         key: formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Row(
//                               children: [
//                                 StreamBuilder(
//                                   stream:
//                                       FirebaseFirestore.instance
//                                           .collection("users")
//                                           .doc(uidReceiver)
//                                           .collection(uidReceiver)
//                                           .doc(uidReceiver)
//                                           .snapshots(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Container(
//                                         child: Center(
//                                           child: CircularProgressIndicator(),
//                                         ),
//                                       );
//                                     }
//                                     return Container(
//                                       child: CircleAvatarWidget(
//                                         radius: 27.0,
//                                         imageUrl:
//                                             snapshot.data?['photo_url'] ??
//                                             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10.0,
//                                     vertical: 10.0,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.calendar_today,
//                                             color: Colors.white,
//                                             size: 12,
//                                           ),
//                                           SizedBox(width: 10.0),
//                                           Container(
//                                             child: Text(
//                                               taskDate,
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontFamily: 'SansRegularLight',
//                                                 fontSize: 12.0,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Container(
//                                         child: Text(
//                                           taskTitle,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: 'Sans',
//                                             fontSize: 12.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(width: 20.0),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.4,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         localizations.t(
//                                           'home_page.reviewDescription',
//                                         ),
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'Sans',
//                                           fontSize: 12.0,
//                                         ),
//                                       ),
//                                       SizedBox(height: 5.0),
//                                       Text(
//                                         reviewDescription.isNotEmpty
//                                             ? reviewDescription
//                                             : localizations.t(
//                                               'home_page.commentsEmpty',
//                                             ),
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'SansRegularLight',
//                                           fontSize: 12.0,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 reviewValue != "like"
//                                     ? Text(
//                                       Demoji.slightly_frowning_face,
//                                       style: TextStyle(
//                                         fontSize: 60.0,
//                                         color: Colors.yellow,
//                                       ),
//                                     )
//                                     : Text(
//                                       Demoji.grin,
//                                       style: TextStyle(
//                                         fontSize: 60.0,
//                                         color: Colors.yellow,
//                                       ),
//                                     ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {return SizedBox();},
//     );
//   }

//   showDialog(
//     String uidTask,
//     localizations,
//     context,
//     String taskRewardImg,
//     String senderUid,
//   ) {
//     final user = UsuarioProvider();
//     return showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child:
//             // AlertDialog(
//             // backgroundColor: Color(0xff282828),
//             // shape: RoundedRectangleBorder(
//             // borderRadius: BorderRadius.circular(20.0)
//             // ),
//             // content:
//             Padding(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.3,
//               ),
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.35,
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10.0),
//                         child: RewardImageBackground(rewardUrl: taskRewardImg),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           SizedBox(height: 10.0),
//                           Center(
//                             child: StreamBuilder(
//                               stream: user.getPartnerData(senderUid),
//                               builder: (_, snapshot) {
//                                 return CircleAvatarWidget(
//                                   imageUrl: snapshot.data() as Map<String,dynamic>["photo_url"],
//                                   radius: 30.0,
//                                 );
//                                 //
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 10.0),
//                           Center(
//                             child: Container(
//                               child: Material(
//                                 type: MaterialType.transparency,
//                                 child: Text(
//                                   localizations.t(
//                                     'chatPage.confirmCompletedTask',
//                                   ),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'Sans',
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10.0),
//                           SizedBox(height: 10.0),
//                           Center(
//                             child: Container(
//                               child: Material(
//                                 type: MaterialType.transparency,
//                                 child: Text(
//                                   localizations.t(
//                                     'chatPage.fimishTextDetailDesc',
//                                   ),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'SansRegularlight',
//                                     fontSize: 12.0,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20.0),
//                           SizedBox(height: 20.0),
//                           Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                   height: 33.0,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                     borderRadius: BorderRadius.circular(50.0),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       // TasksList().updateStatus(uidTask, 'completed');
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text(
//                                       localizations.t('chatPage.rejectButton'),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: 'SansRegularlight',
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10.0),
//                                 Container(
//                                   height: 33.0,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50.0),
//                                     color: Color(0xffBF2328),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       TasksListProvider().updateStatus(
//                                         uidTask,
//                                         'completed',
//                                       );
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text(
//                                       localizations.t('chatPage.acceptButtom'),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: 'SansRegularlight',
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // ),
//           // )
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       // barrierColor: Color(0xff282828),
//       pageBuilder: (context, animation1, animation2) {return SizedBox();},
//     );
//   }

//   showDialogAfterPayment(
//     String uidTask,
//     localizations,
//     context,
//     onPressed,
//     String nameSender,
//     String senderUid,
//     String receiverUid,
//     String taskId,
//   ) {
//     final user = UsuarioProvider();
//     String nameSender0;
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
//               content: StreamBuilder(
//                 stream: user.getPartnerData(senderUid),
//                 builder: (context, snapshot) {
//                   return PopUpElementAfterPayment(
//                     nameSender: snapshot.data() as Map<String,dynamic>["name"],
//                     imageSender: snapshot.data() as Map<String,dynamic>["photo_url"],
//                     receiveruid: receiverUid,
//                     senderUid: senderUid,
//                     taskId: taskId,
//                   );
//                 },
//               ),
//             ),
//           ),
//           //  ),
//           // )
//           // ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: false,
//       barrierLabel: '',
//       context: context,
//       // barrierColor: Color(0xff282828),
//       pageBuilder: (context, animation1, animation2) {return SizedBox();},
//     ).whenComplete(() => onPressed);
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
//       pageBuilder: (context, animation1, animation2) {return SizedBox();},
//     );
//   }
// }
