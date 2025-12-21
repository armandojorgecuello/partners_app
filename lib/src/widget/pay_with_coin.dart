// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honey_iou_updated/src/pages/more/buy_credits.dart';
// import 'package:honey_iou_updated/src/pages/task/negociation.dart';
// import 'package:honey_iou_updated/src/providers/free_coins_provider.dart';
// import 'package:honey_iou_updated/src/providers/tasks_provider.dart';
// import 'package:honey_iou_updated/utils/locale_app.dart';
// import 'package:provider/provider.dart';
// import 'show_dialog_task_end.dart';

// class PayWithCoin extends StatefulWidget {
//   final String? nameSender;
//   final String? prevPage;

//   const PayWithCoin({super.key, this.nameSender, this.prevPage});

//   @override
//   _PayWithCoinState createState() => _PayWithCoinState(nameSender, prevPage);
// }

// class _PayWithCoinState extends State<PayWithCoin> {
//   final String? nameSender;
//   final String? prevPage;

//   _PayWithCoinState(this.nameSender, this.prevPage);

//   @override
//   Widget build(BuildContext context) {
//     // final userUid = UserPreferences().uid;
//     AppLocalizations? localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final taskProvider = Provider.of<TasksListProvider>(context, listen: false);
//     final getCoins = FreeCoinsProvider().getLastCoins('userUid');
//     return StreamBuilder<QuerySnapshot>(
//       stream: getCoins,
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting)
//           return Container(child: CircularProgressIndicator());
//         return SizedBox(
//           height: 50.0,
//           width: MediaQuery.of(context).size.width * 0.5,
//           child: ElevatedButton(
//             // color: Colors.red,
//             onPressed: () async {
//               if (snapshot.data!.docs.isNotEmpty) {
//                 TasksListProvider().updateStatus(taskProvider.idTask, 'open');
//                 Navigator.of(context).pop();
//                 FreeCoinsProvider().consumeCredits('userUid');
//                 prevPage == "start_neg"
//                     ? ShowDialogBoxFinish().showDialogAfterPayment(
//                       taskProvider.idTask,
//                       localizations,
//                       context,
//                       () {},
//                       nameSender!,
//                       taskProvider.senderUid,
//                       taskProvider.receiverUid,
//                       taskProvider.idTask,
//                     )
//                     : showgeneralDialogPayPartner();
//               }
//               if (snapshot.data!.docs.isEmpty) {
//                 showgeneralDialog();
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xff7A1418),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(70.0),
//               ),
//             ),
//             // color: Colors.red,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   localizations?.t('startNegociation.buttomText2'),
//                   style: TextStyle(
//                     color: Color(0xffFFFFFF),
//                     fontFamily: 'SansRegularlight',
//                   ),
//                 ),
//                 SizedBox(width: 5.0),
//                 Image.asset('assets/image/Credits_Icon.png', height: 20),
//                 SizedBox(width: 5.0),
//                 Text(
//                   'X 1',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14.0,
//                     fontFamily: 'Sans',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   showgeneralDialog() {
//     showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         AppLocalizations? localizations = Localizations.of<AppLocalizations>(
//           context,
//           AppLocalizations,
//         );
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               backgroundColor: Color(0xff282828),
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Center(
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.65,
//                         child: Text(
//                           localizations?.t('buyCredits.popUpNoCredits'),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xffFFFFFF),
//                             fontSize: 14.0,
//                             fontFamily: 'SansRegular',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Container(
//                       child: ElevatedButton(
//                         // color: Colors.red,
//                         onPressed: () async {
//                           // onPressed();

//                           Navigator.pop(context);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => BuyCredits()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xffBF2328),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                         ),
//                         // color: Colors.red,
//                         child: Text(
//                           "Ok",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'SansRegularlight',
//                             fontSize: 14.0,
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
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: false,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return SizedBox();
//       },
//     );
//   }

//   showgeneralDialogPayPartner() {
//     showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         AppLocalizations? localizations = Localizations.of<AppLocalizations>(
//           context,
//           AppLocalizations,
//         );
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               backgroundColor: Color(0xff282828),
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Center(
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.65,
//                         child: Text(
//                           localizations?.t('buyCredits.popUppayPartner'),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xffFFFFFF),
//                             fontSize: 14.0,
//                             fontFamily: 'SansRegular',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Container(
//                       child: ElevatedButton(
//                         // color: Colors.red,
//                         onPressed: () async {
//                           // Navigator.pop(context);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => TasksPage()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xffBF2328),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                         ),

//                         // color: Colors.red,
//                         child: Text(
//                           "Ok",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'SansRegularlight',
//                             fontSize: 14.0,
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
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: false,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return SizedBox();
//       },
//     );
//   }
// }
