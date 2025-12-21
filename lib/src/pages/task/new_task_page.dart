// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:honeyiou/partners/partner_accept_list.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// import 'package:honeyiou/src/models/partner_model.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';

// import 'negociation.dart';

// class NewTaskPage extends StatefulWidget {
//   const NewTaskPage({Key key}) : super(key: key);

//   @override
//   _NewTaskPageState createState() => _NewTaskPageState();
// }

// class _NewTaskPageState extends State<NewTaskPage>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   BuildContext scaffoldContext;
//   bool loading = false;
//   String task;
//   String time;
//   String rewardDescription;
//   final TextEditingController _inputDateTime = TextEditingController();
//   DateTime date;
//   String formattedTime;
//   String formattedDate;

//   TimeOfDay timeDelivery;
//   DateTime dateTime;

//   getTask(titleTask) {
//     task = titleTask;
//   }

//   getReward(reward) {
//     rewardDescription = reward;
//   }

//   static File image;
//   static Future<File> imageFile;
//   AnimationController _controller;
//   Animation<double> _animation;
//   @override
//   void initState() {
//     super.initState();
//     image = null;
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

//   var userData;
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             children: [
//               GestureDetector(
//                 child: SizedBox(
//                   height: 40.0,
//                   width: 100.0,
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.arrow_back_ios, color: Colors.white),
//                       Text(
//                         localizations.t('newTask.back'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   setState(() {
//                     SinglePartner.uid = null;
//                   });
//                 },
//               ),
//               SizedBox(width: 10.0),
//               Text(localizations.t('newTask.titleTask')),
//             ],
//           ),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xff7a1418),
//         ),
//         backgroundColor: Color(0xff282828),
//         body: _body(context, localizations),
//       ),
//     );
//   }

//   var currentPartner = SinglePartner.uid;
//   var currentPartner1 = SinglePartner.uidPartner;
//   Widget _body(BuildContext context, localizations) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     if (currentPartner == null) {
//       return FadeTransition(
//         opacity: _animation,
//         child: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => PartnersAccepted(previewPage: "task_page"),
//                 ),
//               );
//             },
//             child: Text(
//               localizations.t('newTask.taptoSelectPartmer'),
//               // 'Tap Here to Select Partner',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.0,
//                 fontFamily: 'SansLightItalic',
//               ),
//             ),
//           ),
//         ),
//       );
//     } else if (currentPartner != null && currentPartner == user) {
//       return SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10.0),
//                 child: FadeTransition(
//                   opacity: _animation,
//                   child: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         localizations.t('newTask.partner'),
//                         style: TextStyle(
//                           fontFamily: 'Sans',
//                           color: Colors.white,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: GestureDetector(
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream:
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(currentPartner1)
//                             .collection(currentPartner1)
//                             .doc(currentPartner1)
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting)
//                         return Container(
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       userData = snapshot.data;
//                       return ListTile(
//                         leading: CircleAvatarWidget(
//                           radius: 30.0,
//                           imageUrl:
//                               snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                               'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                         ),
//                         title: Text(
//                           '${snapshot.data() as Map<String,dynamic>['name']}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'SansRegular',
//                             fontSize: 14.0,
//                           ),
//                         ),
//                         trailing: Icon(
//                           Icons.arrow_forward_ios,
//                           color: Colors.white,
//                         ),
//                       );
//                     },
//                   ),
//                   onTap:
//                       () => Navigator.of(context).push(
//                         CupertinoPageRoute(
//                           builder: (context) => PartnersAccepted(),
//                         ),
//                       ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Divider(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.taskName'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Task is empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: localizations.t('newTask.taskHint'),
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 14.0,
//                       ),
//                     ),

