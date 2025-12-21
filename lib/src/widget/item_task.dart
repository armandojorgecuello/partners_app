// import 'package:demoji/demoji.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honey_iou_updated/src/models/user_model.dart';
// import 'package:honey_iou_updated/src/pages/task/negociation.dart';
// import 'package:honey_iou_updated/utils/locale_app.dart';

// import 'background_image.dart';

// class CardTask extends StatefulWidget {
//   final String taskTitle;
//   final String status;
//   final String reviewValue;
//   final String taskRewardImg;
//   final String rewardDescription;
//   final String addImageText;
//   final String statusText;
//   final String buttonText;
//   final Function() onPressed;
//   final Function() addImage;
//   final TaskData task;

//   const CardTask({
//     Key? key,
//     required this.taskTitle,
//     required this.status,
//     required this.reviewValue,
//     required this.taskRewardImg,
//     required this.rewardDescription,
//     required this.addImageText,
//     required this.statusText,
//     required this.buttonText,
//     required this.onPressed,
//     required this.addImage,
//     required this.task,
//   }) : super(key: key);

//   @override
//   _CardTaskState createState() => _CardTaskState();
// }

// bool? imageRewardUrl;

// class _CardTaskState extends State<CardTask> {
//   @override
//   Widget build(BuildContext context) {
//     var textStyleTask = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'Sans',
//       fontSize: 12.0,
//     );
//     var textStyleStatus = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansLightItalic',
//       fontSize: 12.0,
//       fontStyle: FontStyle.italic,
//     );
//     var textStyleReward = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansSemiBold',
//       fontSize: 12.0,
//     );
//     var textStyle = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansLightItalic',
//       fontSize: 12.0,
//     );

//     AppLocalizations? localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final useruid = 'UserPreferences().uid';
//     if (widget.taskRewardImg == '') {
//       imageRewardUrl = false;
//     }
//     if (widget.taskRewardImg != '') {
//       imageRewardUrl = true;
//     }
//     final style = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansRegularlight',
//       fontSize: 12.0,
//     );
//     return GestureDetector(
//       onTap: () {
//         widget.onPressed();
//       },
//       child: Container(
//         child: Stack(
//           children: <Widget>[
//             imageRewardUrl != null
//                 ? RewardImageBackground(rewardUrl: widget.taskRewardImg)
//                 : Positioned(bottom: 00, left: 0.0, child: Container()),
//             Positioned(
//               bottom: 10.0,
//               left: 12.0,
//               child:
//                   widget.task.senderUid == useruid
//                       ? Container(
//                         child: Row(
//                           children: [
//                             Text(
//                               localizations?.t('home_page.sendbyme'),
//                               style: style,
//                             ),
//                             SizedBox(width: 5.0),
//                             Text(Demoji.arrow_upper_right),
//                           ],
//                         ),
//                       )
//                       : Container(
//                         child: Row(
//                           children: [
//                             Text(
//                               localizations?.t('home_page.receivedfrom'),
//                               style: style,
//                             ),
//                             SizedBox(width: 5.0),
//                             Text(Demoji.arrow_lower_left),
//                           ],
//                         ),
//                       ),
//             ),

//             //Aqui colocar el Widget de Titulo, stado y reward
//             Positioned(
//               top: 5.0,
//               left: 130.0,
//               child: GestureDetector(
//                 onTap: () {
//                   widget.onPressed();
//                 },
//                 child: TaskTitle(
//                   title: widget.taskTitle,
//                   reward: widget.rewardDescription,
//                   status: widget.statusText,
//                   otherStyle: textStyle,
//                   rewardStyle: textStyleReward,
//                   titleStyle: textStyleTask,
//                   statusStyle: textStyleStatus,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10,
//               right: 10.0,
//               height: 30.0,
//               child:
//                   widget.status != "reviewed"
//                       ? Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50.0),
//                           // border: Border.all(color: Colors.white)
//                           color:
//                               widget.status != "completed"
//                                   ? Color(0xffBF2328)
//                                   : Color(0xffBF2328),
//                         ),
//                         child: ElevatedButton(
                          
