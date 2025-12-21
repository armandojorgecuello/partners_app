// import 'package:flutter/material.dart';
// import 'package:honeyiou/utils/locale_app.dart';

// class PrivacityPolicyPage extends StatelessWidget {
//   const PrivacityPolicyPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//   AppLocalizations localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             children: [
//               GestureDetector(
//                 child: SizedBox(
//                   height: 40.0,
//                   width: 100.0,
//                   // color:Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.arrow_back_ios, color: Colors.white),
//                       Text(
//                         localizations.t('privacyPolicy.back'),
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () => Navigator.pushNamed(context, "setting"),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width*0.05),
//               Text(
//                 localizations.t('privacyPolicy.title')
//               ),
//             ],
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//           // backgroundColor: Colors.red,
//           automaticallyImplyLeading: false,
//         ),
//           backgroundColor: Color(0xff393939),
//         // backgroundColor: Colors.grey[900],
//         body: _body(),
//       ),
//     );
//   }

//   Widget _body() {
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(
//               top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
//             child: Text(
//               "Velit ipsum aliqua voluptate nulla ipsum ea non irure adipisicing voluptate.",
//               style: TextStyle(color: Colors.white, fontSize: 15.0),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 10.0),
//             child: Text(
//               "Cupidatat dolore Lorem officia culpa Lorem est. Ex excepteur ad quis enim. Minim in sit amet ea labore qui elit labore incididunt. Aute mollit culpa veniam dolore cupidatat incididunt sint esse est ipsum laborum ad ad. Nostrud exercitation proident enim duis ullamco duis ex deserunt id nisi proident ut. Qui do ullamco ipsum cupidatat minim adipisicing eu ullamco quis nulla excepteur ut.Sunt pariatur aliquip mollit est non adipisicing ipsum. Aute reprehenderit ipsum et sunt in consequat nisi laboris fugiat. Sit dolore sunt adipisicing ut laboris non.Anim ea ad occaecat duis quis adipisicing velit labore non in tempor deserunt. Dolore laborum laborum esse consequat laborum quis exercitation duis culpa labore sunt sunt deserunt exercitation. Exercitation incididunt ea amet aliquip. Deserunt id commodo nisi fugiat in laboris laborum ullamco proident sint. Dolore ex esse sunt labore labore magna.",
//               style: TextStyle(color: Colors.white, fontSize: 14.0),
//               textAlign: TextAlign.justify,
//             )
//           ),
//           Container(
//             padding: EdgeInsets.only(
//                 top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
//             child: Text(
//               "Velit ipsum aliqua voluptate nulla ipsum ea non irure adipisicing voluptate.",
//               style: TextStyle(color: Colors.white, fontSize: 15.0),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 10.0),
//             child: Text(
//               "Cupidatat dolore Lorem officia culpa Lorem est. Ex excepteur ad quis enim. Minim in sit amet ea labore qui elit labore incididunt. Aute mollit culpa veniam dolore cupidatat incididunt sint esse est ipsum laborum ad ad. Nostrud exercitation proident enim duis ullamco duis ex deserunt id nisi proident ut. Qui do ullamco ipsum cupidatat minim adipisicing eu ullamco quis nulla excepteur ut. Aliquip ea et est ipsum elit anim ad nostrud est anim sint. Anim minim aliqua eu minim magna reprehenderit exercitation aliquip aute tempor magna ad incididunt. Do laboris enim ullamco esse.",
//               style: TextStyle(color: Colors.white, fontSize: 14.0),
//               textAlign: TextAlign.justify,
//             )
//           ),
//         ],
//       ),
//     );
//   }
// }
