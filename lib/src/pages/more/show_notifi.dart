// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/notifications_model.dart';
// import 'package:honeyiou/src/pages/task/negociation.dart';
// import 'package:honeyiou/src/providers/show_nofi_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'package:sticky_grouped_list/sticky_grouped_list.dart';

// class ShowNotifications extends StatefulWidget {
//   const ShowNotifications({Key key}) : super(key: key);

//   @override
//   _ShowNotificationsState createState() => _ShowNotificationsState();
// }

// class _ShowNotificationsState extends State<ShowNotifications>
//     with TickerProviderStateMixin {
//   static final pref = UserPreferences();
//   String user = pref.uid;
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

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: _appBar(localizations),
//         backgroundColor: Color(0xff282828),
//         body: _body(localizations),
//       ),
//     );
//   }

//   Widget _appBar(localizations) {
//     return AppBar(
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 5.0, right: 5.0),
//               child: GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.arrow_back_ios, color: Colors.white),
//                     Text(
//                       localizations.t('notification.back'),
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
//           ),
//           Text(
//             localizations.t('notification.title'),
//             style: TextStyle(color: Colors.white),
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 5.0, right: 5.0),
//               child: Container(),
//             ),
//           ),
//         ],
//       ),
//       centerTitle: true,
//       backgroundColor: const Color(0xff7a1418),
//       automaticallyImplyLeading: false,
//     );
//   }

//   Widget _body(localizations) {
//     var notiData = ShowNotificationsProvider(user).notiData;
//     List<NotificationsData> listData = List<NotificationsData>();
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: StreamBuilder<QuerySnapshot>(
//         stream: notiData(),
//         builder: (_, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data.docs.isEmpty) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: FadeTransition(
//                       opacity: _animation,
//                       child: Text(
//                         localizations.t('notification.textEmpty'),
//                         style: TextStyle(
//                           color: Color(0xffFFFFFF),
//                           fontFamily: 'SansLightItalic',
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }
//             for (var element in snapshot.data.docs) {
//               final temporalDataNotification = NotificationsData.fromJson(
//                 element.data,
//               );
//               listData.add(temporalDataNotification);
//             }
//             return SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.9,
//               child: StickyGroupedListView(
//                 elements: listData,
//                 order: StickyGroupedListOrder.DESC,
//                 floatingHeader: true,
//                 groupBy: (NotificationsData notificationData) {
//                   Timestamp timeStamp = notificationData.dateTime;
//                   DateTime date = timeStamp.toDate();
//                   return DateTime(date.year, date.month, date.day);
//                 },
//                 groupSeparatorBuilder: (NotificationsData notificationData) {
//                   Timestamp timeStamp = notificationData.dateTime;
//                   DateTime date = timeStamp.toDate();
//                   String formattedDate;
//                   var formatter = DateFormat("EEE, MMM d 'yyyy");
//                   formattedDate = formatter.format(date);

//                   return Container(
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: Color(0xff7a1418),
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         height: 30,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           color: Color(0xff282828),
//                           // borderRadius: BorderRadius.circular(20.0)
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             formattedDate,
//                             // '${date.day}, ${date.month}, ${date.year}',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 itemBuilder: (
//                   BuildContext context,
//                   NotificationsData notificationData,
//                 ) {
//                   print(notificationData.status);
//                   return notificationsList(notificationData, localizations);
//                 },
//               ),
//             );
//           } else {
//             return FadeTransition(
//               opacity: _animation,
//               child: Text(localizations.t('notification.textEmpty')),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget notificationsList(NotificationsData notifications, localizations) {
//     TextStyle notiStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 12.0,
//       fontFamily: 'SansSemiBold',
//     );
//     TextStyle styleText = TextStyle(
//       color: Colors.white,
//       fontSize: 12.0,
//       fontFamily: 'SansRegularlight',
//     );
//     Timestamp timeStamp = notifications.dateTime;
//     DateTime date = timeStamp.toDate();
//     String formattedDate;
//     var formatter = DateFormat("HH':'mm aaa");
//     formattedDate = formatter.format(date);
//     if (notifications.senderUid == user) {
//       var senderData = ShowNotificationsProvider(
//         user,
//       ).userNotiInfo('${notifications.receiverUid}');
//       return StreamBuilder(
//         stream: senderData,
//         builder: (_, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.connectionState == ConnectionState.active) {
//             if (notifications.type == 'status_change') {
//               if (notifications.status == 'open') {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(snapshot.data() as Map<String,dynamic>['photo_url']),
//                   ),
//                   title: Text(
//                     snapshot.data() as Map<String,dynamic>['name'] +
//                         ' ' +
//                         localizations.t('notification.openTask'),
//                     style: notiStyle,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       'chat_page',
//                       arguments: notifications.taskId,
//                     );
//                   },
//                   trailing: Text(formattedDate, style: notiStyle),
//                 );
//               } else if (notifications.status == 'started') {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(snapshot.data() as Map<String,dynamic>['photo_url']),
//                   ),
//                   title: Text(
//                     snapshot.data() as Map<String,dynamic>['name'] +
//                         ' ' +
//                         localizations.t('notification.startedTask'),
//                     style: notiStyle,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       'chat_page',
//                       arguments: notifications.taskId,
//                     );
//                   },
//                   trailing: Text(formattedDate, style: notiStyle),
//                 );
//               } else if (notifications.status == 'rejected') {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(snapshot.data() as Map<String,dynamic>['photo_url']),
//                   ),
//                   title: Text(
//                     snapshot.data() as Map<String,dynamic>['name'] +
//                         ' ' +
//                         localizations.t('notification.rejectedTask'),
//                     style: notiStyle,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       'chat_page',
//                       arguments: notifications.taskId,
//                     );
//                   },
//                   trailing: Text(formattedDate, style: notiStyle),
//                 );
//               } else if (notifications.status == 'completed') {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(snapshot.data() as Map<String,dynamic>['photo_url']),
//                   ),
//                   title: Text(
//                     snapshot.data() as Map<String,dynamic>['name'] +
//                         ' ' +
//                         localizations.t('notification.completedTask'),
//                     style: notiStyle,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       'chat_page',
//                       arguments: notifications.taskId,
//                     );
//                   },
//                   trailing: Text(formattedDate, style: notiStyle),
//                 );
//               } else {
//                 return Container();
//               }
//             } else if (notifications.type == 'new_chat_message') {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(snapshot.data() as Map<String,dynamic>['photo_url']),
//                 ),
//                 title: Text(
//                   snapshot.data() as Map<String,dynamic>['name'] +
//                       ' ' +
//                       localizations.t('notification.sendMessage'),
//                   style: notiStyle,
//                 ),
//                 onTap: () {
//                   Navigator.pushNamed(
//                     context,
//                     'chat_page',
//                     arguments: notifications.taskId,
//                   );
//                 },
//                 trailing: Text(formattedDate, style: notiStyle),
//               );
//             } else {
//               return Container();
//             }
//           } else {
//             return Container();
//           }
//         },
//       );
//     }
//     if (notifications.receiverUid == user) {
//       // print(noti);