//                     onChanged: (String titleTask) {
//                       getTask(titleTask);
//                     },
//                     cursorColor: Colors.grey,
//                     textCapitalization: TextCapitalization.words,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.timeLimit'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: TextFormField(
//                     controller: _inputDateTime,
//                     enableInteractiveSelection: false,
//                     decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: localizations.t('newTask.hintTimeLimit'),
//                       // "",
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 14.0,
//                       ),
//                     ),
//                     onTap: () {
//                       FocusScope.of(context).requestFocus(FocusNode());
//                       _selectDate(context);
//                     },
//                     cursorColor: Colors.grey,
//                     textCapitalization: TextCapitalization.words,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 14.0,
//                     ),
//                     // style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.rewardTitle'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Reward is empty";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: localizations.t('newTask.hintReward'),
//                       // "?",
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 14.0,
//                       ),
//                     ),
//                     onChanged: (String rewardDescription) {
//                       getReward(rewardDescription);
//                     },
//                     cursorColor: Colors.grey,
//                     // style: TextStyle(color: Colors.grey),
//                     textCapitalization: TextCapitalization.words,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.rewardImage'),
//                     // "  ",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: GestureDetector(
//                     onTap: _select,
//                     child: showimage(localizations),
//                   ),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10.0,
//                   right: 10.0,
//                   top: 5.0,
//                 ),
//                 child:
//                     loading
//                         ? Center(child: CircularProgressIndicator())
//                         : FadeTransition(
//                           opacity: _animation,
//                           child: Center(
//                             child: ElevatedButton(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(70.0),
//                               ),
//                               elevation: 0.0,
//                               color: const Color(0xff7a1418),
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Center(
//                                   child: Text(
//                                     localizations.t('newTask.buttomTaskText'),
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15.0,
//                                       fontFamily: 'SansRegularlight',
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 _sendTask(
//                                   userData["name"],
//                                   userData['photo_url'],
//                                 );
//                                 setState(() {
//                                   loading = true;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//             ],
//           ),
//         ),
//       );
//     } else if (currentPartner != null && currentPartner1 == user) {
//       return SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10.0),
//                 child: FadeTransition(
//                   opacity: _animation,
//                   child: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         localizations.t('newTask.partner'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14.0,
//                           fontFamily: 'Sans',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: GestureDetector(
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream:
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(currentPartner)
//                             .collection(currentPartner)
//                             .doc(currentPartner)
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting)
//                         return Container(
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       userData = snapshot.data;
//                       return ListTile(
//                         leading: CircleAvatarWidget(
//                           radius: 30.0,
//                           imageUrl:
//                               snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                               'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                         ),
//                         title: Text(
//                           '${snapshot.data() as Map<String,dynamic>['name']}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'SansRegularlight',
//                             fontSize: 14.0,
//                           ),
//                         ),
//                         trailing: Icon(
//                           Icons.arrow_forward_ios,
//                           color: Colors.white,
//                         ),
//                       );
//                     },
//                   ),
//                   onTap:
//                       () => Navigator.of(context).push(
//                         CupertinoPageRoute(
//                           builder: (context) => PartnersAccepted(),
//                         ),
//                       ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Divider(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.taskName'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Task is empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: localizations.t('newTask.taskHint'),
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 14.0,
//                       ),
//                       // border: InputBorder(borderSide: BorderSide(color: Colors.white)),
//                       // border: UnderlineInputBorder(
//                       //   borderSide: BorderSide(color: Colors.white),
//                       // )
//                     ),
//                     onChanged: (String task) {
//                       getTask(task);
//                     },
//                     cursorColor: Colors.grey,
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.timeLimit'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: TextFormField(
//                     controller: _inputDateTime,
//                     enableInteractiveSelection: false,
//                     decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: localizations.t('newTask.hintTimeLimit'),
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 14.0,
//                       ),
//                     ),
//                     onTap: () {
//                       FocusScope.of(context).requestFocus(FocusNode());
//                       _selectDate(context);
//                       // _selectTime(context);
//                     },
//                     cursorColor: Colors.grey,
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.rewardTitle'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Reward is empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: localizations.t('newTask.hintReward'),
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                       ),
//                     ),
//                     onChanged: (String rewardDescription) {
//                       getReward(rewardDescription);
//                     },
//                     cursorColor: Colors.grey,
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15.0),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: Text(
//                     localizations.t('newTask.rewardImage'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       fontFamily: 'Sans',
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               FadeTransition(
//                 opacity: _animation,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   child: GestureDetector(
//                     onTap: _select,
//                     child: showimage(localizations),
//                   ),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child:
//                     loading
//                         ? Center(child: CircularProgressIndicator())
//                         : FadeTransition(
//                           opacity: _animation,
//                           child: Center(
//                             child: ElevatedButton(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(70.0),
//                               ),
//                               elevation: 0.0,
//                               color: const Color(0xff7a1418),
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Center(
//                                   child: Text(
//                                     localizations.t('newTask.buttomTaskText'),
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 _sendTask(
//                                   userData["name"],
//                                   userData['photo_url'],
//                                 );
//                                 setState(() {
//                                   loading = true;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Text('Selecciona un Partner');
//     }
//   }

//   Widget showimage(localizations) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.3,
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         elevation: 10.0,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.0),
//           child: Image.file(image, fit: BoxFit.cover),
//         ),
//       ),
//     );
//   }

//   DateTime selectedDate;
//   TimeOfDay selectedTime;

//   Future<Null> _selectDate(BuildContext context) async {
//     // Capturo la fecha completa
//     final DateTime fullDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//       builder: (BuildContext context, Widget child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: const Color(0xFF7A1418),
//             buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//             colorScheme: ColorScheme.light(
//               primary: const Color(0xFF7A1418),
//             ).copyWith(secondary: const Color(0xFF7A1418)),
//           ),
//           child: child,
//         );
//       },
//     );
//     setState(() {
//       selectedDate = date;
//       print(date);
//     });

//     // Capturo hora y minuto
//     final TimeOfDay picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//       builder: (BuildContext context, Widget child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: const Color(0xFF7A1418),
//             buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//             colorScheme: ColorScheme.light(
//               primary: const Color(0xFF7A1418),
//             ).copyWith(secondary: const Color(0xFF7A1418)),
//           ),
//           child: child,
//         );
//       },
//     );
//     setState(() {
//       selectedTime = picked;
//       // print(selectedTime);
//     });
//     dateTime = DateTime(
//       fullDate.year,
//       fullDate.month,
//       fullDate.day,
//       picked.hour,
//       picked.minute,
//     );
//     // Aqui es donde hace la conversion
//     var formatter = DateFormat("MMM d' at 'HH':'mm aaa");
//     formattedDate = formatter.format(dateTime);
//     print(formattedDate);
//     setState(() {
//       _inputDateTime.text = formattedDate;
//     });
//   }

//   _sendTask(String partnerName, String partnerImageUrl) async {
//     final pref = UserPreferences();
//     String user = pref.uid;

//     if (currentPartner != null && currentPartner1 == user) {
//       if (_formKey.currentState!.validate()) {
//         await TasksListProvider(uid: user)
//             .createNewTask(
//               image,
//               task,
//               user,
//               currentPartner,
//               dateTime,
//               rewardDescription,
//             )
//             .whenComplete(() {
//               setState(() {
//                 SinglePartner.uid = null;
//                 SinglePartner.uidPartner = null;
//               });
//             });
//         _showdialog(partnerName, partnerImageUrl);
//       }
//     } else if (currentPartner != null && currentPartner == user) {
//       if (_formKey.currentState!.validate()) {
//         await TasksListProvider(uid: user)
//             .createNewTask(
//               image,
//               task,
//               user,
//               currentPartner1,
//               dateTime,
//               rewardDescription,
//             )
//             .whenComplete(() {
//               setState(() {
//                 SinglePartner.uid = null;
//                 SinglePartner.uidPartner = null;
//               });
//             });
//         _showdialog(partnerName, partnerImageUrl);
//       }
//     }
//     setState(() {});
//   }

//   _showdialog(String partnerName, String partnerImageUrl) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               backgroundColor: Color(0xff282828),
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Center(
//                       child: CircleAvatar(
//                         backgroundImage: NetworkImage(partnerImageUrl),
//                         radius: 35.0,
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Center(
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.7,
//                         child: Text(
//                           localizations.t('home_page.sendTaskTitlePopUp') +
//                               " $partnerName",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xffFFFFFF),
//                             fontSize: 14.0,
//                             fontFamily: 'SansRegular',
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Center(
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.7,
//                         child: Text(
//                           localizations.t('home_page.sendTaskDescPopUp'),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xffFFFFFF),
//                             fontSize: 14.0,
//                             fontFamily: 'SansRegular',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Container(
//                       child: ElevatedButton(
//                         color: const Color(0xffBF2328),
//                         onPressed: () async {
//                           Navigator.of(context).pushNamedAndRemoveUntil(
//                             'home_page',
//                             (Route<dynamic> route) => false,
//                           );
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text(
//                           "Ok",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'SansRegularlight',
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
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
//         return Sizedbox();
//       },
//     );
//   }

//   Future<void> _select() {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final pref = UserPreferences();
//         String user = pref.uid;
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 GestureDetector(
//                   child: Text("Camera"),
//                   onTap:
//                       () => [
//                         pickImageFrom(ImageSource.camera),
//                         Navigator.of(context).pop(),
//                       ],
//                 ),
//                 SizedBox(height: 05.0),
//                 Divider(),
//                 SizedBox(height: 05.0),
//                 GestureDetector(
//                   child: Text("Gallery"),
//                   onTap:
//                       () => [
//                         pickImageFrom(ImageSource.gallery),
//                         Navigator.of(context).pop(),
//                       ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future pickImageFrom(ImageSource source) async {
//     var imageFile = await ImagePicker.pickImage(source: source);
//     setState(() {
//       image = imageFile;
//     });
//   }
// }
