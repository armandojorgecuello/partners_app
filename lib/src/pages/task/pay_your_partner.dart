// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/task_model.dart';
// import 'package:honeyiou/src/models/user_model.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/src/widget/pay_with_coin.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:provider/provider.dart';

// class PayYourPartnerPage extends StatefulWidget {
//   final TaskData task;

//   const PayYourPartnerPage({Key key, this.task}) : super(key: key);
//   @override
//   _PayYourPartnerPageState createState() => _PayYourPartnerPageState(task);
// }

// class _PayYourPartnerPageState extends State<PayYourPartnerPage>
//     with TickerProviderStateMixin {
//   final TaskData task;
//   _PayYourPartnerPageState(this.task);
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
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final taskProvider = Provider.of<TasksListProvider>(context, listen: false);
//     return SafeArea(
//       child: Scaffold(
//         appBar: appbar(localizations),
//         backgroundColor: Color(0xff393939),
//         // backgroundColor: Colors.grey[900],
//         body: Container(
//           child: Stack(
//             children: <Widget>[
//               Opacity(
//                 opacity: 0.1,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(taskProvider.rewardImgUrl),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.85,
//                 child: ListView(
//                   children: <Widget>[
//                     Stack(
//                       children: <Widget>[
//                         Positioned(
//                           child: FadeTransition(
//                             opacity: _animation,
//                             child: _leadingTask(),
//                           ),
//                         ),
//                         Positioned(
//                           child: FadeTransition(
//                             opacity: _animation,
//                             child: titleTask(localizations),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             top: 110.0,
//                             left: 10.0,
//                             right: 10.0,
//                           ),
//                           child: Divider(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 bottom: 10.0,
//                 left: 10.0,
//                 right: 10.0,
//                 child: button(localizations),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget appbar(localizations) {
//     return AppBar(
//       title: Row(
//         children: [
//           GestureDetector(
//             child: SizedBox(
//               height: 40.0,
//               width: 100.0,
//               child: Row(
//                 children: <Widget>[
//                   Icon(Icons.arrow_back_ios, color: Colors.white),
//                   Text(
//                     localizations.t('payYourPartner.back'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () => Navigator.pop(context),
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.1),
//           Text(
//             "Honey IOU",
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Quick',
//               fontSize: 22.0,
//             ),
//           ),
//         ],
//       ),
//       centerTitle: true,
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color(0xff7a1418),
//       // backgroundColor: Colors.red,
//     );
//   }

//   Widget taskWidget() {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Row(),
//     );
//   }

