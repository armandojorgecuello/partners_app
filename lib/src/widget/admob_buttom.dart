// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_countdown_timer/index.dart';
// import 'package:honeyiou/src/models/profile_model.dart';
// import 'package:honeyiou/src/pages/task/negociation.dart';
// import 'package:honeyiou/src/providers/free_coins_provider.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';
// import 'package:provider/provider.dart';

// import 'show_dialog_task_end.dart';

// class AdMobButton extends StatefulWidget {
//   final String prevPage;

//   const AdMobButton({Key key, this.prevPage}) : super(key: key);
//   @override
//   _AdMobButtonState createState() => _AdMobButtonState(prevPage);
// }

// class _AdMobButtonState extends State<AdMobButton>
//     with TickerProviderStateMixin {
//   final String prevPage;
//   _AdMobButtonState(this.prevPage);
//   static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     childDirected: true,
//     nonPersonalizedAds: true,
//   );
//   AnimationController _controller;
//   Animation<double> _animation;
//   bool isAdmobLoades = false;
//   bool isLodingVideo = false;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     RewardedVideoAd.instance.listener = rewarded;

//     RewardedVideoAd.instance
//         .load(
//           adUnitId: "ca-app-pub-4666613317919939/7781673557",
//           targetingInfo: targetingInfo,
//         )
//         .catchError((e) => print("error in loading 1st time"));

//     super.initState();
//   }

