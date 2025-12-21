// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demoji/demoji.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/user_model.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class Review extends StatefulWidget {
//   final String reviewValue;
//   final String reviewDescription;
//   final String status;
//   final String taskDate;
//   final TaskData task;

//   const Review({
//     Key key,
//     this.reviewValue,
//     this.reviewDescription,
//     this.status,
//     this.taskDate,
//     this.task,
//   }) : super(key: key);

//   @override
//   _ReviewState createState() =>
//       _ReviewState(reviewValue, reviewDescription, status, taskDate, task);
// }

// class _ReviewState extends State<Review> with TickerProviderStateMixin {
//   final String reviewValue;
//   final String reviewDescription;
//   final String status;
//   final String taskDate;
//   final TaskData task;
//   _ReviewState(
//     this.reviewValue,
//     this.reviewDescription,
//     this.status,
//     this.taskDate,
//     this.task,
//   );

//   final _formKey = GlobalKey<FormState>();

//   String review_description!;

//   getReward(reward) {
//     review_description = reward;
//   }

//   Animation<double> _animation;
//   AnimationController _controller;
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );

//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             GestureDetector(
//               child: SizedBox(
//                 height: 40.0,
//                 width: 100.0,
//                 // color:Colors.white,
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.arrow_back_ios, color: Colors.white),
//                     Text(
//                       localizations.t('support.back'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               onTap: () => Navigator.pop(context),
//             ),
//             SizedBox(width: 15.0),
//             Text(
//               status == "reviewed"
//                   ? localizations.t('home_page.checkReview')
//                   : localizations.t('home_page.sendReview'),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xff7a1418),
//       ),
//       backgroundColor: Color(0xff393939),
//       body: Stack(children: [_body(localizations)]),
//     );
//   }

//   Widget _body(AppLocalizations localizations) {
//     String uid = UserPreferences().uid;
//     if (status == "reviewed") {
//       return Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.2,
//               width: MediaQuery.of(context).size.width,
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: MediaQuery.of(context).size.width * 0.2,
//                     child: avatarImage(
//                       uid == task.senderUid ? task.senderUid : task.receiverUid,
//                     ),
//                   ),
//                   Positioned(
//                     right: MediaQuery.of(context).size.width * 0.2,
//                     child: avatarImage(
//                       uid == task.senderUid ? task.receiverUid : task.senderUid,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10.0),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.calendar_today, color: Colors.white, size: 14),
//                   SizedBox(width: 10.0),
//                   Container(
//                     child: Text(
//                       taskDate,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'SansRegularLight',
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Container(
//               child: Text(
//                 task.title,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Sans',
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             reviewValue != "like"
//                 ? Text(
//                   Demoji.slightly_frowning_face,
//                   style: TextStyle(fontSize: 60.0, color: Colors.yellow),
//                 )
//                 : Text(
//                   Demoji.grin,
//                   style: TextStyle(fontSize: 80.0, color: Colors.yellow),
//                 ),
//             SizedBox(height: 10.0),
//             Row(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         localizations.t('home_page.reviewDescription'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Sans',
//                           fontSize: 18.0,
//                         ),
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(
//                         reviewDescription.isNotEmpty
//                             ? reviewDescription
//                             : localizations.t('home_page.commentsEmpty'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SansRegularLight',
//                           fontSize: 18.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   width: MediaQuery.of(context).size.width,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: MediaQuery.of(context).size.width * 0.2,
//                         child: avatarImage(
//                           uid == task.senderUid
//                               ? task.senderUid
//                               : task.receiverUid,
//                         ),
//                       ),
//                       Positioned(
//                         right: MediaQuery.of(context).size.width * 0.2,
//                         child: avatarImage(
//                           uid == task.senderUid
//                               ? task.receiverUid
//                               : task.senderUid,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10.0),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.calendar_today, color: Colors.white, size: 12),
//                       SizedBox(width: 10.0),
//                       Container(
//                         child: Text(
//                           taskDate,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'SansRegularLight',
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10.0),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Text(
//                     task.title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Sans',
//                       fontSize: 18.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10.0),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Container(
//                     child: Text(
//                       localizations.t('home_page.textDialogTaskCompleted'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Sans',
//                         fontSize: 14.0,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: TextFormField(
//                     maxLines: 3,
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Review is empty";
//                       }
//                       return null;
//                     },
//                     style: TextStyle(color: Colors.white),
//                     onChanged: (String rewardDesc) {
//                       getReward(rewardDesc);
//                     },
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10.0),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Text(
//                     localizations.t("home_page.askEndTaskreview"),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Sans',
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         height: 33.0,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50.0),
//                           color: Color(0xffBF2328),
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               TasksListProvider().updateStatus(
//                                 task.uidTask,
//                                 'reviewed',
//                               );
//                               TasksListProvider().reviewTask(
//                                 task.uidTask,
//                                 'like',
//                                 review_description,
//                               );
//                               Navigator.of(context).pop();
//                             }
//                           },
//                           child: Row(
//                             children: [
//                               Text(
//                                 localizations.t(
//                                   'home_page.buttonTaskCompletedDialogYes',
//                                 ),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'SansRegularlight',
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               SizedBox(width: 10.0),
//                               Text(Demoji.grin),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.0),
//                       Container(
//                         height: 33.0,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50.0),
//                           color: Color(0xffBF2328),
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               TasksListProvider().updateStatus(
//                                 task.uidTask,
//                                 'reviewed',
//                               );
//                               TasksListProvider().reviewTask(
//                                 task.uidTask,
//                                 'unlike',
//                                 review_description,
//                               );
//                               Navigator.of(context).pop();
//                             }
//                           },
//                           child: Row(
//                             children: [
//                               Text(
//                                 localizations.t(
//                                   'home_page.buttonTaskCompletedDialogNo',
//                                 ),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'SansRegularlight',
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               SizedBox(width: 10.0),
//                               Text(Demoji.slightly_frowning_face),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10.0),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }

//   Widget avatarImage(String uid) {
//     return FadeTransition(
//       opacity: _animation,
//       child: StreamBuilder(
//         stream:
//             FirebaseFirestore.instance
//                 .collection("users")
//                 .doc(uid)
//                 .collection(uid)
//                 .doc(uid)
//                 .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container(child: Center(child: CircularProgressIndicator()));
//           }
//           return Container(
//             child: CircleAvatarWidget(
//               radius: 70.0,
//               imageUrl:
//                   snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                   'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
