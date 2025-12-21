// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:honeyiou/src/models/task_model.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// import 'package:honeyiou/src/providers/tasks_provider.dart';

// class UpdateTaskPage extends StatefulWidget {
//   const UpdateTaskPage({Key key}) : super(key: key);

//   @override
//   _UpdateTaskPageState createState() => _UpdateTaskPageState();
// }

// class _UpdateTaskPageState extends State<UpdateTaskPage>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>(
//     debugLabel: "scaffold-get-phone",
//   );
//   BuildContext scaffoldContext;
//   bool loading = false;
//   String task;
//   DateTime date;
//   TimeOfDay time;
//   String rewardDescription;
//   String formattedTime;
//   String formattedDate;
//   String initialValue;
//   TimeOfDay timeDelivery;
//   DateTime dateTime;
//   // DateTime deliveryTime;
//   getTask(titleTask) {
//     task = titleTask;
//   }

//   getReward(reward) {
//     rewardDescription = reward;
//   }

//   final TextEditingController _inputDateTime = TextEditingController();

//   static File image;
//   static Future<File> imageFile;
//   AnimationController _controllerAnimation;
//   Animation<double> _animation;
//   @override
//   void initState() {
//     super.initState();
//     image = null;
//     _controllerAnimation = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _animation = CurvedAnimation(
//       parent: _controllerAnimation,
//       curve: Curves.easeIn,
//     );
//     _controllerAnimation.forward();
//   }

//   @override
//   void dispose() {
//     _controllerAnimation.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     var singleTaskSelected = DocTaskSelected.docSnapshot;
//     Map<String, dynamic> firebaseDate;
//     if (singleTaskSelected.data() as Map<String,dynamic>['delivery_time'] != null) {
//       firebaseDate = singleTaskSelected.data() as Map<String,dynamic>['delivery_time'].toDate();
//       var formatter = DateFormat("MMM d' at 'HH':'mm aaa");
//       initialValue = formatter.format(firebaseDate);
//     } else {
//       initialValue = localizations.t("home_page.noDate");
//     }
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                   child: GestureDetector(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.arrow_back_ios, color: Colors.white),
//                         Text(
//                           localizations.t('updateTask.back'),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 localizations.t('updateTask.title'),
//                 style: TextStyle(color: Colors.white),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                   child: Container(),
//                 ),
//               ),
//             ],
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//           automaticallyImplyLeading: false,
//         ),
//         backgroundColor: Color(0xff393939),
//         body: _body(context, localizations),
//       ),
//     );
//   }

