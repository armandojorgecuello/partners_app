// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/task_model.dart';
// import 'package:honeyiou/utils/locale_app.dart';

// class CompleteTask extends StatelessWidget {
//   final _task = DocTaskSelected.docSnapshot;

//   const CompleteTask({super.key});
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: appbar(context, localizations),
//         backgroundColor: Color(0xff282828),
//         body: body(context, localizations),
//       ),
//     );
//   }

//   Widget body(context, localizations) {
//     var textStyleTask = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'Sans',
//       fontSize: 14.0,
//     );
//     var textStyleReward = TextStyle(
//       color: Color(0xffFFFFFF),
//       fontFamily: 'SansSemiBold',
//       fontSize: 12.0,
//     );
//     return Padding(
//       padding: const EdgeInsets.only(top: 15.0, right: 20.0, left: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             child: Text(
//               localizations.t('completeTask.reward'),
//               style: textStyleTask,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
//             child: Container(
//               child: Text(
//                 _task.data() as Map<String,dynamic>['reward_description'],
//                 style: textStyleTask,
//               ),
//             ),
//           ),
//           Divider(color: Colors.white),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0),
//             child: Container(
//               child: Text(
//                 localizations.t('completeTask.rewardImage'),
//                 style: textStyleTask,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.9,
//             height: MediaQuery.of(context).size.height * 0.4,
//             child: InkWell(
//               child: Card(
//                 elevation: 20.0,
//                 child: Image(
//                   image: NetworkImage(_task.data() as Map<String,dynamic>['reward_img_url']),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               onTap: () {
//                 _showGeneralDialog(context, localizations);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   _showGeneralDialog(context, localizations) {
//     return showGeneralDialog(
//       context: context,
//       barrierColor: Colors.black12.withOpacity(0.6),
//       barrierDismissible: false,
//       barrierLabel: "Dialog",
//       transitionDuration: Duration(milliseconds: 400),
//       pageBuilder: (_, __, ___) {
//         return Scaffold(
//           backgroundColor: Color(0xff282828),
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
//                             localizations.t('completeTask.back'),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             title: Text(localizations.t('completeTask.reward')),
//             centerTitle: true,
//             automaticallyImplyLeading: false,
//           ),
//           body: SafeArea(
//             child: SizedBox.expand(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   image: DecorationImage(
//                     image: NetworkImage(_task.data() as Map<String,dynamic>['reward_img_url']),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget appbar(context, localizations) {
//     return AppBar(
//       title: Text(
//         "Honey IOU",
//         style: TextStyle(fontFamily: "Quick", fontSize: 22.0),
//       ),
//       centerTitle: true,
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color(0xff7a1418),
//       flexibleSpace: Positioned(
//         top: 05.0,
//         left: 0.0,
//         child: ElevatedButton(
//           onPressed: () => Navigator.popAndPushNamed(context, "home_page"),
//           elevation: 0.0,
//           color: const Color(0xff7a1418),
//           child: Row(
//             children: <Widget>[
//               Icon(Icons.arrow_back_ios, color: Colors.white),
//               Text(
//                 localizations.t('completeTask.back'),
//                 style: TextStyle(color: Colors.white, fontSize: 20.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
