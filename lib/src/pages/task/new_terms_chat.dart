// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/widget/show_dialog_task_end.dart';

// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:honeyiou/src/pages/task/update_task.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/src/widget/new_terms_element.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/src/models/task_model.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';
// import 'package:provider/provider.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _controller = TextEditingController();
//   String _inputDateTime;
//   var textStyleTask = TextStyle(
//     color: Color(0xffFFFFFF),
//     fontFamily: 'Sans',
//     fontSize: 14.0,
//   );
//   var textStyleStatus = TextStyle(
//     color: Color(0xffFFFFFF),
//     fontFamily: 'SansLightItalic',
//     fontSize: 12.0,
//     fontStyle: FontStyle.italic,
//   );
//   var textStyleReward = TextStyle(
//     color: Color(0xffFFFFFF),
//     fontFamily: 'SansSemiBold',
//     fontSize: 12.0,
//   );
//   var textStyle = TextStyle(
//     color: Color(0xffFFFFFF),
//     fontFamily: 'SansLightItalic',
//     fontSize: 12.0,
//   );

//   String _selectedQuery;
//   String message;

//   getMessage(message) {
//     this.message = message;
//   }

//   static File image;
//   static Future<File> imageFile;
//   String taskTitle;
//   String time;
//   String rewardDescription;
//   DateTime deliveryTime;

//   getTask(titleTask) {
//     taskTitle = titleTask;
//   }

//   getReward(reward) {
//     rewardDescription = reward;
//   }

//   DocumentSnapshot docTaskSelect;

