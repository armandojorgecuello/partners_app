// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart' show ChangeNotifier, VoidCallback;
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart' show TextEditingController;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../new_user.dart';

// enum PhoneAuthState {
//   Started,
//   CodeSent,
//   CodeResent,
//   Verified,
//   Failed,
//   Error,
//   AutoRetrievalTimeOut,
// }

// class PhoneAuthDataProvider with ChangeNotifier {
//   final FirebaseAuth? auth;
//   final BuildContext? context;
//   final GlobalKey<NavigatorState>? navKey;

//   PhoneAuthDataProvider(this.auth, this.context, this.navKey);

//   User currentUser() => _user;
//   User _user;
//   VoidCallback onStarted,
//       onCodeSent,
//       onCodeResent,
//       onVerified,
//       onFailed,
//       onError,
//       onAutoRetrievalTimeout;

//   bool _loading = false;

//   final TextEditingController _phoneNumberController = TextEditingController();

//   PhoneAuthState _status;
//   String _actualCode;
//   String _phone, _message;

//   setMethods({
//     VoidCallback onStarted,
//     VoidCallback onCodeSent,
//     VoidCallback onCodeResent,
//     VoidCallback onVerified,
//     VoidCallback onFailed,
//     VoidCallback onError,
//     VoidCallback onAutoRetrievalTimeout,
//     context,
//   }) {
//     this.onStarted = onStarted;
//     this.onCodeSent = onCodeSent;
//     this.onCodeResent = onCodeResent;
//     this.onVerified = onVerified;
//     this.onFailed = onFailed;
//     this.onError = onError;
//     this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;
//     this.context;
//   }

//   Future<bool> instantiate({
//     String dialCode,
//     VoidCallback onStarted,
//     VoidCallback onCodeSent,
//     VoidCallback onCodeResent,
//     VoidCallback onVerified,
//     VoidCallback onFailed,
//     VoidCallback onError,
//     VoidCallback onAutoRetrievalTimeout,
//     context,
//   }) async {
//     this.onStarted = onStarted;
//     this.onCodeSent = onCodeSent;
//     this.onCodeResent = onCodeResent;
//     this.onVerified = onVerified;
//     this.onFailed = onFailed;
//     this.onError = onError;
//     this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;
//     this.context;

//     if (phoneNumberController.text.length < 10) {
//       return false;
//     }
//     phone = dialCode + phoneNumberController.text;
//     _startAuth(context);
//     return true;
//   }

//   // String phoneAuth;
//   _startAuth(context) {
//     codeSent(String verificationId, [int forceResendingToken]) async {
//       actualCode = verificationId;
//       _addStatusMessage("\nEnter the code sent to " + phone);
//       _addStatus(PhoneAuthState.CodeSent);
//       // if (onCodeSent != null) onCodeSent(,);
//     }

//     codeAutoRetrievalTimeout(String verificationId) {
//       actualCode = verificationId;
//       print("nAuto retrieval time out");
//       onAutoRetrievalTimeout();
//     }

//     verificationFailed(AuthException authException) {
//       log(authException.message);
//       _addStatusMessage('${authException.message}');
//       _addStatus(PhoneAuthState.Failed);
//       onFailed();
//       if (authException.message.contains('not authorized')) {
//         _addStatusMessage('App not authroized');
//       } else if (authException.message.contains('Network'))
//         _addStatusMessage(
//           'Please check your internet connection and try again',
//         );
//       else
//         _addStatusMessage(
//           'Something has gone wrong, please try later ' + authException.message,
//         );
//     }

//     verificationCompleted(AuthCredential authCredentialPhone) async {
//       if (Platform.isAndroid) {
//         final User user =
//             (await auth.signInWithCredential(authCredentialPhone)).user;
//         await autoVeryfyOTPLogin(user);
//       } else {
//         print(authCredentialPhone);
//       }
//       _addStatusMessage('Auto retrieving verification code');
//     }

