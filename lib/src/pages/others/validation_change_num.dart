// import 'package:flutter/material.dart';

// class ChangeNumber extends StatelessWidget {
//   const ChangeNumber({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final query = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey[900],
//         appBar: AppBar(
//           title: Text('Change phone number'),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//           automaticallyImplyLeading: false,
//           //toolbarOpacity: 0.0,
//           flexibleSpace: Positioned(
//             top: 06.0,
//             left: 0.0,
//             child: ElevatedButton(
//               onPressed: () => Navigator.pushNamed(context, "setting"),
//               elevation: 0.0,
//               color: Colors.red,
//               child: Row(
//                 children: <Widget>[
//                   Icon(Icons.arrow_back_ios, color: Colors.white),
//                   Text(
//                     "Back",
//                     style: TextStyle(color: Colors.white, fontSize: 15.0),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: SizedBox(
//           height: query.height,
//           width: query.width,
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 30.0),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Text(
//                       "Enter your validation code",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 40.0),
//               _codeValue(query),
//               SizedBox(height: 40.0),
//               Text(
//                 "I havent received a validation code"
//                 " Resend",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _codeValue(query) {
//   return SingleChildScrollView(
//     child: Padding(
//       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//       child: SizedBox(
//         width: query.width,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: TextField(
//                 decoration: InputDecoration(border: InputBorder.none),
//               ),
//             ),

//             Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: TextField(
//                 textInputAction: TextInputAction.next,
//                 decoration: InputDecoration(border: InputBorder.none),
//               ),
//             ),

//             Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: TextField(
//                 decoration: InputDecoration(border: InputBorder.none),
//               ),
//             ),

//             Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: TextField(
//                 decoration: InputDecoration(border: InputBorder.none),
//               ),
//             ),
//             Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: TextField(
//                 decoration: InputDecoration(border: InputBorder.none),
//               ),
//             ),

//             Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: TextField(
//                 decoration: InputDecoration(border: InputBorder.none),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
