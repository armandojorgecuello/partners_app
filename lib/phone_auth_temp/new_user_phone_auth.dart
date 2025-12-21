// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/models/profile_model.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// import 'firebase/auth/phone_auth/get_phone.dart';

// class NewUserPhoneAuth extends StatefulWidget {
//   @override
//   _NewUserPhoneAuthState createState() => _NewUserPhoneAuthState();
// }

// class _NewUserPhoneAuthState extends State<NewUserPhoneAuth> with TickerProviderStateMixin {
//   final formKey = GlobalKey<FormState>();
//   bool partnerCheck = false;
//   bool acceptTerms = false;

//   String _name;
//   String _preferences;
//   String _email;
//   String _cel_number;
//   String _uid;
//   String _photo_url;
//   getname(name) {
//     this._name = name;
//   }

//   getpreferences(preferences) {
//     this._preferences = preferences;
//   }

//   getemail(email) {
//     this._email = email;
//   }
//   // User user;
//   AnimationController _controller;
//   Animation<Offset> _offsetFloatTitle;
//   Animation<Offset> _offsetFloatButtom;

//   @override
//   void initState() { 
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );

//     _offsetFloatTitle = Tween<Offset>(begin: Offset(0.0, -2), end: Offset(0.0, 0))
//     .animate(_controller);
//     _controller.forward();


//     _offsetFloatButtom =  Tween<Offset>(begin: Offset(0.0, 1), end: Offset(0.0, 0))
//     .animate(_controller);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }



//   @override
//   Widget build(BuildContext context) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     final _query = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xff393939),
//         // backgroundColor: Colors.grey[900],
//         body: Stack(
//           children: <Widget>[
//             _userForm(_query, context, user),
//           ],
//         )
//       ),
//     );
//   }

