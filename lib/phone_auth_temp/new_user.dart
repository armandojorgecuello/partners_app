// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/phone_auth_temp/providers/phone_auth.dart';
// import 'package:honeyiou/src/models/profile_model.dart';
// import 'package:honeyiou/src/pages/others/profile_picture.dart';
// import 'package:honeyiou/src/pages/task/negociation.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';

// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:provider/provider.dart';

// class NewUser extends StatefulWidget {
//   const NewUser({Key key}) : super(key: key);

//   @override
//   _NewUserState createState() => _NewUserState();
// }

// class _NewUserState extends State<NewUser> with TickerProviderStateMixin {
//   final formKey = GlobalKey<FormState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   bool partnerCheck = false;
//   bool acceptTerms = false;

//   String _name;
//   String _preferences;
//   String _email;
//   String _username;
//   String _cel_number;
//   String _uid;
//   String _photo_url;
//   getname(name) {
//     _name = name;
//   }

//   getpreferences(preferences) {
//     _preferences = preferences;
//   }

//   getusername(username) {
//     _username = username;
//   }

//   getemail(email) {
//     _email = email;
//   }

//   // User user;
//   bool loading;
//   AnimationController _controller;
//   Animation<double> _animation;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );

//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var query = MediaQuery.of(context).size;
//     final pref = UserPreferences();
//     String user = pref.uid;
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Color(0xff393939),
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               // Expanded(
//               //   child: Container(
//               //     padding: EdgeInsets.only(left: 5.0, right: 5.0),
//               //     child: GestureDetector(
//               //       onTap: () => Navigator.of(context).pop(),
//               //       child: Row(
//               //         children: <Widget>[
//               //           Icon(Icons.arrow_back_ios, color: Colors.white),
//               //           Text(
//               //             localizations.t('profilePage.back'),
//               //             style: TextStyle(
//               //               color: Colors.white,
//               //               fontSize: 20.0,
//               //               fontWeight: FontWeight.bold
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //   )
//               // ),
//               Text(
//                 localizations.t('profilePage.titleProfile'),
//                 style: TextStyle(color: Colors.white),
//               ),
//               // Expanded(
//               // child: Container(
//               // padding: EdgeInsets.only(left: 5.0, right: 5.0),
//               // child: Container()
//               // )
//               // ),
//             ],
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//           automaticallyImplyLeading: false,
//         ),
//         body: userform(localizations),
//       ),
//     );
//   }