//     _addStatusMessage('Phone auth started');
//     auth.verifyPhoneNumber(
//       phoneNumber: phone.toString(),
//       timeout: Duration(seconds: 60),
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     );
//   }

//   Future autoVeryfyOTPLogin(User user) async {
//     _user = user;
//     String uid = _user.uid;
//     //Provider.of<LoginState>(_context, listen: false).currentUser(uid);
//     String uid1 = user.uid;
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('uid', uid1);
//     pref.setString("type", "phone");
//     //Provider.of<LoginState>(_context, listen: false).loginPhone(user, _context);
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_user.uid)
//         .collection(_user.uid)
//         .doc(_user.uid)
//         .get()
//         .then((value) {
//           if (value.exists) {
//             if (value.data() as Map<String,dynamic>["first_launch"] != true &&
//                 value.data() as Map<String,dynamic>["name"] != null &&
//                 value.data() as Map<String,dynamic>["email"] != null) {
//               navKey.currentState.push(
//                 MaterialPageRoute(
//                   builder: (BuildContext context) => TasksPage(),
//                 ),
//               );
//             } else {
//               navKey.currentState.push(
//                 MaterialPageRoute(builder: (BuildContext context) => NewUser()),
//               );
//             }
//           } else {
//             UsuarioProvider(uid: user.uid).createUserData(
//               true,
//               user.displayName,
//               user.email,
//               '',
//               _phoneAuth ?? "",
//               user.uid,
//               user.photoUrl,
//               true,
//               true,
//             );
//             navKey.currentState.push(
//               MaterialPageRoute(builder: (BuildContext context) => NewUser()),
//             );
//           }
//         });
//   }

//   void verifyOTPAndLogin({String smsCode, BuildContext context}) async {
//     _authCredential = PhoneAuthProvider.getCredential(
//       verificationId: actualCode,
//       smsCode: smsCode,
//     );
//     final User user = (await auth.signInWithCredential(_authCredential)).user;
//     _user = user;
//     Provider.of<LoginState>(context, listen: false).loginPhone(user, context);
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_user.uid)
//         .collection(_user.uid)
//         .doc(_user.uid)
//         .get()
//         .then((value) {
//           if (value.exists) {
//             if (value.data() as Map<String,dynamic>["first_launch"] != true &&
//                 value.data() as Map<String,dynamic>["name"] != null &&
//                 value.data() as Map<String,dynamic>["email"] != null) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => TasksPage()),
//               );
//             } else {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => NewUser()),
//               );
//             }
//           } else {
//             UsuarioProvider(uid: user.uid).createUserData(
//               true,
//               user.displayName,
//               user.email,
//               '',
//               '',
//               user.uid,
//               user.photoUrl,
//               true,
//               true,
//             );
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => NewUser()),
//             );
//           }
//         });
//   }

//   _addStatus(PhoneAuthState state) {
//     status = state;
//   }

//   void _addStatusMessage(String s) {
//     message = s;
//   }

//   get authCredential => _authCredential;

//   set authCredential(value) {
//     _authCredential = value;
//     notifyListeners();
//   }

//   String _phoneAuth;
//   get typeAuth => _phoneAuth;
//   set typeAuth(String type) {
//     _phoneAuth = type;
//     notifyListeners();
//   }

//   get actualCode => _actualCode;

//   set actualCode(String value) {
//     _actualCode = value;
//     notifyListeners();
//   }

//   get phone => _phone;

//   set phone(String value) {
//     _phone = value;
//     notifyListeners();
//   }

//   get message => _message;

//   set message(String value) {
//     _message = value;
//     notifyListeners();
//   }

//   PhoneAuthState get status => _status;

//   set status(PhoneAuthState value) {
//     _status = value;
//     notifyListeners();
//   }

//   bool get loading => _loading;

//   set loading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   TextEditingController get phoneNumberController => _phoneNumberController;
// }