//   Widget _userForm(_query, BuildContext context, user) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
//     if (user != null) {
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//         child: StreamBuilder(
//           stream: UsuarioProvider(uid: user).userData,
//           builder: (context, snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting) return Container(child: Center(child: CircularProgressIndicator(),),);
//             if (snapshot.hasData) {
//               UserData userData = snapshot.data;
//               print(snapshot.data);
//               return SingleChildScrollView(
//                 child: Form(
//                   key: formKey,
//                   child: SlideTransition(
//                     position: _offsetFloatButtom,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[ 
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         Text(
//                           localizations.t('profileInputs.name'),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         TextFormField(
//                           initialValue: userData.name,
//                           style: TextStyle(color: Colors.white),
//                           onChanged: (String name,) {
//                             getname(name ?? userData.name);
//                           },
//                           validator: (value) {
//                             if (value.isEmpty) {
//                               return 'Enter your Name';
//                             } else {
//                               return null;
//                             }
//                           },
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             labelText: 
//                             localizations.t('profileInputs.nameLabel'),
//                             labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
//                           ),
//                         ),SizedBox(
//                           height: 10.0,
//                         ),
//                         Text(
//                           localizations.t('profileInputs.preferences'),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         TextFormField(
//                           initialValue: userData.preferences,
//                           style: TextStyle(color: Colors.white),
//                           onChanged: (String preferences) {
//                             getpreferences(preferences ?? userData.preferences);
//                           },
//                           validator: (value) {
//                             if (value.isEmpty) {
//                               return 'Enter your Preferences';
//                             } else {
//                               return null;
//                             }
//                           },
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             labelText:localizations.t('profileInputs.preferencesText'), 
//                             labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
//                             helperText:
//                             localizations.t('profileInputs.preferencestextHelper'), 
//                             helperMaxLines: 3,
//                             helperStyle: TextStyle(color: Colors.grey)
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         Text(
//                           localizations.t('profileInputs.email'),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         TextFormField(
//                           initialValue: userData.email,
//                           style: TextStyle(color: Colors.white),
//                           validator: _validateEmail,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             labelText: localizations.t('profileInputs.emailLabel'),
//                             labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
//                           ),
//                           onChanged: (String email) {
//                             getemail(email ?? userData.email);
//                           }
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         CheckboxListTile(
//                           title: Text(
//                             localizations.t('profileInputs.partnerCheck'),
//                             style: TextStyle(color: Colors.white, fontSize: 13.0),
//                           ),
//                           value: userData.partnerCheck ,
//                           onChanged: (value) async{
//                             partnerCheck = value;
//                             await UsuarioProvider(uid:user).updatepartnerCheck(partnerCheck);
//                           }
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         CheckboxListTile(
//                           title: Text(
//                             localizations.t('profileInputs.accepTerms'),
//                             style: TextStyle(color: Colors.white, fontSize: 13.0),
//                           ),
//                           value: userData.acceptTerms ,
//                           onChanged: (value) async{
//                             acceptTerms = value;
//                             await UsuarioProvider(uid:user).updatacceptTerms(acceptTerms);
//                           }
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         _bottom(_query, userData, localizations),
//                         SizedBox(
//                           height: 20.0,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           }
//         ),
//       );
//     }else{
//       return LoginPage();
//     }
//   }

//   String _validateEmail(String value) {
//     if (value.isEmpty) {
//       return 'Empty camp!';
//     }
//     // Regex para validación de email
//     String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
//       "\\@" +
//       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
//       "(" +
//       "\\." +
//       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
//       ")+";
//     RegExp regExp = new RegExp(p);
//     if (regExp.hasMatch(value)) {
//       return null;
//     }
//     return 'Enter your e-mail';
//   }

//   Widget _bottom(_query, UserData userData, localizations) {
//     return ElevatedButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(50.0),
//       ),
//       elevation: 0.0,
//       color: const Color(0xff7a1418),
//       child: Container(
//         height: _query.height * 0.08,
//         width: _query.width * 0.8,
//         padding: EdgeInsets.symmetric(horizontal: 127.0,) ,
//         child: Row(
//           children: <Widget>[
//             Text(
//               localizations.t('profileInputs.textButtomProfile'),
//               style: TextStyle(color: Colors.white, fontSize: 15.0),
//             ),
//           ],
//         ),
//       ),
//       onPressed: () async {
//       final pref = UserPreferences();
//       String user = pref.uid;        
//         if (formKey.currentState!.validate()) {
//           await UsuarioProvider(uid: user).user_update_data(
//             _name ?? userData.name,
//             _email ?? userData.email,
//             _preferences ?? userData.preferences,
//             _cel_number ?? userData.celNumber,
//             _uid ?? user,
//           ).whenComplete(
//             () => Scaffold.of(context).showSnackBar(
//               SnackBar(
//                 duration: Duration(seconds:4),
//                 content: Text(
//                   localizations.t('profileInputs.snackBarText')
//                   // 'Your profile has been updated'
//                   , style: TextStyle(color:Colors.white),
//                 ),
//               )
//             )
//           );
//         }
//       },
//     );
//   }

// }

// // class SettingPage extends StatefulWidget {
// //   final String userUid;

// //   const SettingPage({Key key, this.userUid}) : super(key: key);


// //   @override
// //   _SettingPageState createState() => _SettingPageState();
// // }

// // class _SettingPageState extends State<SettingPage> {
// //   final _formKey = GlobalKey<FormState>();

// //   String _firstName;
// //   String _lastName;
// //   String _about;
// //   String _instaUser;
// //   String _facebookUser;
// //   String _twitterUser;
    
// //   getfirtsName(fstname) {
// //     this._firstName = fstname;
// //   }

// //   getLastName(lstName) {
// //     this._lastName = lstName;
// //   }

// //   getabout(abt) {
// //     this._about = abt;
// //   }

// //   getInsta(instaU) {
// //     this._instaUser = instaU;
// //   }

// //   getfacebookUser(fbUser) {
// //     this._facebookUser = fbUser;
// //   }

// //   gettwitterUSer(twUser) {
// //     this._twitterUser = twUser;
// //   }



// //   static File galleryFile;
// //   static Future<File> imageFile;
// //   bool isSending = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final pref = new UserPref();
// //     final user = Provider.of<SignInProvider>(context, listen: false );
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         appBar: AppBar(
// //           elevation: 0.0,
// //           centerTitle: true,
// //           title: Text("Settings", style:TextStyle(color:Colors.black)),
// //           backgroundColor: Colors.white,
// //           leading: IconButton(
// //             icon: Icon(
// //               Icons.keyboard_backspace,
// //               size: 22,
// //               color: Colors.black,
// //             ),
// //             onPressed: () => Navigator.of(context).pop()
// //           ),
// //         ),
// //         body: StreamBuilder<Event>(
// //           stream: user.getUserData(widget.userUid),
// //           builder: (context,AsyncSnapshot<Event> snapshot) {
// //             if(snapshot.hasData){
// //               return Stack(
// //                 children: [
// //                   _formSetting(snapshot.data.snapshot.value),   
// //                 ],
// //               );
// //             }else{
// //               return Container();
// //             }
// //           }
// //         )
// //       ),
// //     );
// //   }

// //   Widget _formSetting(dynamic dataUser){
// //     Map<dynamic, dynamic> user = Map.from(dataUser);
// //     final userdata = Provider.of<SignInProvider>(context, listen: false );
// //     return Padding(
// //       padding: EdgeInsets.only(left:20.0, right: 20.0),
// //       child: SingleChildScrollView(
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center, 
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               dataUser["img_url"] == null || dataUser["img_url"] == "" ? GestureDetector(
// //                 onTap: () => _select(dataUser["uid"]),
// //                 child: CircleAvatar(
// //                   backgroundColor: Colors.grey[200],
// //                   backgroundImage: AssetImage("assets/profile.png",),
// //                   radius: 45,
// //                 ),
// //               ) :GestureDetector(
// //                 onTap: () => _select(dataUser["uid"]),
// //                 child: CircleAvatar(
// //                   backgroundColor: Colors.grey[200],
// //                   backgroundImage: CachedNetworkImageProvider(dataUser["img_url"],),
// //                   radius: 45,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               Container(
// //                 // width: MediaQuery.of(context).size.width*0.87,
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center, 
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     Icon(Icons.person,size:25.0),
// //                     SizedBox(width: 5.0,),
// //                     Container(
// //                       // color:Colors.red,
// //                       width: MediaQuery.of(context).size.width*0.84,
// //                       child: Center(
// //                         child: Text(
// //                           dataUser["first_name"] + " "  +  dataUser["last_name"] ?? '', 
// //                           style: TextStyle(fontSize: 25.0),
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 40,
// //               ),
// //               TextFormField(
// //                 autofocus: false,
// //                 textCapitalization: TextCapitalization.sentences,
// //                 textAlignVertical: TextAlignVertical.center,
// //                 initialValue: dataUser["first_name"],
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(Icons.person),
// //                   contentPadding: EdgeInsets.only(left:10.0),
// //                   labelText: "First name",
// //                   labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
// //                 ),
// //                 onChanged: (name) {
// //                   getfirtsName(name);
// //                 },
// //                 validator: (value) {
// //                   if (value.isEmpty) {
// //                     return 'Enter your Name';
// //                   } else {
// //                     return null;
// //                   }
// //                 },
// //                 keyboardType: TextInputType.text,
// //               ),
// //               SizedBox(height: 20.0,),
// //               TextFormField(
// //                 autofocus: false,
// //                 textCapitalization: TextCapitalization.sentences,
// //                 textAlignVertical: TextAlignVertical.center,
// //                 initialValue: dataUser["last_name"],
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(Icons.person_outline),
// //                   contentPadding: EdgeInsets.only(left:10.0),
// //                   labelText: "Last name",
// //                   labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
// //                 ),
// //                 onChanged: (lastname) {
// //                   getLastName(lastname);
// //                 },
// //                 validator: (value) {
// //                   if (value.isEmpty) {
// //                     return 'Enter your Name';
// //                   } else {
// //                     return null;
// //                   }
// //                 },
// //                 keyboardType: TextInputType.text,
// //               ),
// //               SizedBox(height: 20.0,),
// //               TextFormField(
// //                 autofocus: false,
// //                 maxLines: 6,
// //                 initialValue: dataUser["about"],
// //                 textCapitalization: TextCapitalization.sentences,
// //                 textAlignVertical: TextAlignVertical.top,
// //                 decoration: InputDecoration(
// //                   contentPadding: EdgeInsets.only(left:10.0),
// //                   labelText: "Write something about you...",
// //                   labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
// //                 ),
// //                 onChanged: (about) {
// //                   getabout(about);
// //                 },
// //                 validator: (value) {
// //                   if (value.isEmpty) {
// //                     return 'Enter your Name';
// //                   } else {
// //                     return null;
// //                   }
// //                 },
// //                 keyboardType: TextInputType.text,
// //               ),
// //               SizedBox( height: 20.0,),
// //               TextFormField(
// //                 autofocus: false,
// //                 initialValue: dataUser["instagram_url"],
// //                 textCapitalization: TextCapitalization.sentences,
// //                 textAlignVertical: TextAlignVertical.center,
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(FontAwesome.instagram),
// //                   contentPadding: EdgeInsets.only(left:10.0),
// //                   labelText: "Instagram username",
// //                   labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
// //                 ),
// //                 onChanged: (insta) {
// //                   getInsta(insta);
// //                 },
// //                 validator: (value) {
// //                   if (value.isEmpty) {
// //                     return 'Enter your Name';
// //                   } else {
// //                     return null;
// //                   }
// //                 },
// //                 keyboardType: TextInputType.text,
// //               ),
// //               SizedBox(height: 20.0,),
// //               TextFormField(
// //                 autofocus: false,
// //                 textCapitalization: TextCapitalization.sentences,
// //                 initialValue: dataUser["facebook_url"],
// //                 textAlignVertical: TextAlignVertical.center,
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(FontAwesome.facebook_f),
// //                   contentPadding: EdgeInsets.only(left:10.0),
// //                   labelText: "Facebook username",
// //                   labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
// //                 ),
// //                 onChanged: (fbUser) {
// //                   getfacebookUser(fbUser);
// //                 },
// //                 validator: (value) {
// //                   if (value.isEmpty) {
// //                     return 'Enter your Name';
// //                   } else {
// //                     return null;
// //                   }
// //                 },
// //                 keyboardType: TextInputType.text,
// //               ),
// //               SizedBox(height: 20.0,),
// //               TextFormField(
// //                 autofocus: false,
// //                 initialValue:dataUser["twitter_url"],
// //                 textCapitalization: TextCapitalization.sentences,
// //                 textAlignVertical: TextAlignVertical.center,
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(FontAwesome.twitter),
// //                   contentPadding: EdgeInsets.only(left:10.0),
// //                   labelText: "Twitter username",
// //                   labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
// //                 ),
// //                 onChanged: (userTw) {
// //                   gettwitterUSer(userTw);
// //                 },
// //                 validator: (value) {
// //                   if (value.isEmpty) {
// //                     return 'Enter your Name';
// //                   } else {
// //                     return null;
// //                   }
// //                 },
// //                 keyboardType: TextInputType.text,
// //               ),
// //               SizedBox(height: 20.0,),
// //               AllowStorage(),
// //               SizedBox(height: 20.0,),
// //               ElevatedButton(
// //                 color: Color(0xffab0000),
// //                 shape: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(50.0)
// //                 ),
// //                 onPressed: (){
// //                   if(_formKey.currentState!.validate()){
// //                     userdata.updateUser(
// //                     dataUser,   
// //                     dataUser["uid"],
// //                     _firstName ?? dataUser["first_name"], 
// //                     _lastName ?? dataUser["last_name"], 
// //                     dataUser["email"], 
// //                     _about ?? dataUser["about"],  
// //                     _twitterUser ?? dataUser["twitter_url"],  
// //                     _facebookUser ?? dataUser["facebook_url"],  
// //                     _instaUser ?? dataUser["instagram_url"],
// //                     (){
// //                       setState((){});
// //                     },
// //                     context,
// //                     (){
// //                       setState((){
// //                         isSending = false;
// //                       });
// //                     }
// //                     );
// //                     setState((){
// //                       isSending = true;
// //                     });
                    
// //                   }
// //                 }, 
// //                 child: isSending == true 
// //                 ? Container ( 
// //                   width: MediaQuery.of(context).size.width*0.2,
// //                   child: Center ( 
// //                     child: CircularProgressIndicator()
// //                   )
// //                 )
// //                 :  Text(
// //                   "Save Changes", 
// //                   style: TextStyle(color: Colors.white),
// //                 )
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
  
// //   Future<void> _select(String userUid) {
// //     return showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           content: SingleChildScrollView(
// //             child: ListBody(children: <Widget>[
// //               GestureDetector(
// //                 child: Text("Camera"),
// //                 onTap: () => [
// //                   pickImageFrom(ImageSource.camera, userUid, context),
// //                   Navigator.of(context).pop(),
// //                 ]
// //               ),
// //               SizedBox(
// //                 height: 05.0,
// //               ),
// //               Divider(),
// //               SizedBox(
// //                 height: 05.0,
// //               ),
// //               GestureDetector(
// //                 child: Text("Gallery"),
// //                 onTap: () => [
// //                   pickImageFrom(ImageSource.gallery, userUid, context),
// //                   Navigator.of(context).pop(),
// //                 ]
// //               )
// //             ]
// //             )
// //           )
// //         );
// //       }
// //     );
// //   }

// //   Future pickImageFrom(ImageSource source, String userUid, context) async {
// //     var imageFile = await ImagePicker.pickImage(
// //       source: source,
// //     );
// //     setState(() {
// //       galleryFile = imageFile;    
// //       SignInProvider().uploadProfileImage(galleryFile, userUid, context);
// //     }); 
// //   }
// // }



// // class AllowStorage extends StatefulWidget {
// //   @override
// //   _AllowStorageState createState() => _AllowStorageState();
// // }
// // bool storeinCard = false;

// // class _AllowStorageState extends State<AllowStorage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return SwitchListTile(
// //       activeColor: Colors.white,
// //       activeTrackColor: Colors.red,
// //       title: Text("Store files on SD" ),
// //       value:storeinCard,
// //       onChanged: (valor)async {
// //         setState(() {
// //           storeinCard = valor;
// //         });
// //       }
// //     );
// //   }
// // }
// // // 