//   Widget userform(localizations) {
//     final pref = UserPreferences();
//     var query = MediaQuery.of(context).size;
//     String user = pref.uid;
//     return StreamBuilder<UserData>(
//       stream: UsuarioProvider(uid: user).userData,
//       builder: (context, AsyncSnapshot<UserData> snapshot) {
//         // if(snapshot.hasData == false)return Container(child:Center(child: CircularProgressIndicator(),) ,);
//         UserData userData;
//         if (snapshot.hasData == true) {
//           userData = snapshot.data;
//         }
//         return SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: 20.0),
//                 Center(
//                   child: FadeTransition(
//                     opacity: _animation,
//                     child: ProfilePicture(),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//                 titleFiel(localizations.t('profileInputs.name')),
//                 texFormField(
//                   localizations.t('profileInputs.nameLabel'),
//                   "name",
//                 ),
//                 SizedBox(height: 20.0),
//                 titleFiel(localizations.t('profileInputs.preferences')),
//                 texFormField(
//                   localizations.t('profileInputs.preferencesText'),
//                   "preferences",
//                 ),
//                 SizedBox(height: 20.0),
//                 titleFiel(localizations.t('profileInputs.email')),
//                 // Campo de correo
//                 FadeTransition(
//                   opacity: _animation,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                     child: TextFormField(
//                       validator: _validateEmail,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         hintText: localizations.t('profileInputs.emailLabel'),
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                           fontFamily: 'SansRegularlight',
//                           fontSize: 14.0,
//                         ),
//                       ),
//                       onChanged: (String pref) {
//                         getemail(pref);
//                       },
//                       cursorColor: Colors.grey,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//                 CheckboxListTile(
//                   title: Text(
//                     localizations.t('profileInputs.partnerCheck'),
//                     style: TextStyle(color: Colors.white, fontSize: 13.0),
//                   ),
//                   value: userData?.partnerCheck ?? true,
//                   onChanged: (value) async {
//                     partnerCheck = value;
//                     await UsuarioProvider(
//                       uid: user,
//                     ).updatepartnerCheck(partnerCheck);
//                   },
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 CheckboxListTile(
//                   title: Text(
//                     localizations.t('profileInputs.accepTerms'),
//                     style: TextStyle(color: Colors.white, fontSize: 13.0),
//                   ),
//                   value: userData?.acceptTerms ?? true,
//                   onChanged: (value) async {
//                     acceptTerms = value;
//                     await UsuarioProvider(
//                       uid: user,
//                     ).updatacceptTerms(acceptTerms);
//                   },
//                 ),
//                 SizedBox(height: query.height * 0.06),
//                 Center(child: _bottom(query, userData, localizations)),
//                 SizedBox(height: 20.0),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget titleFiel(String title) {
//     return FadeTransition(
//       opacity: _animation,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14.0,
//             fontFamily: 'Sans',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget texFormField(String hintText, String type) {
//     return FadeTransition(
//       opacity: _animation,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//         child: TextFormField(
//           validator: validator,
//           textCapitalization: TextCapitalization.sentences,
//           decoration: InputDecoration(
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             hintText: hintText,
//             hintStyle: TextStyle(
//               color: Colors.grey,
//               fontFamily: 'SansRegularlight',
//               fontSize: 14.0,
//             ),
//           ),
//           onChanged: (String value) {
//             if (type == "preferences") {
//               getpreferences(value);
//             } else {
//               getname(value);
//             }
//           },
//           cursorColor: Colors.grey,
//           style: TextStyle(
//             color: Colors.grey,
//             fontSize: 14.0,
//             fontFamily: 'SansRegularlight',
//           ),
//         ),
//       ),
//     );
//   }

//   String validator(String value) {
//     if (value.isEmpty) {
//       return 'Empty camp';
//     } else {
//       return null;
//     }
//   }

//   String _validateEmail(String value) {
//     if (value.isEmpty) {
//       return 'Empty camp!';
//     }
//     // Regex para validación de email
//     String p =
//         "[a-zA-Z0-9+._%-+]{1,256}"
//         "\\@"
//         "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
//         "("
//         "\\."
//         "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
//         ")+";
//     RegExp regExp = RegExp(p);
//     if (regExp.hasMatch(value)) {
//       return null;
//     }
//     return 'Enter your e-mail';
//   }

//   Widget _bottom(query, UserData userData, localizations) {
//     final phone = Provider.of<PhoneAuthDataProvider>(context).phone;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       child: ElevatedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//         color: const Color(0xff7a1418),
//         child: Container(
//           // height: _query.height * 0.06,
//           // width: _query.width * 0.8,
//           child: Center(
//             child: Text(
//               localizations.t('profileInputs.textButtomProfile'),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 15.0,
//                 fontFamily: 'SansRegularlight',
//               ),
//             ),
//           ),
//         ),
//         onPressed: () async {
//           final pref = UserPreferences();
//           String user = pref.uid;
//           if (formKey.currentState!.validate()) {
//             await UsuarioProvider(uid: user)
//                 .user_update_data(
//                   _name ?? userData.name,
//                   _email ?? userData.email,
//                   _preferences ?? userData.preferences,
//                   _cel_number ?? "",
//                   _uid ?? user,
//                 )
//                 .whenComplete(
//                   () => Navigator.pushReplacementNamed(context, "home_page"),
//                 );
//           }
//         },
//       ),
//     );
//   }
// }
