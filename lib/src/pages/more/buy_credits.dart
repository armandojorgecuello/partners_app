// import 'dart:async';
// import 'dart:developer';

// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/providers/buy_Credits_provider.dart';
// import 'package:honeyiou/src/widget/admob_buttom.dart';
// import 'package:honeyiou/src/widget/appbar_widget.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:provider/provider.dart';

// class BuyCredits extends StatefulWidget {
//   const BuyCredits({super.key});

//   @override
//   _BuyCreditsState createState() => _BuyCreditsState();
// }

// class _BuyCreditsState extends State<BuyCredits> with TickerProviderStateMixin {
//   static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     childDirected: true,
//     nonPersonalizedAds: true,
//   );

//   StreamSubscription _subscription;

//   AnimationController _controller;
//   Animation<double> _animation;
//   @override
//   void initState() {
//     FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     try {
//       RewardedVideoAd.instance.load(
//         adUnitId: RewardedVideoAd.testAdUnitId,
//         targetingInfo: targetingInfo,
//       );
//     } catch (e) {
//       print(e);
//     }

//     final Stream purchaseUpdates =
//         InAppPurchaseConnection.instance.purchaseUpdatedStream;
//     _subscription = purchaseUpdates.listen((purchases) {
//       _handlePurchaseUpdates(purchases);
//     });

//     super.initState();
//   }

//   _handlePurchaseUpdates(purchases) {}

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           titleSpacing: 0.0,
//           title: FadeTransition(
//             opacity: _animation,
//             child: PreferredSize(
//               child: AppBarWidget(
//                 title: localizations.t('buyCredits.title'),
//                 buttontext: localizations.t('buyCredits.back'),
//               ),
//               preferredSize: Size.fromHeight(55.0),
//             ),
//           ),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xff7a1418),
//         ),
//         backgroundColor: Color(0xff393939),
//         body: body(context, localizations),
//       ),
//     );
//   }

//   Widget body(context, AppLocalizations localizations) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/image/Screenshot1.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               SizedBox(height: 1.0),
//               AdMobButton(prevPage: "buy"),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Divider(color: Colors.white),
//               ),
//               buy('X 5  ', '2.50', 'assets/image/coin.png'),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Divider(color: Colors.white),
//               ),
//               buy('X 10', '5.00', 'assets/image/coin.png'),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Divider(color: Colors.white),
//               ),
//               buy('X 15', '7.50', 'assets/image/coin.png'),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Divider(color: Colors.white),
//               ),
//               buy('X 20', '9.00', 'assets/image/coin_10.png'),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Divider(color: Colors.white),
//               ),
//               buy('X 50', '20.00', 'assets/image/coin_20.png'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buy(String numero, String cantidad, String logo) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//         child: Row(
//           children: <Widget>[
//             FadeTransition(
//               opacity: _animation,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(90.0),
//                 ),
//                 width: 90.0,
//                 height: 90.0,
//                 child: Image(image: AssetImage(logo), fit: BoxFit.cover),
//               ),
//             ),
//             SizedBox(width: 10.0),
//             FadeTransition(
//               opacity: _animation,
//               child: Text(
//                 numero,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Sans',
//                   fontSize: 21.0,
//                 ),
//               ),
//             ),
//             Expanded(child: Container()),
//             FadeTransition(
//               opacity: _animation,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.0),
//                   color: Color(0xff7a1418),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   padding: EdgeInsets.symmetric(horizontal: 70.0),
//                   child: Text(
//                     '\$'
//                     "$cantidad",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