//   bool available = true;
//   @override
//   Widget build(BuildContext context) {
//     final userUid = UserPreferences().uid;
//     final limitStream = FreeCoinsProvider().getLimitVideoCoins();
//     final getCoins = FreeCoinsProvider().getLastCoins(userUid);
//     return StreamBuilder<DocumentSnapshot>(
//       stream: limitStream,
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshotLimit) {
//         if (snapshotLimit.connectionState == ConnectionState.waiting)
//           return Container(child: Center(child: CircularProgressIndicator()));
//         return StreamBuilder<UserData>(
//           stream: UsuarioProvider(uid: userUid).userData,
//           builder: (context, snapshotCoins) {
//             if (snapshotCoins.connectionState == ConnectionState.waiting)
//               return Container(
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             DateTime fecha1;
//             DateTime futureData;
//             int diference;
//             Timestamp time;
//             if (snapshotCoins.data.last_free_coin != null) {
//               time = snapshotCoins.data.last_free_coin;
//               int limitinMinutes =
//                   ((24 / snapshotLimit.data.data() as Map<String,dynamic>["ammount"]) * 60 * 60).round();
//               fecha1 = time.toDate();
//               futureData = DateTime(
//                 fecha1.year,
//                 fecha1.month,
//                 fecha1.day,
//                 fecha1.hour,
//                 fecha1.minute,
//                 fecha1.second + limitinMinutes,
//               );
//               diference = futureData.difference(fecha1).inSeconds;
//             } else {
//               futureData = DateTime.now().toUtc();
//             }
//             log(fecha1.toString());
//             log(futureData.toString());
//             log(diference.toString());
//             return FadeTransition(
//               opacity: _animation,
//               child:
//                   isLodingVideo == false
//                       ? ButtonAdMobWidget(
//                         timereamin: futureData,
//                         prevPage: prevPage,
//                         loading: () {
//                           setState(() {
//                             isLodingVideo = true;
//                           });
//                         },
//                       )
//                       : Container(
//                         child: Center(child: CircularProgressIndicator()),
//                       ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void rewarded(
//     RewardedVideoAdEvent event, {
//     String rewardType,
//     int rewardAmount,
//   }) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     String uidUser = UserPreferences().uid;
//     final taskProvider = Provider.of<TasksListProvider>(context, listen: false);
//     String taskId = taskProvider.idTask;
//     if (event == RewardedVideoAdEvent.loaded) {
//       log("$event");
//       setState(() {
//         isAdmobLoades = true;
//       });
//     } else if (event == RewardedVideoAdEvent.rewarded) {
//       if (prevPage == "buy") {
//         FreeCoinsProvider().freeCoinsuserHistory(uidUser);
//       }
//       if (prevPage == "start_neg") {
//         FreeCoinsProvider().updateLastFreeCoin(uidUser);
//         TasksListProvider().updateStatus(taskId, 'open');
//         Navigator.of(context).pop();
//         ShowDialogBoxFinish().showDialogAfterPayment(
//           taskProvider.idTask,
//           localizations,
//           context,
//           () {},
//           "",
//           taskProvider.senderUid,
//           taskProvider.receiverUid,
//           taskProvider.idTask,
//         );
//       }
//     } else if (event == RewardedVideoAdEvent.closed) {
//       if (prevPage == "buy") {
//         showgeneralDialog(() {
//           setState(() {});
//         });
//       }
//       RewardedVideoAd.instance.load(
//         adUnitId: RewardedVideoAd.testAdUnitId,
//         targetingInfo: targetingInfo,
//       );
//       setState(() {
//         isLodingVideo = false;
//       });
//     } else if (event == RewardedVideoAdEvent.failedToLoad) {
//       RewardedVideoAd.instance.load(
//         adUnitId: RewardedVideoAd.testAdUnitId,
//         targetingInfo: targetingInfo,
//       );
//       log("Failure charge video");
//     }
//   }

//   showgeneralDialog(Function onPressed) {
//     showGeneralDialog(
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(1.0) - (a1.value);
//         AppLocalizations localizations = Localizations.of<AppLocalizations>(
//           context,
//           AppLocalizations,
//         );
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               title: Center(
//                 child: Text(
//                   localizations.t('buyCredits.popUpTitle'),
//                   style: TextStyle(
//                     color: Color(0xffFFFFFF),
//                     fontSize: 14.0,
//                     fontFamily: 'Sans',
//                   ),
//                 ),
//               ),
//               backgroundColor: Color(0xff282828),
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image(
//                           image: AssetImage('assets/image/coin.png'),
//                           width: 80.0,
//                           height: 80.0,
//                           fit: BoxFit.cover,
//                         ),
//                         SizedBox(width: 5.0),
//                         Text(
//                           "+ 1",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 28.0,
//                             fontFamily: 'Sans',
//                           ),
//                         ),
//                       ],
//                     ),
//                     Center(
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.65,
//                         child: Text(
//                           localizations.t('buyCredits.popUpDesc'),
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
//                           // onPressed();

//                           Navigator.pop(context);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => TasksPage()),
//                           );
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         // color: Colors.red,
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
//       barrierDismissible: false,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return Sizedbox();
//       },
//     );
//   }
// }

// class ButtonAdMobWidget extends StatefulWidget {
//   final DateTime timereamin;
//   final String prevPage;
//   final String username;
//   final bool isLoadedVideoAdd;
//   final Function loading;

//   const ButtonAdMobWidget({
//     Key key,
//     this.timereamin,
//     this.prevPage,
//     this.username,
//     this.isLoadedVideoAdd,
//     this.loading,
//   }) : super(key: key);

//   @override
//   _ButtonAdMobWidgetState createState() =>
//       _ButtonAdMobWidgetState(timereamin, prevPage, username);
// }

// class _ButtonAdMobWidgetState extends State<ButtonAdMobWidget> {
//   final DateTime timereamin;
//   final String prevPage;
//   final String username;
//   _ButtonAdMobWidgetState(this.timereamin, this.prevPage, this.username);
//   static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     childDirected: true,
//     nonPersonalizedAds: true,
//   );
//   CountdownTimerController controller;

//   @override
//   void initState() {
//     int endTime = timereamin.millisecondsSinceEpoch + 1000;
//     controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
//     super.initState();
//   }

//   void onEnd() {
//     log("Finalizado conteo");
//   }

//   showRewardAd() async {
//     RewardedVideoAd.instance.load(
//       adUnitId: RewardedVideoAd.testAdUnitId,
//       targetingInfo: targetingInfo,
//     );

//     bool adIsDisplayed = false;
//     do {
//       try {
//         adIsDisplayed = (await RewardedVideoAd.instance.show() ?? false);
//       } catch (e) {}
//     } while (!adIsDisplayed);
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return Column(
//       children: [
//         CountdownTimer(
//           controller: controller,
//           widgetBuilder: (_, CurrentRemainingTime time) {
//             TextStyle style = TextStyle(
//               color: Colors.white,
//               fontFamily: 'SansRegularlight',
//             );
//             // if(time.hours != null || time.min != null || time.sec != null time ==  ){
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50.0),
//                 color: Color(0xff7a1418),
//               ),
//               child: ElevatedButton(
//                 onPressed:
//                     time != null
//                         ? () {}
//                         : () {
//                           widget.isLoadedVideoAdd == true
//                               ? RewardedVideoAd.instance.show()
//                               : showRewardAd();
//                           widget.loading();
//                         },
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.45,
//                   child:
//                       time == null
//                           ? Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.ondemand_video, color: Colors.white),
//                               SizedBox(width: 10.0),
//                               Text(
//                                 localizations.t("startNegociation.whatchVideo"),
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           )
//                           : Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 prevPage == "buy"
//                                     ? localizations.t(
//                                           "buyCredits.remainCounter",
//                                         ) +
//                                         ": "
//                                     : localizations.t(
//                                           "buyCredits.remainCounterI",
//                                         ) +
//                                         ": ",
//                                 style: style,
//                               ),
//                               Text(
//                                 time.hours != null
//                                     ? time.hours.bitLength == 1
//                                         ? "0${time.hours}:"
//                                         : "${time.hours}:"
//                                     : "00:",
//                                 style: style,
//                               ),
//                               Text(
//                                 time.min != null
//                                     ? time.min.bitLength == 1
//                                         ? "0${time.min}:"
//                                         : "${time.min}:"
//                                     : "00:",
//                                 style: style,
//                               ),
//                               Text(
//                                 time.sec != null
//                                     ? time.sec.bitLength == 1
//                                         ? "0${time.sec}"
//                                         : "${time.sec}"
//                                     : "00",
//                                 style: style,
//                               ),
//                             ],
//                           ),
//                 ),
//               ),
//             );
//             // }
//           },
//         ),
//       ],
//     );
//   }
// }
