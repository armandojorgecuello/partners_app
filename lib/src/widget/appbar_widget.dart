// import 'package:flutter/material.dart';

// class AppBarWidget extends StatelessWidget {
//   final String title;
//   final String buttontext;

//   const AppBarWidget({Key key, this.title, this.buttontext}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
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
//                       buttontext,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ),
//           Text(
//             title,
//             style: TextStyle(color: Colors.white),
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 5.0, right: 5.0),
//               child: Container()
//             )
//           ),
//         ],
//       ),
//       centerTitle: true,
//       backgroundColor: const Color(0xff7a1418),
//       automaticallyImplyLeading: false,
//     );
//   }
// }