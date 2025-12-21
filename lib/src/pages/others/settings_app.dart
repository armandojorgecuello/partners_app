// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:honeyiou/src/widget/appbar_widget.dart';
// import 'package:provider/provider.dart';

// import 'package:honeyiou/partaners/partner_accept_list.dart';
// import 'package:honeyiou/src/pages/images/my_images_page.dart';
// import 'package:honeyiou/src/pages/more/notifications.dart';
// import 'package:honeyiou/src/pages/more/privacity_policy_page.dart';
// import 'package:honeyiou/src/pages/more/support_ticket.dart';
// import 'package:honeyiou/src/pages/more/terms_services_page.dart';
// import 'package:honeyiou/src/pages/task/negociation.dart';
// import 'package:honeyiou/src/providers/login_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'phone_number.dart';
// import 'profile_page.dart';

// class UserSettings extends StatefulWidget {
//   const UserSettings({super.key});

//   @override
//   _UserSettingsState createState() => _UserSettingsState();
// }

// class _UserSettingsState extends State<UserSettings> {
//   final String _text = "My Account";
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final query = MediaQuery.of(context).size;
//     return SafeArea(
//       child: SizedBox(
//         width: query.width,
//         height: query.height,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                     child: GestureDetector(
//                       onTap:
//                           () => Navigator.of(context).push(
//                             MaterialPageRoute(builder: (_) => TasksPage()),
//                           ),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.arrow_back_ios, color: Colors.white),
//                           Text(
//                             localizations.t('setting.back'),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   localizations.t('setting.settings'),
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                     child: Container(),
//                   ),
//                 ),
//               ],
//             ),
//             centerTitle: true,
//             backgroundColor: const Color(0xff7a1418),
//             automaticallyImplyLeading: false,
//           ),
//           backgroundColor: Color(0xff393939),
//           body: ListView(
//             children: <Widget>[
//               _myAccount(localizations),
//               SizedBox(height: 40.0),
//               _notifications(localizations),
//               SizedBox(height: 40.0),
//               _more(localizations),
//               SizedBox(height: 40.0),
//               _sign(localizations),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _myAccount(localizations) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
//             title: Text(
//               localizations.t('setting.myAccount'),
//               style: TextStyle(fontSize: 20.0, color: Colors.white),
//             ),
//           ),
//           Divider(color: Colors.white),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.myProfile'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(
//                 context,
//               ).push(CupertinoPageRoute(builder: (context) => ProfilePage()));
//             },
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 3.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.myPartner'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 CupertinoPageRoute(builder: (context) => PartnersAccepted()),
//               );
//             },
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 3.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.myImages'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(
//                 context,
//               ).push(CupertinoPageRoute(builder: (context) => ImagesPage()));
//             },
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 3.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.changePhone'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 CupertinoPageRoute(builder: (context) => PhoneNumberPage()),
//               );
//             },
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 3.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.extraSecurity'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               // Navigator.of(context).push(CupertinoPageRoute(
//               // builder: (context) => ChatPage(),
//               // ));
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _notifications(localizations) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
//             title: Text(
//               localizations.t('setting.notifications'),
//               style: TextStyle(fontSize: 20.0, color: Colors.white),
//             ),
//           ),
//           Divider(color: Colors.white),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.confiNotify'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 CupertinoPageRoute(builder: (context) => NotificationsPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _more(localizations) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
//             title: Text(
//               localizations.t('setting.more'),
//               style: TextStyle(fontSize: 20.0, color: Colors.white),
//             ),
//             onTap: () {
//               Firestore db = FirebaseFirestore.instance;
//               final pref = UserPreferences();
//               String user = pref.uid;
//             },
//           ),
//           Divider(color: Colors.white),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.privPolicy'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 CupertinoPageRoute(builder: (context) => PrivacityPolicyPage()),
//               );
//             },
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 3.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.termsServ'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 CupertinoPageRoute(builder: (context) => TermsOfServicePage()),
//               );
//               // Navigator.pushNamed(context, 'terms_service');
//             },
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 3.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.frequentlyQuestions'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 3.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//             title: Text(
//               localizations.t('setting.support'),
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 CupertinoPageRoute(builder: (context) => SupportTicketsPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sign(localizations) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.red),
//             title: Text(
//               "Sign Out",
//               style: TextStyle(fontSize: 16.0, color: Colors.red),
//             ),
//             onTap: () {
//               Provider.of<LoginState>(context, listen: false).logout(context);
//             },
//           ),
//           Divider(color: Colors.white),
//         ],
//       ),
//     );
//   }
// }
