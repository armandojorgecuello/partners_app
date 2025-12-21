// import 'dart:convert';
// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:honey_iou_updated/phone_auth_temp/providers/phone_auth.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum LoginProvider { GOOGLE, FACEBOOK, APPLE }

// class LoginState with ChangeNotifier {
//   final FirebaseAuth? auth;
//   LoginState(this.auth);

//   bool? _loggedIn = false;
//   String? _userUid;
//   static const MethodChannel _channel = MethodChannel('sign_in');

//   bool isLoggenIn() => _loggedIn!;
//   String currentUser(String value) => _userUid!;
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   User _user;
//   User currentUserData() => _user;

//   void login(
//     BuildContext context,
//     LoginProvider loginProvider,
//     String typeLogin,
//     Function fun,
//   ) async {
//     // print(phoneUser.uid);
//     switch (loginProvider) {
//       case LoginProvider.GOOGLE:
//         _user = await _handleSignIn(fun);
//         String uid = _user.uid;
//         _userUid = uid;
//         break;
//       case LoginProvider.FACEBOOK:
//         _user = await _handleFacebookSignIn(fun);
//         String uid = _user.uid;
//         _userUid = uid;
//         break;
//       case LoginProvider.APPLE:
//         _user = await logInApple(context);
//     }
//     // Navigator.pushReplacementNamed(context, "home_page");

//     _loggedIn = true;
//     notifyListeners();
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setBool('loggedIn', _loggedIn!);
//   }

//   loginPhone( user, BuildContext context) async {
//     _user = user;
//     String uid = _user.uid;
//     _userUid = uid;
//     String uid1 = user.uid;
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('uid', uid1);
//     pref.setString("type", "phone");
//     return user;
//   }

//   void logout(BuildContext context) async {
//     FirebaseAuth authPhone =
//         Provider.of<PhoneAuthDataProvider>(context, listen: false).auth;
//     _facebookLogin.logOut();
//     _loggedIn = false;
//     notifyListeners();
//     _googleSignIn.signOut();
//     _loggedIn = false;
//     notifyListeners();
//     authPhone.signOut();
//     Navigator.of(
//       context,
//     ).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.clear();
//     pref.setBool('loggedIn', _loggedIn!);
//   }

//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

//   Future<User> _handleSignIn(Function fun) async {
//     final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
//     final GoogleSignInAuthentication googleAuth = googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.idToken,
//       idToken: googleAuth.idToken,
//     );
//     final User? user = (await auth?.signInWithCredential(credential)).user;
//     String? uid = user?.uid;
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('uid', uid!);
//     final DocumentSnapshot result =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uid)
//             .collection(user.uid)
//             .doc(user.uid)
//             .get();
//     if (result.exists) {
//       return user;
//     } else {
//       await UsuarioProvider(uid: user.uid).createUserData(
//         true,
//         user.displayName,
//         user.email,
//         '',
//         '',
//         user.uid,
//         user.photoUrl,
//         true,
//         true,
//       );
//     }
//     return user;
//   }

//   initNotificactions() async {
//     _firebaseMessaging.requestNotificationPermissions();
//     var token = _firebaseMessaging.getToken().toString();
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_user.uid)
//         .collection(_user.uid)
//         .doc(_user.uid)
//         .updateData({'token': token});
//   }

//   final _facebookLogin = FacebookLogin();

//   Future<User> _handleFacebookSignIn(Function func) async {
//     try {
//       final result = await _facebookLogin.logIn(['email']);
//       _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

//       switch (result.status) {
//         case FacebookLoginStatus.loggedIn:
//           final FacebookAccessToken accessToken = result.accessToken;
//           print(accessToken.userId);
//           final AuthCredential credential = FacebookAuthProvider.getCredential(
//             accessToken: result.accessToken.token,
//           );
//           final graphResponse = await http.get(
//             'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(150).height(150)&access_token=${result.accessToken.token}, ',
//           );
//           final profile = await json.decode(graphResponse.body);
//           print(profile);
//           UserCredential resultAuth = await auth.signInWithCredential(
//             credential,
//           );
//           User user = resultAuth.user;
//           String uid = user.uid;
//           SharedPreferences pref = await SharedPreferences.getInstance();
//           pref.setString('uid', uid);
//           final DocumentSnapshot result =
//               await FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user.uid)
//                   .collection(user.uid)
//                   .doc(user.uid)
//                   .get();
//           if (result.exists) {
//             return user;
//           } else {
//             await UsuarioProvider(uid: user.uid).createUserData(
//               true,
//               user.displayName,
//               user.email,
//               '',
//               '',
//               user.uid,
//               profile["picture"]["data"]["url"],
//               true,
//               true,
//             );
//           }
//           return user;
//           break;
//         case FacebookLoginStatus.cancelledByUser:
//           func();
//           break;
//         case FacebookLoginStatus.error:
//           print('${result.errorMessage}');
//           break;
//       }
//     } on PlatformException catch (e) {
//       log(e.message);
//     }
//   }

//   Future<User> logInApple(context) async {
//     if (!await AppleSignIn.isAvailable()) {
//       print("No esta disp");
//       return null; //Break from the program
//     }

//     final AuthorizationResult result = await AppleSignIn.performRequests([
//       AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName]),
//     ]);

//     switch (result.status) {
//       case AuthorizationStatus.authorized:
//         final AppleIdCredential appleIdCredential = result.credential;

//         OAuthProvider oAuthProvider = OAuthProvider(providerId: "apple.com");
//         final AuthCredential credential = oAuthProvider.getCredential(
//           idToken: String.fromCharCodes(appleIdCredential.identityToken),
//           accessToken: String.fromCharCodes(
//             appleIdCredential.authorizationCode,
//           ),
//         );

//         final User user = (await auth.signInWithCredential(credential)).user;

//         //user.uid = user.uid;
//         final DocumentSnapshot result =
//             await FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(user.uid)
//                 .collection(user.uid)
//                 .doc(user.uid)
//                 .get();
//         if (result.exists) {
//           return user;
//         } else {
//           await UsuarioProvider(uid: user.uid).createUserData(
//             true,
//             appleIdCredential.fullName.givenName +
//                 appleIdCredential.fullName.familyName,
//             appleIdCredential.email,
//             '',
//             '',
//             user.uid,
//             user.photoUrl,
//             true,
//             true,
//           );
//         }
//         return user;
//         break;

//       case AuthorizationStatus.error:
//         print("Sign in failed: ${result.error.localizedDescription}");

//         break;

//       case AuthorizationStatus.cancelled:
//         print('User cancelled');
//         break;
//     }
//   }
// }
