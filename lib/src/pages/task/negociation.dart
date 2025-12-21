// import 'dart:async';

// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:honeyiou/src/models/partner_model.dart';
// import 'package:honeyiou/src/models/user_model.dart';
// import 'package:honeyiou/src/pages/task/task_list.dart';
// import 'package:honeyiou/src/providers/free_coins_provider.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/src/widget/partner_list_item_task.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_animations/simple_animations.dart';

// import 'package:honeyiou/partners/add_partner.dart';
// import 'package:honeyiou/src/models/task_model.dart';
// import 'package:honeyiou/src/onboarding/onboarding.dart';
// import 'package:honeyiou/src/pages/more/buy_credits.dart';
// import 'package:honeyiou/src/pages/more/show_notifi.dart';
// import 'package:honeyiou/src/pages/others/profile_page.dart';
// import 'package:honeyiou/src/pages/others/settings_app.dart';
// import 'package:honeyiou/src/providers/partner_provider.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'new_task_page.dart';

// //Widget que maneja todas las tareas
// class TasksPage extends StatefulWidget {
//   final String firstFilterInitialValue;

//   const TasksPage({Key key, this.firstFilterInitialValue}) : super(key: key);
//   @override
//   _TasksPageState createState() => _TasksPageState(firstFilterInitialValue);
// }

// bool imageRewardUrl;
// String _selectedQuery;

// String token;

// class _TasksPageState extends State<TasksPage>
//     with SingleTickerProviderStateMixin {
//   final String firstFilterInitialValue;
//   _TasksPageState(this.firstFilterInitialValue);

//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   static final pref = UserPreferences();
//   String user = pref.uid;
//   String initialval = pref.initialValueTask;
//   String nameSender;
//   String taskID;
//   String senderUID;
//   String receiverUID;
//   String status;
//   String typeNoti;
//   String uidPartnerSelected;
//   int indexFirstFilter = 0;
//   int indexSecondFilter;
//   bool showfilters = false;

//   AnimationController _controller;
//   Animation<double> _animation;
//   static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     childDirected: true,
//     nonPersonalizedAds: true,
//   );
//   final Firestore _db = FirebaseFirestore.instance;
//   TextEditingController controller = TextEditingController();

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );

//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();
//     TasksListProvider(
//       uidTask: taskID,
//     ).actualWindowandIdTask(user, 'home_page', ' ');