//   Widget _leadingTask() {
//     final taskProvider = Provider.of<TasksListProvider>(context);
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0),
//       child: SizedBox(
//         height: 80.0,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               top: 0.0,
//               left: 10.0,
//               bottom: 10.0,
//               child: StreamBuilder(
//                 stream: UsuarioProvider().getPartnerData(task.senderUid),
//                 builder: (context, senderTaskInfo) {
//                   return CircleAvatarWidget(
//                     radius: 30.0,
//                     imageUrl:
//                         senderTaskInfo.data() as Map<String,dynamic>['photo_url'] ??
//                         'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                   );
//                 },
//               ),
//             ),
//             Positioned(
//               top: 0.0,
//               left: 55.0,
//               bottom: 10.0,
//               child: StreamBuilder(
//                 stream: UsuarioProvider().getPartnerData(task.receiverUid),
//                 builder: (context, receiverTaskInfo) {
//                   return CircleAvatarWidget(
//                     radius: 30.0,
//                     imageUrl:
//                         receiverTaskInfo.data() as Map<String,dynamic>['photo_url'] ??
//                         'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget titleTask(localizations) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     // var _task = SingleTask.docSnapshot;
//     final taskProvider = Provider.of<TasksListProvider>(context);
//     if (taskProvider.senderUid == user) {
//       if (taskProvider.status == 'not_started') {
//         return SizedBox(
//           height: 110.0,
//           width: MediaQuery.of(context).size.width,
//           child: Stack(
//             children: <Widget>[
//               Positioned(
//                 top: 10.0,
//                 left: 140.0,
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   height: 40.0,
//                   child: Text(
//                     taskProvider.title ?? '',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 50.0,
//                 left: 140.0,
//                 height: 20.0,
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       child: Text(
//                         localizations.t('payYourPartner.reward') + ' ',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                           fontFamily: 'SansRegular',
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.height * 0.5,
//                       child: Text(
//                         taskProvider.rewardDescription ?? '',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                           fontFamily: 'SansLightItalic',
//                           fontStyle: FontStyle.italic,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 30.0,
//                 left: 140.0,
//                 height: 20.0,
//                 child: Text(
//                   localizations.t('payYourPartner.notStarted'),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12.0,
//                     fontFamily: 'SansLightItalic',
//                     fontStyle: FontStyle.italic,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Positioned(
//                 bottom: 0.0,
//                 right: 10.0,
//                 height: 30.0,
//                 child: ElevatedButton(
//                   color: const Color(0xff7a1418),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Text(
//                         localizations.t('home_page.paidUpFront'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                           fontFamily: 'SansRegularlight',
//                         ),
//                       ),
//                       SizedBox(width: 5.0),
//                       Image.asset('assets/image/Credits_Icon.png', height: 20),
//                       SizedBox(width: 5.0),
//                       // Text('X 1', style: TextStyle(color:Colors.white, fontSize: 12.0, fontFamily: 'Sans')),
//                     ],
//                   ),
//                   onPressed: () {
//                     _showGeneralDialog(localizations);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else {
//         return Container();
//       }
//     }
//   }

//   Widget button(localizations) {
//     final taskProvider = Provider.of<TasksListProvider>(context, listen: false);
//     // var _task = SingleTask.docSnapshot;
//     return FadeTransition(
//       opacity: _animation,
//       child: Center(
//         child: ElevatedButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(70.0),
//           ),
//           elevation: 0.0,
//           color: const Color(0xff7a1418),
//           // color: Colors.red,
//           child: Center(
//             child: Container(
//               child: Center(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       localizations.t('home_page.paidUpFront'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.0,
//                         fontFamily: 'SansRegularlight',
//                       ),
//                     ),
//                     SizedBox(width: 5.0),
//                     Image.asset('assets/image/Credits_Icon.png', height: 20),
//                     SizedBox(width: 5.0),
//                     // Text('X 1', style: TextStyle(color:Colors.white, fontSize: 14.0, fontFamily: 'Sans')),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           onPressed: () {
//             // TasksListProvider().updateStatus(taskProvider.idTask, 'paid_upfront');
//             _showGeneralDialog(localizations);
//           },
//         ),
//       ),
//     );
//   }

//   _showGeneralDialog(localizations) {
//     final taskProvider = Provider.of<TasksListProvider>(context, listen: false);
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: false,
//       pageBuilder: (context, animation1, animation2) {
//         return Sizedbox();
//       },
//       transitionDuration: Duration(milliseconds: 200),
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
//               content: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 height: MediaQuery.of(context).size.height * 0.35,
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       // height: 100.0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Image.asset(
//                             'assets/image/Credits_Icon1.png',
//                             width: 77.0,
//                             height: 77.0,
//                           ),
//                           SizedBox(width: 5.0),
//                           // Text('X 1', style:TextStyle(color:Color(0xffFFFFFF), fontFamily: 'Sans', fontSize: 28.0))
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 15.0),
//                     PayWithCoin(nameSender: "", prevPage: "pay_partner"),
//                     SizedBox(height: 10.0),
//                     Container(
//                       height: 50.0,
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.0),
//                         border: Border.all(color: Colors.white),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           TasksListProvider().updateStatus(
//                             taskProvider.idTask,
//                             'not_started',
//                           );
//                           Navigator.of(context).pop();
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                         child: Text(
//                           localizations.t('payYourPartner.buttomText3'),
//                           style: TextStyle(
//                             color: Color(0xffFFFFFF),
//                             fontFamily: 'SansRegularlight',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               title: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.2,
//                 child: Text(
//                   localizations.t('payYourPartner.popUpText'),
//                   style: TextStyle(color: Color(0xffFFFFFF), fontSize: 14.0),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