//       var receiverData = ShowNotificationsProvider(
//         user,
//       ).userNotiInfo('${notifications.senderUid}');
//       return StreamBuilder(
//         stream: receiverData,
//         builder: (_, snapshot1) {
//           if (snapshot1.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot1.connectionState == ConnectionState.active) {
//             if (notifications.type == 'status_change') {
//               if (notifications.status == 'pending_receiver') {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(snapshot1.data() as Map<String,dynamic>['photo_url']),
//                   ),
//                   title: Text(
//                     snapshot1.data() as Map<String,dynamic>['name'] +
//                         ' ' +
//                         localizations.t('notification.updateTask'),
//                     style: notiStyle,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       'chat_page',
//                       arguments: notifications.taskId,
//                     );
//                   },
//                   trailing: Text(formattedDate, style: notiStyle),
//                 );
//               } else if (notifications.status == 'paid_upfront') {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(snapshot1.data() as Map<String,dynamic>['photo_url']),
//                   ),
//                   title: Text(
//                     snapshot1.data() as Map<String,dynamic>['name'] +
//                         ' ' +
//                         localizations.t('notification.paidUpFrontTask'),
//                     style: notiStyle,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       'chat_page',
//                       arguments: notifications.taskId,
//                     );
//                   },
//                   trailing: Text(formattedDate, style: notiStyle),
//                 );
//               } else if (notifications.status == 'reviewed') {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(snapshot1.data() as Map<String,dynamic>['photo_url']),
//                   ),
//                   title: Text(
//                     snapshot1.data() as Map<String,dynamic>['name'] +
//                         ' ' +
//                         "localizations.t('notification.paidUpFrontTask')",
//                     style: notiStyle,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       'chat_page',
//                       arguments: notifications.taskId,
//                     );
//                   },
//                   trailing: Text(formattedDate, style: notiStyle),
//                 );
//               } else {
//                 return Container();
//               }
//             } else if (notifications.type == 'partner_request') {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(snapshot1.data() as Map<String,dynamic>['photo_url']),
//                 ),
//                 title: Text(
//                   snapshot1.data() as Map<String,dynamic>['name'] +
//                       ' ' +
//                       localizations.t('notification.autoAllow'),
//                   style: notiStyle,
//                 ),
//                 onTap: () {
//                   Navigator.pushNamed(context, 'partners_accepted');
//                 },
//                 trailing: Text(formattedDate, style: notiStyle),
//               );
//             } else if (notifications.type == 'new_chat_message') {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(snapshot1.data() as Map<String,dynamic>['photo_url']),
//                 ),
//                 title: Text(
//                   snapshot1.data() as Map<String,dynamic>['name'] +
//                       ' ' +
//                       localizations.t('notification.sendMessage'),
//                   style: notiStyle,
//                 ),
//                 onTap: () {
//                   Navigator.pushNamed(
//                     context,
//                     'chat_page',
//                     arguments: notifications.taskId,
//                   );
//                 },
//                 trailing: Text(formattedDate, style: notiStyle),
//               );
//             } else if (notifications.type == 'new_task') {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(snapshot1.data() as Map<String,dynamic>['photo_url']),
//                 ),
//                 title: Text(
//                   snapshot1.data() as Map<String,dynamic>['name'] +
//                       ' ' +
//                       localizations.t('notification.newTask'),
//                   style: notiStyle,
//                 ),
//                 onTap: () {
//                   // Navigator.pushNamed(context, 'chat_page', arguments: notifications.data() as Map<String,dynamic>['taskID'] );
//                 },
//                 trailing: Text(formattedDate, style: notiStyle),
//               );
//             } else {
//               return Container();
//             }
//           } else {
//             return Container();
//           }
//         },
//       );
//     } else {
//       return Container();
//     }
//   }

//   Widget listTile(
//     String imgUrl,
//     String name,
//     String description,
//     String routeName,
//     String taskID,
//   ) {
//     return ListTile(
//       leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
//       title: Text(name + description),
//       onTap: () {
//         Navigator.pushNamed(context, routeName, arguments: taskID);
//       },
//     );
//   }
// }
