// import 'package:demoji/demoji.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/user_model.dart';
// import 'package:honeyiou/src/pages/task/negociation.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// import 'background_image.dart';

// class CardTaskReceiver extends StatefulWidget {
//   final String taskTitle;
//   final String rewardDescription;
//   final String rewardImageUrl;
//   final String addImageText;
//   final String statusText;
//   final String buttonText;
//   final Function() onPressed;
//   final Function() addImage;
//   final String assetsImagePath;
//   final TaskData task;

//   const CardTaskReceiver({
//     Key key,
//     this.taskTitle,
//     this.rewardDescription,
//     this.rewardImageUrl,
//     this.addImageText,
//     this.statusText,
//     this.buttonText,
//     this.onPressed,
//     this.addImage,
//     this.assetsImagePath,
//     this.task,
//   }) : super(key: key);

//   @override
//   _CardTaskReceiverState createState() => _CardTaskReceiverState();
// }

// bool imageRewardUrl;

// class _CardTaskReceiverState extends State<CardTaskReceiver> {
//   var textStyleTask = TextStyle(
//     color: Color(0xffFFFFFF),
//     fontFamily: 'Sans',
//     fontSize: 12.0,
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

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final useruid = UserPreferences().uid;
//     if (widget.rewardImageUrl == '') {
//       setState(() {
//         imageRewardUrl = false;
//       });
//     }
//     if (widget.rewardImageUrl != '') {
//       setState(() {
//         imageRewardUrl = true;
//       });
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
//             imageRewardUrl
//                 ? RewardImageBackground(rewardUrl: widget.rewardImageUrl)
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
//                               localizations.t('home_page.sendbyme'),
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
//                               localizations.t('home_page.receivedfrom'),
//                               style: style,
//                             ),
//                             SizedBox(width: 5.0),
//                             Text(Demoji.arrow_lower_left),
//                           ],
//                         ),
//                       ),
//             ),

//             Positioned(
//               top: 5.0,
//               left: 130.0,
//               child: GestureDetector(
//                 onTap: () {
//                   widget.onPressed();
//                 },
//                 child: TaskTitle(
//                   title: widget.taskTitle ?? "",
//                   reward: widget.rewardDescription ?? "",
//                   status: widget.statusText ?? "",
//                   otherStyle: textStyle ?? "",
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
//                   // border: Border.all(color: Colors.white)),
//                 ),
//                 child: ElevatedButton(
//                   // color: Colors.red,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   color: Color(0xffBF2328),
//                   onPressed: () {
//                     widget.onPressed();
//                   },
//                   child: Row(
//                     children: [
//                       Text(
//                         widget.buttonText,
//                         style: TextStyle(
//                           color: Color(0xffFFFFFF),
//                           fontFamily: 'SansRegularlight',
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       widget.statusText == "Not started" ||
//                               widget.statusText == "No iniciada"
//                           ? Image.asset("assets/image/coin.png")
//                           : Container(),
//                       widget.statusText == "Not started" ||
//                               widget.statusText == "No iniciada"
//                           ? Text(
//                             "X 1",
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontFamily: 'SansRegularlight',
//                               fontSize: 12.0,
//                             ),
//                           )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
