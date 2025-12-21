// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/task_model.dart';
// import 'package:honeyiou/utils/locale_app.dart';

// class ViewTask extends StatefulWidget {
//   const ViewTask({super.key});

//   @override
//   _ViewTaskState createState() => _ViewTaskState();
// }

// class _ViewTaskState extends State<ViewTask> {
//   final docTaskSelect = DocTaskSelected.docSnapshot;
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xff393939),
//         // backgroundColor: Colors.grey[800],
//         appBar: AppBar(
//           backgroundColor: const Color(0xff7a1418),
//           title: Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 elevation: 0.0,
//                 color: const Color(0xff7a1418),
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.arrow_back_ios, color: Colors.white),
//                     Text(
//                       localizations.t('viewTask.back'),
//                       style: TextStyle(color: Colors.white, fontSize: 20.0),
//                     ),
//                   ],
//                 ),
//                 // color: Colors.red,
//               ),
//               Text(localizations.t('viewTask.title')),
//             ],
//           ),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//         ),
//         body: SafeArea(
//           child: SizedBox.expand(
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(height: 20.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Container(
//                       child: Text(
//                         localizations.t('viewTask.rewardDescription'),
//                         style: TextStyle(color: Colors.white, fontSize: 15.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Text(
//                       docTaskSelect.data() as Map<String,dynamic>['reward_description'],
//                       style: TextStyle(color: Colors.white, fontSize: 15.0),
//                     ),
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Divider(color: Colors.white),
//                   ),
//                   SizedBox(height: 20.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Text(
//                       localizations.t('viewTask.rewardImage'),
//                       style: TextStyle(color: Colors.white, fontSize: 15.0),
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                   Center(
//                     child: Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         width: MediaQuery.of(context).size.width * 0.95,
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20.0),
//                             child: Image(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(
//                                 docTaskSelect.data() as Map<String,dynamic>['reward_img_url'],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   // Di
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
