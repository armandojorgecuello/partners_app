// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honey_iou_updated/src/pages/task/new_terms_chat.dart';

// class ChatItem1 extends StatefulWidget {
//   final Animation<double> animation;
//   final DocumentSnapshot docTaskSelect;
//   final String status;
//   final TextStyle textStyleTask;
//   final TextStyle textStyleStatus;
//   final Function onPressedShowGeneral;
//   final String textButtonShowGeneral;
//   final Function onPressedStarted;
//   final String textStartTask;
//   final Function onPressedReject;
//   final String textRejectTask;

//   const ChatItem1({
//     super.key,
//     required this.animation,
//     required this.docTaskSelect,
//     required this.status,
//     required this.textStyleTask,
//     required this.textStyleStatus,
//     required this.onPressedShowGeneral,
//     required this.textButtonShowGeneral,
//     required this.onPressedStarted,
//     required this.textStartTask,
//     required this.onPressedReject,
//     required this.textRejectTask,
//   });
//   @override
//   _ChatItem1State createState() => _ChatItem1State();
// }

// class _ChatItem1State extends State<ChatItem1> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 105.0,
//       width: MediaQuery.of(context).size.width * 0.6,
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 10.0,
//             left: 5.0,
//             child: FadeTransition(
//               opacity: widget.animation,
//               child: TaskTitle1(
//                 title: (widget.docTaskSelect.data() as Map<String,dynamic>)['title'],
//                 status: widget.status,
//                 statusStyle: widget.textStyleStatus,
//                 titleStyle: widget.textStyleTask,
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0.0,
//             bottom: 5,
//             height: 25.0,
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.75,
//               child: FadeTransition(
//                 opacity: widget.animation,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ButtonTheme(
//                       minWidth: 60.0,
//                       child: ElevatedButton(
//                         onPressed:()=> widget.onPressedShowGeneral(),
                        
//                         child: Text(
//                           widget.textButtonShowGeneral,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12.0,
//                             fontFamily: 'SansRegular',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 5.0),
//                     ButtonTheme(
//                       minWidth: 64.0,
//                       child: ElevatedButton(
//                         onPressed: ()=>widget.onPressedStarted(),
//                         child: Text(
//                           widget.textStartTask,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12.0,
//                             fontFamily: 'SansRegularlight',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 5.0),
//                     ButtonTheme(
//                       minWidth: 64.0,
//                       child: ElevatedButton(
//                         onPressed: ()=> widget.onPressedReject(),
                        
//                         child: Text(
//                           widget.textRejectTask,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12.0,
//                             fontFamily: 'SansRegularlight',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatItemII extends StatefulWidget {
//   final Animation<double> animation;
//   final DocumentSnapshot docTaskSelect;
//   final String status;
//   final TextStyle textStyleStatus;
//   final TextStyle textStyleTask;
//   final Function onPressedShowGeneral;
//   final String textShowGeneral;
//   final Function onPressedShowDialog;
//   final String textSecondButton;

//   const ChatItemII({
//     Key? key,
//     required this.animation,
//     required this.docTaskSelect,
//     required this.status,
//     required this.textStyleStatus,
//     required this.textStyleTask,
//     required this.onPressedShowGeneral,
//     required this.textShowGeneral,
//     required this.onPressedShowDialog,
//     required this.textSecondButton,
//   }) : super(key: key);

//   @override
//   _ChatItemIIState createState() => _ChatItemIIState();
// }

// class _ChatItemIIState extends State<ChatItemII> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 105.0,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 10.0,
//             left: 5.0,
//             child: FadeTransition(
//               opacity: widget.animation,
//               child: TaskTitle1(
//                 title: (widget.docTaskSelect.data() as Map<String,dynamic>)['title'],
//                 status: widget.status,
//                 statusStyle: widget.textStyleStatus,
//                 titleStyle: widget.textStyleTask,
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0.0,
//             bottom: 5,
//             height: 25.0,
//             child: FadeTransition(
//               opacity: widget.animation,
//               child: Row(
//                 children: <Widget>[
//                   ButtonTheme(
//                     minWidth: 60.0,
//                     child: ElevatedButton(
//                       onPressed:()=> widget.onPressedShowGeneral(),
//                       child: Text(
//                         widget.textShowGeneral,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                           fontFamily: 'SansRegular',
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10.0),
//                   ElevatedButton(
                    
//                     onPressed:()=> widget.onPressedShowDialog(),
//                     child: Text(
//                       widget.textSecondButton,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 12.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatItemIII extends StatefulWidget {
//   final Animation<double> animation;
//   final DocumentSnapshot docTaskSelect;
//   final String status;
//   final TextStyle textStyleStatus;
//   final TextStyle textStyleTask;
//   final Function buttonTask;
//   final String textButtonTask;

//   const ChatItemIII({
//     Key? key,
//     required this.animation,
//     required this.docTaskSelect,
//     required this.status,
//     required this.textStyleStatus,
//     required this.textStyleTask,
//     required this.buttonTask,
//     required this.textButtonTask,
//   }) : super(key: key);

//   @override
//   _ChatItemIIIState createState() => _ChatItemIIIState();
// }

// class _ChatItemIIIState extends State<ChatItemIII> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 105.0,
//       width: MediaQuery.of(context).size.width * 0.6,
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 10.0,
//             left: 5.0,
//             child: FadeTransition(
//               opacity: widget.animation,
//               child: TaskTitle1(
//                 title: (widget.docTaskSelect.data() as Map<String,dynamic>)['title'],
//                 status: widget.status,
//                 statusStyle: widget.textStyleStatus,
//                 titleStyle: widget.textStyleTask,
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0.0,
//             bottom: 5,
//             height: 25.0,
//             width: MediaQuery.of(context).size.width * 0.7,
//             child: FadeTransition(
//               opacity: widget.animation,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.0),
//                   border: Border.all(color: Colors.white),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: ()=> widget.buttonTask(),
//                   child: Text(
//                     widget.textButtonTask,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegularlight',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