//   AnimationController _controllerAnimation;
//   Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     image = null;
//     _controllerAnimation = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _animation = CurvedAnimation(
//       parent: _controllerAnimation,
//       curve: Curves.easeIn,
//     );
//     _controllerAnimation.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _controllerAnimation.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     // var task = SingleTask.docSnapshot;
//     final pref = UserPreferences();
//     String taskId = ModalRoute.of(context).settings.arguments;
//     String taskID;
//     String uid = pref.uid;
//     final taskProvider = Provider.of<TasksListProvider>(context);
//     @override
//     String user = pref.uid;
//     if (taskProvider.idTask != null) {
//       taskID = taskProvider.idTask;
//     } else {
//       setState(() {
//         taskID = taskId;
//       });
//     }
//     var getselectedTask = TasksListProvider(uidTask: taskID).getSelectedTask;
//     setState(() {});
//     TasksListProvider(
//       uidTask: taskID,
//     ).actualWindowandIdTask(user, 'chat_page', taskID);
//     return SafeArea(
//       child: Scaffold(
//         appBar: appbar(localizations, user),
//         backgroundColor: Color(0xff282828),
//         body: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.9,
//           child: StreamBuilder<DocumentSnapshot>(
//             stream: getselectedTask,
//             builder: (context, snapshot) {
//               docTaskSelect = snapshot.data;
//               if (docTaskSelect.data() as Map<String,dynamic>['sender_uid'] == user) {
//                 if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'not_started' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'open' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'paid_upfront' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'started' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'rejected' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'pending_receiver') {
//                   return SizedBox(
//                     height: MediaQuery.of(context).size.height,
//                     child: Stack(
//                       children: <Widget>[
//                         RewardImageBackgroundChat(
//                           rewardUrl: docTaskSelect.data() as Map<String,dynamic>['reward_img_url'],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Column(
//                               children: <Widget>[
//                                 Row(
//                                   children: <Widget>[
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                           0.12,
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           0.28,
//                                       // color: Colors.white,
//                                       child: taskSelected(),
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           0.7,
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                           0.12,
//                                       // height: 110.0,
//                                       // color: Colors.white,
//                                       child: titleTask(localizations),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(color: Colors.white),
//                                 _crearDropMenu(localizations),
//                                 Divider(color: Colors.white),
//                               ],
//                             ),
//                             chat(),
//                             SizedBox(
//                               height:
//                                   MediaQuery.of(context).size.height * 0.039,
//                             ),
//                             buildMessage(user, localizations),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'completed') {
//                   return SizedBox(
//                     height: MediaQuery.of(context).size.height,
//                     child: Stack(
//                       children: <Widget>[
//                         RewardImageBackgroundChat(
//                           rewardUrl: docTaskSelect.data() as Map<String,dynamic>['reward_img_url'],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Column(
//                               children: <Widget>[
//                                 Row(
//                                   children: <Widget>[
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                           0.12,
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           0.28,
//                                       // color: Colors.white,
//                                       child: taskSelected(),
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           0.7,
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                           0.12,
//                                       // height: 110.0,
//                                       // color: Colors.white,
//                                       child: titleTask(localizations),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(color: Colors.white),
//                                 _crearDropMenu(localizations),
//                                 Divider(color: Colors.white),
//                               ],
//                             ),
//                             chat(),
//                             SizedBox(
//                               height:
//                                   MediaQuery.of(context).size.height * 0.039,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               } else if (docTaskSelect.data() as Map<String,dynamic>['receiver_uid'] == user) {
//                 if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'not_started' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'started' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'open' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'paid_upfront' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'pending_receiver' ||
//                     docTaskSelect.data() as Map<String,dynamic>['status'] == 'rejected') {
//                   return SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.9,
//                     child: Stack(
//                       children: <Widget>[
//                         RewardImageBackgroundChat(
//                           rewardUrl: docTaskSelect.data() as Map<String,dynamic>['reward_img_url'],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             SingleChildScrollView(
//                               child: Column(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                             0.12,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                             0.28,
//                                         // color: Colors.white,
//                                         child: taskSelected(),
//                                       ),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                             0.7,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                             0.12,
//                                         // height: 110.0,
//                                         // color: Colors.white,
//                                         child: titleTask(localizations),
//                                       ),
//                                     ],
//                                   ),
//                                   Divider(color: Colors.white),
//                                   _crearDropMenu(localizations),
//                                   Divider(color: Colors.white),
//                                 ],
//                               ),
//                             ),
//                             chat(),
//                             SizedBox(
//                               height:
//                                   MediaQuery.of(context).size.height * 0.039,
//                             ),
//                             buildMessage(user, localizations),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'completed') {
//                   return SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.9,
//                     child: Stack(
//                       children: <Widget>[
//                         RewardImageBackgroundChat(
//                           rewardUrl: docTaskSelect.data() as Map<String,dynamic>['reward_img_url'],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             SingleChildScrollView(
//                               child: Column(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                             0.12,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                             0.28,
//                                         // color: Colors.white,
//                                         child: taskSelected(),
//                                       ),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                             0.7,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                             0.12,
//                                         // height: 110.0,
//                                         // color: Colors.white,
//                                         child: titleTask(localizations),
//                                       ),
//                                     ],
//                                   ),
//                                   Divider(color: Colors.white),
//                                   _crearDropMenu(localizations),
//                                   Divider(color: Colors.white),
//                                 ],
//                               ),
//                             ),
//                             chat(),
//                             SizedBox(
//                               height:
//                                   MediaQuery.of(context).size.height * 0.039,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               } else {
//                 return Container();
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget chat() {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return Flexible(
//       fit: FlexFit.loose,
//       flex: 2,
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 0.56,
//         width: MediaQuery.of(context).size.width * 0.95,
//         child: StreamBuilder<QuerySnapshot>(
//           stream:
//               FirebaseFirestore.instance
//                   .collection('task_chatrooms')
//                   .doc(docTaskSelect.docID)
//                   .collection(docTaskSelect.docID)
//                   .orderBy('date_time')
//                   .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Container();
//             } else {
//               return Stack(
//                 children: <Widget>[
//                   ListView(
//                     reverse: true,
//                     children: <Widget>[
//                       Column(
//                         children:
//                             snapshot.data.docs
//                                 .map<Widget>(
//                                   (messagesnap) =>
//                                       chatMessage(messagesnap, context),
//                                 )
//                                 .toList(),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildMessage(user, localizations) {
//     return Form(
//       key: _formKey,
//       child: Container(
//         decoration: BoxDecoration(color: Color(0xff222222)),
//         height: 60.0,
//         width: MediaQuery.of(context).size.width,
//         child: FadeTransition(
//           opacity: _animation,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.camera_alt, color: Colors.grey),
//                 onPressed: () {},
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 0.3),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.0),
//                   color: Color(0xff151515),
//                 ),
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: TextFormField(
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "Message is empty";
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: EdgeInsets.only(left: 10.0),
//                     hintText: localizations.t('chatPage.newTermsText'),
//                     hintStyle: TextStyle(color: Color(0xff5a5a5a)),
//                     border: UnderlineInputBorder(borderSide: BorderSide.none),
//                   ),
//                   onChanged: (String message) {
//                     getMessage(message);
//                   },
//                   controller: _controller,
//                   cursorColor: Colors.grey,
//                   style: TextStyle(color: Color(0xffFFFFFF)),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xffBF2328),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: ElevatedButton(
//                   child: Text(
//                     localizations.t('chatPage.sentButtom'),
//                     style: TextStyle(
//                       color: Color(0xffFFFFFF),
//                       fontFamily: 'SansRegularlight',
//                     ),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       if (docTaskSelect.data() as Map<String,dynamic>['sender_uid'] == user) {
//                         TasksListProvider().sendMessage(
//                           docTaskSelect.data() as Map<String,dynamic>['sender_uid'],
//                           message,
//                           docTaskSelect.data() as Map<String,dynamic>['receiver_uid'],
//                           docTaskSelect.docID,
//                         );
//                         setState(() {
//                           _controller.text = '';
//                         });
//                       } else if (docTaskSelect.data() as Map<String,dynamic>['receiver_uid'] == user) {
//                         TasksListProvider().sendMessage(
//                           docTaskSelect.data() as Map<String,dynamic>['receiver_uid'],
//                           message,
//                           docTaskSelect.data() as Map<String,dynamic>['sender_uid'],
//                           docTaskSelect.docID,
//                         );
//                         setState(() {
//                           _controller.text = '';
//                         });
//                       }
//                     } else {}
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget appbar(localizations, user) {
//     return AppBar(
//       title: Row(
//         children: [
//           GestureDetector(
//             child: SizedBox(
//               height: 40.0,
//               width: 100.0,
//               child: Row(
//                 children: [
//                   Icon(Icons.arrow_back_ios, color: Colors.white),
//                   Text(
//                     localizations.t('chatPage.back'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () {
//               // Navigator.of(context).popAndPushNamed('home_page');
//               Navigator.of(context).pop();
//             },
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.1),
//           Text(
//             "Honey IOU",
//             style: TextStyle(fontFamily: "Quick", fontSize: 22.0),
//           ),
//         ],
//       ),
//       centerTitle: true,
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color(0xff7a1418),
//       // backgroundColor: Colors.red,
//     );
//   }

//   Widget chatMessage(DocumentSnapshot messagesnap, context) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     bool isMe = messagesnap.data() as Map<String,dynamic>['uid_sender'] == user;
//     Timestamp timeStamp = messagesnap.data() as Map<String,dynamic>['date_time'];
//     var uidReceiver = messagesnap.data() as Map<String,dynamic>['uid_receiver'];
//     var uidSender = messagesnap.data() as Map<String,dynamic>['uid_sender'];
//     DateTime date = timeStamp.toDate();
//     String formattedDate;
//     var formatter = DateFormat("HH':'mm aaa");
//     formattedDate = formatter.format(date);
//     print(formattedDate);
//     // print(uidReceiver);
//     // print(uidSender);
//     return isMe
//         ? SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10.0, left: .0, bottom: 5.0),
//             child: Container(
//               child: Flex(
//                 direction: Axis.vertical,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         formattedDate,
//                         style: TextStyle(color: Colors.white, fontSize: 12.0),
//                       ),
//                       SizedBox(width: 10.0),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.77,
//                         decoration: BoxDecoration(
//                           color: Color(0xff878787),
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(15.0),
//                             bottomRight: Radius.circular(15.0),
//                             topLeft: Radius.circular(15.0),
//                           ),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 5.0,
//                           vertical: 15.0,
//                         ),
//                         child: Text(
//                           messagesnap.data() as Map<String,dynamic>['message'] ?? '',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//         : SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 5.0),
//             child: Container(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   StreamBuilder<DocumentSnapshot>(
//                     stream:
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(uidSender)
//                             .collection(uidSender)
//                             .doc(uidSender)
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       return CircleAvatarWidget(
//                         radius: 15.0,
//                         imageUrl:
//                             snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                       );
//                     },
//                   ),
//                   SizedBox(width: 5.0),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.66,
//                     decoration: BoxDecoration(
//                       color: Color(0xff393939),
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(15.0),
//                         bottomRight: Radius.circular(15.0),
//                         topRight: Radius.circular(15.0),
//                       ),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 5.0,
//                       vertical: 15.0,
//                     ),
//                     child: Text(
//                       messagesnap.data() as Map<String,dynamic>['message'] ?? '',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(width: 5.0),
//                   Text(
//                     formattedDate,
//                     style: TextStyle(color: Colors.grey[300], fontSize: 12.0),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//   }

//   Widget taskSelected() {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     if (docTaskSelect.data() as Map<String,dynamic>['sender_uid'] == user) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 5.0),
//         child: SizedBox(
//           height: 100.0,
//           width: MediaQuery.of(context).size.width * 0.25,
//           // color: Colors.red,
//           child: Stack(
//             children: <Widget>[
//               Positioned(
//                 left: 10.0,
//                 child: StreamBuilder(
//                   stream:
//                       FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['sender_uid'])
//                           .collection(docTaskSelect.data() as Map<String,dynamic>['sender_uid'])
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['sender_uid'])
//                           .snapshots(),
//                   builder: (context, snapshot) {
//                     return FadeTransition(
//                       opacity: _animation,
//                       child: CircleAvatarWidget(
//                         radius: 25.0,
//                         imageUrl:
//                             snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                 // top: 5.0,
//                 left: 52.0,
//                 // bottom: 0.0,
//                 child: StreamBuilder(
//                   stream:
//                       FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['receiver_uid'])
//                           .collection(docTaskSelect.data() as Map<String,dynamic>['receiver_uid'])
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['receiver_uid'])
//                           .snapshots(),
//                   builder: (context, snapshot) {
//                     return FadeTransition(
//                       opacity: _animation,
//                       child: CircleAvatarWidget(
//                         radius: 25.0,
//                         imageUrl:
//                             snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.only(top: 5.0),
//         child: SizedBox(
//           height: 90.0,
//           width: MediaQuery.of(context).size.width * 0.25,
//           child: Stack(
//             children: <Widget>[
//               Positioned(
//                 left: 5.0,
//                 child: StreamBuilder(
//                   stream:
//                       FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['sender_uid'])
//                           .collection(docTaskSelect.data() as Map<String,dynamic>['sender_uid'])
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['sender_uid'])
//                           .snapshots(),
//                   builder: (context, snapshot) {
//                     return FadeTransition(
//                       opacity: _animation,
//                       child: CircleAvatarWidget(
//                         radius: 25.0,
//                         imageUrl:
//                             snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                 // top: 5.0,
//                 left: 47.0,
//                 // bottom: 0.0,
//                 child: StreamBuilder(
//                   stream:
//                       FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['receiver_uid'])
//                           .collection(docTaskSelect.data() as Map<String,dynamic>['receiver_uid'])
//                           .doc(docTaskSelect.data() as Map<String,dynamic>['receiver_uid'])
//                           .snapshots(),
//                   builder: (context, snapshot) {
//                     return FadeTransition(
//                       opacity: _animation,
//                       child: CircleAvatarWidget(
//                         radius: 25.0,
//                         imageUrl:
//                             snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }

//   Widget titleTask(localizations) {
//     final taskProvider = Provider.of<TasksListProvider>(context);
//     final pref = UserPreferences();
//     String user = pref.uid;
//     // Si el receiver es igual al usario logeado y el estado de la tarea es 'open' o 'pending receiver'
//     if (docTaskSelect.data() as Map<String,dynamic>['receiver_uid'] == user) {
//       if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'open' ||
//           docTaskSelect.data() as Map<String,dynamic>['status'] == 'paid_upfront') {
//         return ChatItem1(
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           textStyleTask: textStyleTask,
//           status: localizations.t('chatPage.open'),
//           textStyleStatus: textStyleStatus,
//           onPressedShowGeneral: () {
//             _showGeneralDialog(context: context);
//           },
//           textButtonShowGeneral: localizations.t('chatPage.openButtom1'),
//           onPressedStarted: () {
//             TasksListProvider().updateStatus(docTaskSelect.docID, 'started');
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           textStartTask: localizations.t('chatPage.openButtom2'),
//           onPressedReject: () {
//             setState(() {
//               _controllerAnimation.forward();
//             });
//             TasksListProvider().updateStatus(docTaskSelect.docID, 'rejected');
//           },
//           textRejectTask: localizations.t('chatPage.openButtom3'),
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'pending_receiver') {
//         return ChatItem1(
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           status: localizations.t('chatPage.pendingReceiver'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//           onPressedShowGeneral: () {
//             setState(() {
//               _controllerAnimation.forward();
//             });
//             _showGeneralDialog(context: context);
//           },
//           textButtonShowGeneral: localizations.t(
//             'chatPage.pendingReceiverButtom1',
//           ),
//           onPressedStarted: () {
//             TasksListProvider().updateStatus(docTaskSelect.docID, 'started');
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           textStartTask: localizations.t('chatPage.pendingReceiverButtom3'),
//           onPressedReject: () {
//             TasksListProvider().updateStatus(docTaskSelect.docID, 'rejected');
//             _controllerAnimation.forward();
//           },
//           textRejectTask: localizations.t('chatPage.pendingReceiverButtom2'),
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'started') {
//         return ChatItemII(
//           docTaskSelect: docTaskSelect,
//           status: localizations.t('chatPage.started'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//           animation: _animation,
//           onPressedShowGeneral: () {
//             _showGeneralDialog(context: context);
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           textShowGeneral: localizations.t('chatPage.startedButtom2'),
//           onPressedShowDialog: () {
//             final taskProvider = Provider.of<TasksListProvider>(
//               context,
//               listen: false,
//             );
//             String taskId = taskProvider.idTask;
//             final taskID = ModalRoute.of(context).settings.arguments;
//             ShowDialogBoxFinish().showDialog(
//               taskId ?? taskID,
//               localizations,
//               context,
//               taskProvider.rewardImgUrl,
//               taskProvider.senderUid,
//             );
//             setState(() {
//               DocTaskSelected.docSnapshot = docTaskSelect;
//               _controllerAnimation.forward();
//             });
//           },
//           textSecondButton: localizations.t('chatPage.startedButtom1'),
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'rejected') {
//         return ChatItemIII(
//           docTaskSelect: docTaskSelect,
//           buttonTask: () {
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           animation: _animation,
//           status: localizations.t('chatPage.rejected'),
//           textButtonTask: localizations.t('chatPage.rejectedButtom'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'completed') {
//         return ChatItemIII(
//           buttonTask: () {
//             _showGeneralDialog(context: context);
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           status: localizations.t('chatPage.completed'),
//           textButtonTask: localizations.t('chatPage.completedButtom'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//         // Si el receiver es igual al usario logeado y el estado de la tarea es 'rejected'
//       } else {
//         return Container();
//       }
//       // Si el sender es igual al usario logeado y el estado de la tarea es 'started'
//     } else if (docTaskSelect.data() as Map<String,dynamic>['sender_uid'] == user) {
//       if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'started') {
//         return ChatItemIII(
//           buttonTask: () {
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           status: localizations.t('chatPage.started'),
//           textButtonTask: localizations.t('chatPage.startedButtomSender'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//         // Si el sender es igual al usario logeado y el estado de la tarea es 'open' o 'pending receiver' o 'rejected'
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'rejected') {
//         return ChatItemIII(
//           buttonTask: () {
//             DocTaskSelected.docSnapshot = docTaskSelect;
//             Navigator.of(
//               context,
//             ).push(CupertinoPageRoute(builder: (context) => UpdateTaskPage()));
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           status: localizations.t('chatPage.rejected'),
//           textButtonTask: localizations.t('chatPage.rejectedSenderButtom1'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'not_started') {
//         return ChatItemIII(
//           docTaskSelect: docTaskSelect,
//           buttonTask: () {
//             DocTaskSelected.docSnapshot = docTaskSelect;
//             Navigator.of(
//               context,
//             ).push(CupertinoPageRoute(builder: (context) => UpdateTaskPage()));
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           animation: _animation,
//           status: localizations.t('chatPage.notStarted'),
//           textButtonTask: localizations.t('chatPage.notStartedButtom1'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'open' ||
//           docTaskSelect.data() as Map<String,dynamic>['status'] == 'paid_upfront') {
//         return ChatItemIII(
//           buttonTask: () {
//             DocTaskSelected.docSnapshot = docTaskSelect;
//             Navigator.of(
//               context,
//             ).push(CupertinoPageRoute(builder: (context) => UpdateTaskPage()));
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           status: localizations.t('chatPage.open'),
//           textButtonTask: localizations.t('chatPage.openButtom1'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'pending_receiver') {
//         return ChatItemIII(
//           buttonTask: () {
//             DocTaskSelected.docSnapshot = docTaskSelect;
//             Navigator.of(
//               context,
//             ).push(CupertinoPageRoute(builder: (context) => UpdateTaskPage()));
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           status: localizations.t('chatPage.pendingReceiver'),
//           textButtonTask: localizations.t(
//             'chatPage.pendingReceiverButtomSender',
//           ),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//       } else if (docTaskSelect.data() as Map<String,dynamic>['status'] == 'completed') {
//         return ChatItemIII(
//           buttonTask: () {
//             _showGeneralDialog(context: context);
//             setState(() {
//               _controllerAnimation.forward();
//             });
//           },
//           docTaskSelect: docTaskSelect,
//           animation: _animation,
//           status: localizations.t('chatPage.completed'),
//           textButtonTask: localizations.t('chatPage.completedButtom'),
//           textStyleStatus: textStyleStatus,
//           textStyleTask: textStyleTask,
//         );
//       } else {
//         return Container();
//       }
//     } else {
//       return Container();
//     }
//   }

//   _showGeneralDialog({BuildContext context}) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return showGeneralDialog(
//       context: context,
//       barrierColor: Colors.black12.withOpacity(0.6),
//       barrierDismissible: false,
//       barrierLabel: "Dialog",
//       transitionDuration: Duration(milliseconds: 400),
//       pageBuilder: (_, __, ___) {
//         String formattedDate;
//         if (docTaskSelect.data() as Map<String,dynamic>['delivery_time'] != null) {
//           DateTime dateTime = docTaskSelect.data() as Map<String,dynamic>['delivery_time'].toDate();
//           var formatter = DateFormat("MMM d' at 'HH':'mm aaa");
//           formattedDate = formatter.format(dateTime);
//         } else {
//           formattedDate = localizations.t("home_page.noDate");
//         }
//         return Scaffold(
//           backgroundColor: Color(0xff282828),
//           // backgroundColor: Colors.grey[800],
//           appBar: AppBar(
//             backgroundColor: const Color(0xff7a1418),
//             flexibleSpace: SafeArea(
//               child: Stack(
//                 children: <Widget>[
//                   Positioned(
//                     top: 5.0,
//                     left: 0.0,
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       elevation: 0.0,
//                       color: const Color(0xff7a1418),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.arrow_back_ios, color: Colors.white),
//                           Text(
//                             localizations.t('chatPage.back'),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                       // color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             title: Text('Reward '),
//             centerTitle: true,
//             automaticallyImplyLeading: false,
//           ),
//           body: SafeArea(
//             child: SizedBox.expand(
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(height: 10.0),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         child: Text(
//                           localizations.t('chatPage.taskHint'),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14.0,
//                             fontFamily: 'Sans',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         child: Text(
//                           docTaskSelect.data() as Map<String,dynamic>['title'],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14.0,
//                             fontFamily: 'SansRegularlight',
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5.0),
//                       child: Divider(color: Colors.white),
//                     ),
//                     SizedBox(height: 10.0),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         child: Text(
//                           localizations.t('chatPage.timeLimit'),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14.0,
//                             fontFamily: 'Sans',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         child: Text(
//                           formattedDate,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14.0,
//                             fontFamily: 'SansRegularlight',
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                       child: Divider(color: Colors.white),
//                     ),
//                     SizedBox(height: 10.0),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         child: Text(
//                           localizations.t('chatPage.rewardHint'),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14.0,
//                             fontFamily: 'Sans',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         child: Text(
//                           docTaskSelect.data() as Map<String,dynamic>['reward_description'],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14.0,
//                             fontFamily: 'SansRegularlight',
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                       child: Divider(color: Colors.white),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                       child: Center(
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.4,
//                           width: MediaQuery.of(context).size.width * 09,
//                           child: Card(
//                             color: Color(0xff282828),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child:
//                                 docTaskSelect.data() as Map<String,dynamic>["reward_img_url"] != ""
//                                     ? ClipRRect(
//                                       borderRadius: BorderRadius.circular(20.0),
//                                       child: Image(
//                                         image: NetworkImage(
//                                           docTaskSelect.data() as Map<String,dynamic>['reward_img_url'],
//                                         ),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     )
//                                     : Center(
//                                       child: Text(
//                                         localizations.t(
//                                           "home_page.noImageRewardReceiver",
//                                         ),
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget showimage() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {});
//       },
//       child: Container(child: Image.file(image)),
//     );
//   }

//   Widget _crearDropMenu(localizations) {
//     return Container(
//       child: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Text(
//                 _selectedQuery ?? localizations.t('chatPage.selectOption'),
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//           PopupMenuButton<String>(
//             icon: Icon(Icons.arrow_drop_down, color: Colors.white),
//             itemBuilder:
//                 (BuildContext context) => <PopupMenuEntry<String>>[
//                   PopupMenuItem<String>(
//                     value: 'Negotiation',
//                     child: Text(localizations.t('chatPage.value1')),
//                   ),
//                 ],
//             initialValue: localizations.t('chatPage.initialValue'),
//             onSelected: (value) {
//               setState(() {
//                 _selectedQuery = value;
//               });
//             },
//           ),
//         ],
//       ),
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
//                   child: Text(localizations.t('chatPage.cameraText')),
//                   onTap:
//                       () => [
//                         pickImageFrom(ImageSource.camera),
//                         Navigator.of(context).pop(),
//                         setState(() {}),
//                       ],
//                 ),
//                 SizedBox(height: 05.0),
//                 Divider(),
//                 SizedBox(height: 05.0),
//                 GestureDetector(
//                   child: Text(localizations.t('chatPage.galleryText')),
//                   onTap:
//                       () => [
//                         pickImageFrom(ImageSource.gallery),
//                         Navigator.of(context).pop(),
//                         setState(() {}),
//                       ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future pickImageFrom(ImageSource source) async {
//     var imageFile = await ImagePicker.pickImage(source: source);
//     setState(() {
//       image = imageFile;
//       TasksListProvider().updateRewardImage(docTaskSelect.docID, image);
//     });
//   }
// }

// class TaskTitleChat extends StatelessWidget {
//   final String title;
//   final String status;

//   const TaskTitleChat({Key key, this.title, this.status}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 110.0,
//       width: MediaQuery.of(context).size.width * 0.6,
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 10.0,
//             left: 5.0,
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.6,
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14.0,
//                   fontFamily: 'Sans',
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 30.0,
//             left: 5.0,
//             child: Text(
//               status,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.0,
//                 fontFamily: 'SansLightItalic',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RewardImageBackgroundChat extends StatelessWidget {
//   final String rewardUrl;
//   const RewardImageBackgroundChat({Key key, this.rewardUrl}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: 0.2,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           image: DecorationImage(
//             image: NetworkImage(rewardUrl),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TaskTitle1 extends StatelessWidget {
//   final String title;
//   final String status;
//   final TextStyle titleStyle;
//   final TextStyle statusStyle;
//   final TextStyle otherStyle;
//   final TextStyle rewardStyle;

//   const TaskTitle1({
//     Key key,
//     this.rewardStyle,
//     this.status,
//     this.titleStyle,
//     this.statusStyle,
//     this.otherStyle,
//     this.title,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.57,
//             child: Text(
//               title,
//               style: titleStyle,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.5,
//             child: Text(status, style: statusStyle),
//           ),
//         ],
//       ),
//     );
//   }
// }