//   Widget _body(BuildContext context, localizations) {
//     var singleTaskSelected = DocTaskSelected.docSnapshot;
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(height: 10.0),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: Text(
//                   localizations.t('updateTask.taskTitle'),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14.0,
//                     fontFamily: 'Sans',
//                   ),
//                 ),
//               ),
//             ),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: TextFormField(
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "Task is empty";
//                     }
//                     return null;
//                   },
//                   maxLines: 2,
//                   initialValue: singleTaskSelected.data() as Map<String,dynamic>['title'],
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     hintText: localizations.t('updateTask.taskHint'),
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 14.0,
//                     ),
//                     // border: InputBorder(borderSide: BorderSide(color: Colors.white)),
//                     // border: UnderlineInputBorder(
//                     //   borderSide: BorderSide(color: Colors.white),
//                     // )
//                   ),
//                   onChanged: (String titleTask) {
//                     getTask(titleTask);
//                   },
//                   cursorColor: Colors.grey,
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontFamily: 'SansRegularlight',
//                     fontSize: 14.0,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: Text(
//                   localizations.t('updateTask.timeLimit'),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14.0,
//                     fontFamily: 'Sans',
//                   ),
//                 ),
//               ),
//             ),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 10.0,
//                   left: 10.0,
//                   right: 10.0,
//                   bottom: 5.0,
//                 ),
//                 child: GestureDetector(
//                   child: SizedBox(
//                     // color: Colors.white,
//                     height: 20.0,
//                     width: MediaQuery.of(context).size.width,
//                     child: Text(
//                       formattedDate ?? initialValue,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'SansRegularlight',
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                   onTap: () async {
//                     // FocusScope.of(context).requestFocus( new FocusNode());
//                     _selectDate(context);
//                     // todayDate();
//                   },
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Divider(color: Colors.white),
//             ),
//             SizedBox(height: 10.0),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: Text(
//                   localizations.t('updateTask.rewardTitle'),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14.0,
//                     fontFamily: 'Sans',
//                   ),
//                 ),
//               ),
//             ),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: TextFormField(
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "Reward is empty";
//                     }
//                     return null;
//                   },
//                   initialValue: singleTaskSelected.data() as Map<String,dynamic>['reward_description'],
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     hintText: localizations.t('updateTask.hintReward'),
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 14.0,
//                     ),
//                   ),
//                   onChanged: (String rewardDescription) {
//                     getReward(rewardDescription);
//                   },
//                   cursorColor: Colors.grey,
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontFamily: 'SansRegularlight',
//                     fontSize: 14.0,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15.0),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: Text(
//                   localizations.t('updateTask.rewardImage'),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14.0,
//                     fontFamily: 'Sans',
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             FadeTransition(
//               opacity: _animation,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: GestureDetector(
//                   child: showimage(localizations),
//                   onTap: () {
//                     _select(localizations);
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child:
//                   loading
//                       ? Center(child: CircularProgressIndicator())
//                       : FadeTransition(
//                         opacity: _animation,
//                         child: Center(
//                           child: ElevatedButton(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(70.0),
//                             ),
//                             elevation: 0.0,
//                             color: const Color(0xff7a1418),
//                             child: SizedBox(
//                               width: MediaQuery.of(context).size.width,
//                               child: Center(
//                                 child: Text(
//                                   localizations.t('newTask.buttomTaskText'),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15.0,
//                                     fontFamily: 'SansRegularlight',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               _sendTask();
//                               setState(() {
//                                 loading = true;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget showimage(localizations) {
//     var singleTaskSelected = DocTaskSelected.docSnapshot;

//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.4,
//       child: Card(
//         elevation: 10.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
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

//   _sendTask() async {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final pref = UserPreferences();
//     String user = pref.uid;
//     // var _task = SingleTask.docSnapshot;
//     var singleTaskSelected = DocTaskSelected.docSnapshot;
//     if (_formKey.currentState!.validate()) {
//       Map<String, dynamic>? deliveryTime;
//       if (singleTaskSelected.data() as Map<String,dynamic>['delivery_time'] != null) {
//         deliveryTime = singleTaskSelected.data() as Map<String,dynamic>['delivery_time'].toDate();
//       } else {
//         deliveryTime = null;
//       }
//       await TasksListProvider(uid: user)
//           .updateTask(
//             singleTaskSelected.data() as Map<String,dynamic>['reward_img_url'],
//             task ?? singleTaskSelected.data() as Map<String,dynamic>['title'],
//             singleTaskSelected.docID,
//             dateTime ?? deliveryTime,
//             rewardDescription ?? singleTaskSelected.data() as Map<String,dynamic>['reward_description'],
//           )
//           .then((value) => Navigator.of(context).pop());
//     }
//   }

//   Future<void> _select(localizations) {
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
//                   child: Text(localizations.t('updateTask.cameraText')),
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
//                   child: Text(localizations.t('updateTask.galleryText')),
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
//     final pref = UserPreferences();
//     String user = pref.uid;
//     var singleTaskSelected = DocTaskSelected.docSnapshot;

//     var imageFile = await ImagePicker.pickImage(source: source);
//     setState(() {
//       image = imageFile;
//       TasksListProvider(
//         uid: user,
//       ).updateRewardImage(singleTaskSelected.docID, image);
//     });
//   }
// }