//     _selectedQuery = initialval;
//     var onboarding =
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(user)
//             .collection(user)
//             .doc(user)
//             .get();
//     onboarding.then((value) {
//       if (value.data() as Map<String,dynamic>['first_launch'] == true) {
//         Navigator.of(context).push(
//           CupertinoPageRoute(
//             builder: (BuildContext context) {
//               return Onboarding();
//             },
//           ),
//         );
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   bool filtersVisibility = true;
//   String _valueRequest;
//   getValueRequest(String request) {
//     _valueRequest = request;
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     pref.initialValueTask = localizations.t('home_page.allTask');
//     FirebaseMessaging firebaseMessaging =
//         FirebaseMessaging(); //Instancia de libreria
//     firebaseMessaging.requestNotificationPermissions();
//     firebaseMessaging.onTokenRefresh;
//     firebaseMessaging.getToken().then((token) {
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(user)
//           .collection(user)
//           .doc(user)
//           .updateData({
//             'token': token, // Se sobre escribe el campo token del perfil
//             'window_id': '',
//             'windows_type': 'home_page',
//           });
//     });
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xff282828),
//       appBar: _appbar(),
//       body: SafeArea(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height - kToolbarHeight,
//           child: Stack(
//             children: <Widget>[
//               filterWidget(localizations),
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.08,
//                 ),
//                 child: taskList(localizations),
//               ),
//               Positioned(bottom: 10.0, child: addTask(localizations)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget filterWidget(localizations) {
//     String firstFilter =
//         Provider.of<TasksListProvider>(context).firstFilter ??
//         localizations.t('home_page.receiveFromPartner');
//     DocumentSnapshot partner =
//         Provider.of<TasksListProvider>(context).secondFilter;
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0),
//         child:
//             filtersVisibility == true
//                 ? FadeTransition(
//                   opacity: _animation,
//                   child: GestureDetector(
//                     onTap: () {
//                       _showModalSheet(localizations);
//                     },
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.045,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Color(0xff3a3a3a),
//                               borderRadius: BorderRadius.circular(50.0),
//                             ),
//                             width: MediaQuery.of(context).size.width * 0.35,
//                             child: Center(
//                               child: Text(
//                                 firstFilter,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14.0,
//                                   fontFamily: "Sans",
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10.0),
//                           partner != null
//                               ? Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Colors.white,
//                               )
//                               : Container(),
//                           SizedBox(width: 10.0),
//                           partner != null
//                               ? Container(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.045,
//                                 width: MediaQuery.of(context).size.width * 0.38,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xff3a3a3a),
//                                   borderRadius: BorderRadius.circular(50.0),
//                                 ),
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 5.0,
//                                   vertical: 2.0,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     partner.data() as Map<String,dynamic>["photo_url"] != null
//                                         ? CircleAvatarWidget(
//                                           imageUrl: partner.data() as Map<String,dynamic>["photo_url"],
//                                           radius: 10.0,
//                                         )
//                                         : CircleAvatar(
//                                           radius: 10.0,
//                                           backgroundImage: AssetImage(
//                                             "assets/image/no_image.png",
//                                           ),
//                                         ),
//                                     SizedBox(width: 5.0),
//                                     Text(
//                                       partner.data() as Map<String,dynamic>["name"] ?? "",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 14.0,
//                                         fontFamily: "Sans",
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               )
//                               : Container(),
//                           SizedBox(width: 10.0),
//                           GestureDetector(
//                             onTap: () {
//                               Provider.of<TasksListProvider>(
//                                 context,
//                                 listen: false,
//                               ).firstFilter = localizations.t(
//                                 'home_page.allTask',
//                               );
//                               setState(() {
//                                 filtersVisibility = false;
//                               });
//                             },
//                             child: Icon(Icons.search, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//                 : FadeTransition(
//                   opacity: _animation,
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     height: MediaQuery.of(context).size.height * 0.05,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//                           onPressed: () {
//                             Provider.of<TasksListProvider>(
//                               context,
//                               listen: false,
//                             ).firstFilter = localizations.t(
//                               'home_page.receiveFromPartner',
//                             );
//                             setState(() {
//                               controller.text = "";
//                               filtersVisibility = true;
//                             });
//                           },
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.65,
//                           height: MediaQuery.of(context).size.height * 0.05,
//                           child: Form(
//                             key: _formKey,
//                             child: TextFormField(
//                               controller: controller,
//                               textCapitalization: TextCapitalization.words,
//                               style: TextStyle(
//                                 fontSize: 15.0,
//                                 color: Colors.white,
//                               ),
//                               onChanged: (String value) {
//                                 setState(() {
//                                   _valueRequest = value;
//                                 });
//                               },
//                               validator: (String val) {
//                                 return null;
//                               },
//                               maxLines: 1,
//                               decoration: InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(50.0),
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                                 hintText: localizations.t(
//                                   'home_page.search_hint',
//                                 ),
//                                 hintStyle: TextStyle(
//                                   fontSize: 15.0,
//                                   color: Colors.grey,
//                                 ),
//                                 fillColor: Colors.white,
//                                 hoverColor: Colors.white,
//                                 focusColor: Colors.white,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 5,
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Colors.white,
//                                     width: 0.02,
//                                   ),
//                                   borderRadius: BorderRadius.circular(50.0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.search, color: Colors.white),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               setState(() {});
//                             } else {
//                               scaffoldKey.currentState.showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     localizations.t('home_page.emtpy_request'),
//                                   ),
//                                 ),
//                               );
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//       ),
//     );
//   }

//   void _showModalSheet(localizations) {
//     showModalBottomSheet(
//       isDismissible: true,
//       useRootNavigator: true,
//       isScrollControlled: true,
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//         ),
//       ),
//       backgroundColor: Colors.black.withOpacity(0.0),
//       builder: (builder) {
//         return FractionallySizedBox(
//           widthFactor: 0.9,
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.6,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20.0),
//                 topRight: Radius.circular(20.0),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 10.0),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50.0),
//                       color: Colors.grey,
//                     ),
//                     height: MediaQuery.of(context).size.height * 0.005,
//                     width: MediaQuery.of(context).size.height * 0.1,
//                   ),
//                   SizedBox(height: 10.0),
//                   _firstFilter(localizations),
//                   _secondFilter(localizations),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _firstFilter(localizations) {
//     List<String> firstFilterList = [
//       localizations.t('home_page.allTask'),
//       localizations.t('home_page.sendByMe'),
//       localizations.t('home_page.receiveFromPartner'),
//       localizations.t('home_page.openNegociation'),
//       localizations.t('home_page.endingSoon'),
//       localizations.t('home_page.expired'),
//     ];
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     localizations.t('home_page.task_filter'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Sans',
//                       fontSize: 18.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 15.0),
//             StaggeredGridView.countBuilder(
//               shrinkWrap: true,
//               crossAxisCount: 8,
//               itemCount: firstFilterList.length,
//               staggeredTileBuilder: (int index) {
//                 if (firstFilterList[index].length < 10) {
//                   return StaggeredTile.count(2, 1);
//                 } else if (firstFilterList[index].length > 11 &&
//                     firstFilterList[index].length < 15) {
//                   return StaggeredTile.count(3, 1);
//                 } else if (firstFilterList[index].length > 15) {
//                   return StaggeredTile.count(4, 1);
//                 } else {
//                   return StaggeredTile.count(4, 1);
//                 }
//               },
//               itemBuilder:
//                   (BuildContext context, int index) => GestureDetector(
//                     onTap: () {
//                       Provider.of<TasksListProvider>(context, listen: false)
//                           .firstFilter = firstFilterList[index];
//                       Provider.of<TasksListProvider>(context, listen: false)
//                           .secondFilter = null;
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xff282828),
//                         borderRadius: BorderRadius.circular(50.0),
//                       ),
//                       child: Center(
//                         child: Text(
//                           firstFilterList[index],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "Sans",
//                             fontSize: 15.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               mainAxisSpacing: 4.0,
//               crossAxisSpacing: 4.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _secondFilter(localizations) {
//     String user = UserPreferences().uid;
//     var partnerAccepted = PartnerProvider(uid: user).partnerAcceptedList;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     localizations.t('home_page.partner_filter'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Sans',
//                       fontSize: 18.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             StreamBuilder<QuerySnapshot>(
//               stream: partnerAccepted,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else {
//                   if (snapshot.data == null || snapshot.data.docs.isEmpty) {
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 50.0),
//                           child: Text(
//                             localizations.t('home_page.textPartnerEmptyList'),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Sans',
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Center(
//                       child: PartnerListItemTask(
//                         userUid: user,
//                         partners: snapshot.data.docs,
//                       ),
//                     );
//                   }
//                 }
//               },
//             ),
//             SizedBox(height: 5.0),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pushNamed("add_partners");
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.45,
//                 height: MediaQuery.of(context).size.height * 0.05,
//                 decoration: BoxDecoration(
//                   color: Color(0xff282828),
//                   borderRadius: BorderRadius.circular(50.0),
//                 ),
//                 padding: EdgeInsets.all(5.0),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.add_circle_outline_outlined,
//                       color: Colors.white,
//                       size: 20.0,
//                     ),
//                     SizedBox(width: 5.0),
//                     Text(
//                       localizations.t('home_page.add_partner'),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "Sans",
//                         fontSize: 15.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget taskList(localizations) {
//     var textStyle = TextStyle(
//       color: Colors.white,
//       fontFamily: 'SansLightItalic',
//       fontSize: 12.0,
//     );
//     return StreamBuilder<List<TaskData>>(
//       stream: TasksListProvider().getTasks(user),
//       builder: (context, AsyncSnapshot<List<TaskData>> taskSnapshot) {
//         if (taskSnapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           if (taskSnapshot.data.length == 0) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 200.0,
//                     horizontal: 10.0,
//                   ),
//                   child: FadeTransition(
//                     opacity: _animation,
//                     child: Center(
//                       child: Text(
//                         localizations.t('home_page.noTask'),
//                         textAlign: TextAlign.center,
//                         style: textStyle,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             print(
//               "Si llego hasta aqui pero no se que pasa========================================================",
//             );
//             List<TaskData> finalList = TasksListProvider().filterList(
//               taskSnapshot.data,
//               context,
//               user,
//               () {
//                 setState(() {});
//               },
//               filtersVisibility,
//               _valueRequest,
//             );
//             return TaskList(finalList: finalList);
//           }
//         }
//       },
//     );
//   }

//   Widget addTask(localizations) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     final coins = FreeCoinsProvider().getCoins(user);
//     return SizedBox(
//       // color: Colors.white,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           FadeTransition(
//             opacity: _animation,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 5.0),
//               child: GestureDetector(
//                 onTap: () {
//                   RewardedVideoAd.instance
//                       .load(
//                         adUnitId: "ca-app-pub-4666613317919939/7781673557",
//                         targetingInfo: targetingInfo,
//                       )
//                       .catchError((e) => print("error in loading 1st time"));

//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (BuildContext context) {
//                         return BuyCredits();
//                       },
//                     ),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(60.0),
//                   ),
//                   height: 80.0,
//                   width: 140.0,
//                   child: Row(
//                     children: <Widget>[
//                       Image(
//                         image: AssetImage('assets/image/Credits_Icon1.png'),
//                         width: 80.0,
//                         height: 80.0,
//                         fit: BoxFit.cover,
//                       ),
//                       SizedBox(width: 5.0),
//                       StreamBuilder<QuerySnapshot>(
//                         stream: coins,
//                         builder: (
//                           context,
//                           AsyncSnapshot<QuerySnapshot> snapshot,
//                         ) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting)
//                             return Container();
//                           return Text(
//                             snapshot.data.docs.isEmpty
//                                 ? "X 0"
//                                 : "X ${snapshot.data.docs.length}",
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontFamily: 'SansRegular',
//                               fontSize: 19.91,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           FadeTransition(
//             opacity: _animation,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 5.0),
//               child: StreamBuilder<List<PartnerList>>(
//                 stream: PartnerProvider(uid: user).test(),
//                 builder: (context, AsyncSnapshot<List<PartnerList>> snapshot) {
//                   return GestureDetector(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xffBF2328),
//                         borderRadius: BorderRadius.circular(60.0),
//                       ),
//                       height: 80.0,
//                       width: 80.0,
//                       child: Icon(
//                         FontAwesomeIcons.plus,
//                         color: Colors.white,
//                         size: 40.0,
//                       ),
//                     ),
//                     onTap: () {
//                       if (snapshot.data.length == 0) {
//                         showGeneralDialog(
//                           transitionBuilder: (context, a1, a2, widget) {
//                             final curvedValue =
//                                 Curves.easeInOutBack.transform(1.0) -
//                                 (a1.value);
//                             return Transform(
//                               transform: Matrix4.translationValues(
//                                 0.0,
//                                 curvedValue * 200,
//                                 0.0,
//                               ),
//                               child: Opacity(
//                                 opacity: a1.value,
//                                 child: AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   title: Center(
//                                     child: Text(
//                                       localizations.t('home_page.noPartner'),
//                                       style: TextStyle(
//                                         color: Color(0xffFFFFFF),
//                                         fontSize: 14.0,
//                                         fontFamily: 'Sans',
//                                       ),
//                                     ),
//                                   ),
//                                   backgroundColor: Color(0xff282828),
//                                   content: Container(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Center(
//                                           child: SizedBox(
//                                             width:
//                                                 MediaQuery.of(
//                                                   context,
//                                                 ).size.width *
//                                                 0.55,
//                                             child: Text(
//                                               localizations.t(
//                                                 'home_page.noPartner1',
//                                               ),
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Color(0xffFFFFFF),
//                                                 fontSize: 14.0,
//                                                 fontFamily: 'SansRegular',
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: 20.0),
//                                         Container(
//                                           child: ElevatedButton(
//                                             color: const Color(0xffBF2328),
//                                             onPressed: () async {
//                                               Navigator.of(context).pop();
//                                               Navigator.of(context).push(
//                                                 CupertinoPageRoute(
//                                                   builder: (context) {
//                                                     return AddPartner();
//                                                   },
//                                                 ),
//                                               );
//                                             },
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(20.0),
//                                             ),
//                                             // color: Colors.red,
//                                             child: Text(
//                                               localizations.t(
//                                                 'home_page.noPartner2',
//                                               ),
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontFamily: 'SansRegularlight',
//                                                 fontSize: 14.0,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           transitionDuration: Duration(milliseconds: 200),
//                           barrierDismissible: true,
//                           barrierLabel: '',
//                           context: context,
//                           pageBuilder: (context, animation1, animation2) {
//                             return Sizedbox();
//                           },
//                         );
//                       } else {
//                         if (snapshot.data.length <= 1) {
//                           for (var element in snapshot.data) {
//                             SinglePartner.uid = element.uid;
//                             SinglePartner.uidPartner = element.uidPartner;
//                           }
//                         }
//                         Navigator.of(context).push(
//                           CupertinoPageRoute(
//                             builder: (context) {
//                               return NewTaskPage();
//                             },
//                           ),
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _appbar() {
//     return AppBar(
//       title: FadeTransition(
//         opacity: _animation,
//         child: Text(
//           "Honey IOU",
//           style: TextStyle(fontFamily: "Quick", fontSize: 22.0),
//         ),
//       ),
//       centerTitle: true,
//       leading: _leadingAppBar(),
//       backgroundColor: const Color(0xff7a1418),
//       actions: <Widget>[
//         FadeTransition(
//           opacity: _animation,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: SizedBox(
//               width: 94.0,
//               height: 24.0,
//               child: FadeTransition(
//                 opacity: _animation,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     GestureDetector(
//                       child: Image(
//                         image: AssetImage('assets/image/reward.png'),
//                         width: 24.0,
//                         height: 24.0,
//                       ),
//                       onTap: () {},
//                     ),
//                     GestureDetector(
//                       child: Image(
//                         image: AssetImage('assets/image/notification.png'),
//                         width: 24.0,
//                         height: 24.0,
//                       ),
//                       onTap: () {
//                         Navigator.of(context).push(
//                           CupertinoPageRoute(
//                             builder: (context) {
//                               return ShowNotifications();
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                     GestureDetector(
//                       child: Image(
//                         image: AssetImage('assets/image/setting.png'),
//                         width: 24.0,
//                         height: 24.0,
//                       ),
//                       onTap: () {
//                         Navigator.of(context).push(
//                           CupertinoPageRoute(
//                             builder: (context) {
//                               return Settings();
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _leadingAppBar() {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return StreamBuilder(
//       stream:
//           FirebaseFirestore.instance
//               .collection('users')
//               .doc(user)
//               .collection(user)
//               .doc(user)
//               .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (snapshot.data() as Map<String,dynamic>["photo_url"] != null) {
//           UserInfo.docSnapshot = snapshot.data;
//           return FadeTransition(
//             opacity: _animation,
//             child: GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: CircleAvatar(
//                   radius: 20.0,
//                   backgroundImage: NetworkImage(
//                     '${snapshot.data() as Map<String,dynamic>['photo_url']}',
//                   ),
//                 ),
//               ),
//               onTap:
//                   () => Navigator.of(context).push(
//                     CupertinoPageRoute(
//                       builder: (context) {
//                         return ProfilePage();
//                       },
//                     ),
//                   ),
//             ),
//           );
//         } else {
//           return GestureDetector(
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: CircleAvatar(
//                 radius: 20.0,
//                 backgroundImage: AssetImage('assets/image/no_image.png'),
//               ),
//             ),
//             onTap:
//                 () => Navigator.of(context).push(
//                   CupertinoPageRoute(
//                     builder: (context) {
//                       return ProfilePage();
//                     },
//                   ),
//                 ),
//           );
//         }
//       },
//     );
//   }
// }

// //Widget que maneja Titulos Reward y stado de la tarea
// class TaskTitle extends StatelessWidget {
//   final String title;
//   final String reward;
//   final String status;
//   final TextStyle titleStyle;
//   final TextStyle statusStyle;
//   final TextStyle otherStyle;
//   final TextStyle rewardStyle;

//   const TaskTitle({
//     Key key,
//     this.rewardStyle,
//     this.reward,
//     this.status,
//     this.titleStyle,
//     this.statusStyle,
//     this.otherStyle,
//     this.title,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.57,
//             child: Text(
//               title,
//               style: titleStyle,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.5,
//             child: Text(status, style: statusStyle),
//           ),
//           Row(
//             children: <Widget>[
//               Text(
//                 localizations.t('home_page.reward') + ' ',
//                 style: otherStyle,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.45,
//                 child: Text(
//                   reward ?? "",
//                   style: rewardStyle,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// //Widget que maneja el leading general de todas las tareas
// class LeadingWidget extends StatelessWidget {
//   final String senderUid;
//   final String receiverUid;
//   const LeadingWidget({Key key, this.senderUid, this.receiverUid})
//     : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pref = UserPreferences();
//     String user = pref.uid;
//     if (senderUid == user) {
//       return receiverUid != null
//           ? SizedBox(
//             width: 150.0,
//             height: 100.0,
//             child: Stack(
//               children: <Widget>[
//                 Positioned(
//                   top: 0.0,
//                   left: 0.0,
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream:
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(senderUid)
//                             .collection(senderUid)
//                             .doc(senderUid)
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.active) {
//                         return CircleAvatarWidget(
//                           radius: 30.0,
//                           imageUrl:
//                               snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                               'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 0.0,
//                   left: 48.0,
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream:
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(receiverUid)
//                             .collection(receiverUid)
//                             .doc(receiverUid)
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.active) {
//                         return CircleAvatarWidget(
//                           radius: 30.0,
//                           imageUrl:
//                               snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                               'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//           : Container();
//     } else if (receiverUid == user) {
//       return senderUid != null
//           ? SizedBox(
//             width: 150.0,
//             height: 100.0,
//             child: Stack(
//               children: <Widget>[
//                 Positioned(
//                   top: 0.0,
//                   left: 0.0,
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream:
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(senderUid)
//                             .collection(senderUid)
//                             .doc(senderUid)
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.active) {
//                         return CircleAvatarWidget(
//                           radius: 30.0,
//                           imageUrl:
//                               snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                               'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 0.0,
//                   left: 48.0,
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream:
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(receiverUid)
//                             .collection(receiverUid)
//                             .doc(receiverUid)
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.active) {
//                         return CircleAvatarWidget(
//                           radius: 30.0,
//                           imageUrl:
//                               snapshot.data() as Map<String,dynamic>['photo_url'] ??
//                               'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//           : Center(child: CircularProgressIndicator());
//     } else {
//       return Center(child: CircularProgressIndicator());
//     }
//   }
// }
