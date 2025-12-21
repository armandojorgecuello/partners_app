// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honey_iou_updated/src/providers/partner_provider.dart';
// import 'package:honey_iou_updated/src/widget/show_dialog_task_end.dart';

// import 'locale_app.dart';

// class ValidatePartnerReques {
//   Future<void> validate(String senderUid, String receiverUid, context) async {
//     AppLocalizations? localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(receiverUid)
//         .collection(receiverUid)
//         .doc(receiverUid)
//         .get()
//         .then((futurePartnerData) {
//           FirebaseFirestore.instance
//               .collection('partner_requests')
//               .doc(receiverUid)
//               .collection(receiverUid)
//               .doc(senderUid)
//               .get()
//               .then((partnerRequestResponse) {
//                 if (partnerRequestResponse.exists) {
//                   Navigator.of(context).pop();
//                   _showDialog(
//                     localizations?.t(
//                       "addPartners.popUpPartnerRequesExistsTitle",
//                     ),
//                     localizations?.t("addPartners.popUpPartnerRequesExistsDesc"),
//                     context,
//                     localizations,
//                   );
//                 } else {
//                   FirebaseFirestore.instance
//                       .collection('partners_accepted')
//                       .doc(senderUid)
//                       .collection(senderUid)
//                       .doc(receiverUid)
//                       .get()
//                       .then((partnerAcceptedResponse) {
//                         if (partnerAcceptedResponse.exists) {
//                           Navigator.of(context).pop();
//                           _showDialog(
//                             localizations?.t(
//                               "addPartners.popUpPartnerAccepExistsTitle",
//                             ),
//                             localizations?.t(
//                               "addPartners.popUpPartnerAccepExistsDesc",
//                             ),
//                             context,
//                             localizations,
//                           );
//                         } else {
//                           PartnerProvider(uid: senderUid)
//                               .createPartnerRequest(
//                                 receiverUid,
//                                 senderUid,
//                                 DateTime.now(),
//                               )
//                               .then((value) {
//                                 Navigator.of(context).pop();
//                                 ShowDialogBoxFinish().showDialogAfterScan(
//                                   senderUid,
//                                   receiverUid,
//                                   localizations,
//                                   context,
//                                   "${futurePartnerData.data()!["name"]}",
//                                   () {},
//                                 );
//                               });
//                         }
//                       });
//                 }
//               });
//         });
//   }

//   _showDialog(String title, String desc, BuildContext context, localizations) {
//     return showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               backgroundColor: Color(0xff282828),
//               // backgroundColor: ,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               content: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegular',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   Text(
//                     desc,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegularlight',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       localizations.t('addPartners.showDialogButtom'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'SansRegularlight',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return Container();
//       },
//     );
//   }
// }