//                           child: Text(
//                             widget.buttonText,
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontFamily: 'SansRegularlight',
//                               fontSize: 12.0,
//                             ),
//                           ),
//                           onPressed: () {
//                             widget.onPressed();
//                           },
//                         ),
//                       )
//                       : Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xffBF2328),
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                         child: ElevatedButton(
//                           child: Row(
//                             children: [
//                               Text(
//                                 widget.reviewValue == "like"
//                                     ? localizations?.t(
//                                       "home_page.reviewbuttonGodJob",
//                                     )
//                                     : localizations?.t(
//                                       "home_page.reviewbuttonBadReview",
//                                     ),
//                                 style: TextStyle(
//                                   color:
//                                       widget.status != "reviewed"
//                                           ? Color(0xffFFFFFF)
//                                           : Color(0xffFFFFFF),
//                                   fontFamily: 'SansRegularlight',
//                                   fontSize: 12.0,
//                                 ),
//                               ),
//                               SizedBox(width: 5.0),
//                               widget.reviewValue == "like"
//                                   ? Text(Demoji.grin)
//                                   : Text(Demoji.slightly_frowning_face),
//                             ],
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               // SingleTask.docSnapshot = widget.task;
//                             });
//                             widget.onPressed();
//                           },
//                         ),
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CardTaskI extends StatefulWidget {
//   // final DocumentSnapshot task;
//   final String taskTitle;
//   final String taskRewardImg;
//   final String rewardDescription;
//   final String addImageText;
//   final String statusText;
//   final String buttonText;
//   final Function() onPressed;
//   final Function() addImage;
//   final String assetsImagePath;
//   final TaskData task;

//   const CardTaskI({
//     Key? key,
//     required this.taskTitle,
//     required this.taskRewardImg,
//     required this.rewardDescription,
//     required this.addImageText,
//     required this.statusText,
//     required this.buttonText,
//     required this.onPressed,
//     required this.addImage,
//     required this.assetsImagePath,
//     required this.task,
//   }) : super(key: key);

//   @override
//   _CardTaskIState createState() => _CardTaskIState();
// }

// class _CardTaskIState extends State<CardTaskI> {
//   bool? imageRewardUrl;

//   @override
//   Widget build(BuildContext context) {
//     var textStyleTask = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'Sans',
//       fontSize: 12.0,
//     );
//     var textStyleStatus = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansLightItalic',
//       fontSize: 12.0,
//       fontStyle: FontStyle.italic,
//     );
//     var textStyleReward = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansSemiBold',
//       fontSize: 12.0,
//     );
//     var textStyle = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansLightItalic',
//       fontSize: 12.0,
//     );

//     AppLocalizations? localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final useruid = 'UserPreferences().uid';
//     if (widget.taskRewardImg == '') {
//       imageRewardUrl = false;
//     }
//     if (widget.taskRewardImg != '') {
//       imageRewardUrl = true;
//     }
//     final style = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansRegularlight',
//       fontSize: 12.0,
//     );
//     return GestureDetector(
//       onTap: () {
//         widget.onPressed();
//       },
//       child: Container(
//         child: Stack(
//           children: <Widget>[
//             imageRewardUrl != null
//                 ? RewardImageBackground(
//                   rewardUrl:
//                       widget.taskRewardImg ??
//                       "https://upload.wikimedia.org/wikipedia/commons/7/75/No_image_available.png",
//                 )
//                 : Positioned(bottom: 00, left: 0.0, child: Container()),
//             Positioned(
//               bottom: 10.0,
//               left: 12.0,
//               child:
//                   widget.task.senderUid == useruid
//                       ? Container(
//                         child: Row(
//                           children: [
//                             Text(
//                               localizations?.t('home_page.sendbyme'),
//                               style: style,
//                             ),
//                             SizedBox(width: 5.0),
//                             Text(Demoji.arrow_upper_right),
//                           ],
//                         ),
//                       )
//                       : Container(
//                         child: Row(
//                           children: [
//                             Text(
//                               localizations?.t('home_page.receivedfrom'),
//                               style: style,
//                             ),
//                             SizedBox(width: 5.0),
//                             Text(Demoji.arrow_lower_left),
//                           ],
//                         ),
//                       ),
//             ),
//             //Aqui colocar el Widget de Titulo, stado y reward
//             Positioned(
//               top: 5.0,
//               left: 130.0,
//               child: GestureDetector(
//                 onTap: () {
//                   widget.onPressed();
//                 },
//                 child: TaskTitle(
//                   title: widget.taskTitle,
//                   reward: widget.rewardDescription,
//                   status: widget.statusText,
//                   otherStyle: textStyle,
//                   rewardStyle: textStyleReward,
//                   titleStyle: textStyleTask,
//                   statusStyle: textStyleStatus,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10,
//               right: 10.0,
//               height: 30.0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.0),
//                   color: Color(0xffBF2328),
//                 ),
//                 child: ElevatedButton(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Text(
//                         widget.buttonText,
//                         style: TextStyle(
//                           color: Color(0xffFFFFFF),
//                           fontFamily: 'SansRegularlight',
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       SizedBox(width: 5.0),
//                       Image.asset(
//                         'assets/image/Credits_Icon1.png',
//                         width: 20.0,
//                         height: 20.0,
//                       ),
//                       SizedBox(width: 5.0),
//                       Text(
//                         'X 1',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                           fontFamily: 'SansRegularlight',
//                         ),
//                       ),
//                     ],
//                   ),
//                   onPressed: () {
//                     widget.onPressed();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
