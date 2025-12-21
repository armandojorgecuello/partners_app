// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:simple_animations/simple_animations.dart';

// class CircleAvatarWidget extends StatefulWidget {
//   final String imageUrl;
//   final double radius;
//   const CircleAvatarWidget({Key key, this.imageUrl, this.radius})
//     : super(key: key);

//   @override
//   _CircleAvatarWidgetState createState() => _CircleAvatarWidgetState();
// }

// class _CircleAvatarWidgetState extends State<CircleAvatarWidget>
//     with TickerProviderStateMixin {
//   bool _isLoading = true;
//   Image imagenBackground;
//   AnimationController _controller;
//   Animation<double> _animation;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();
//     // String image = widget.rewardUrl.data() as Map<String,dynamic>['reward_img_url'];
//     imagenBackground = Image.network(widget.imageUrl);
//     imagenBackground.image
//         .resolve(ImageConfiguration())
//         .addListener(
//           ImageStreamListener((ImageInfo image, bool syncronousCall) {
//             if (mounted) {
//               setState(() {
//                 _isLoading = false;
//               });
//             }
//           }),
//         );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTrackTween([
//       Track("color").add(
//         Duration(milliseconds: 800),
//         ColorTween(begin: Colors.black, end: Colors.grey[300]),
//       ),
//       Track("color1").add(
//         Duration(milliseconds: 800),
//         ColorTween(begin: Colors.grey[300], end: Colors.black54),
//       ),
//     ]);
//     return _isLoading
//         ? ControlledAnimation(
//           playback: Playback.MIRROR,
//           tween: tween,
//           duration: tween.duration,
//           builder: (context, animation) {
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50.0),
//                 gradient: LinearGradient(
//                   begin: Alignment.topRight,
//                   end: Alignment.topLeft,
//                   colors: [animation["color1"], animation["color"]],
//                 ),
//               ),
//             );
//           },
//         )
//         : Container(
//           child: FadeTransition(
//             opacity: _animation,
//             child: CircleAvatar(
//               radius: widget.radius,
//               backgroundImage: NetworkImage(widget.imageUrl),
//             ),
//           ),
//         );
//   }
// }

// class PopUpElement extends StatefulWidget {
//   final String uidReceiver;
//   final String uidSender;
//   final String nameSender;
//   final Function onPressed;

//   const PopUpElement({
//     Key key,
//     this.uidReceiver,
//     this.uidSender,
//     this.nameSender,
//     this.onPressed,
//   }) : super(key: key);
//   @override
//   _PopUpElementState createState() =>
//       _PopUpElementState(uidReceiver, uidSender, nameSender, onPressed);
// }

// class _PopUpElementState extends State<PopUpElement>
//     with TickerProviderStateMixin {
//   final String uidReceiver;
//   final String uidSender;
//   final String nameSender;
//   final Function onPressed;

//   _PopUpElementState(
//     this.uidReceiver,
//     this.uidSender,
//     this.nameSender,
//     this.onPressed,
//   );
//   Animation<double> _animation;
//   AnimationController _controller;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );

//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = UsuarioProvider();
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return Stack(
//       children: [
//         Positioned(
//           left: 77,
//           child: StreamBuilder(
//             stream: user.getPartnerData(uidReceiver),
//             builder: (_, snapshot) {
//               // snapshot.connectionState == ConnectionState.waiting ? return
//               return snapshot.data() as Map<String,dynamic>["photo_url"] != null
//                   ? FadeTransition(
//                     opacity: _animation,
//                     child: CircleAvatarWidget(
//                       imageUrl: snapshot.data() as Map<String,dynamic>["photo_url"],
//                       radius: 30.0,
//                     ),
//                   )
//                   : CircleAvatar(
//                     backgroundImage: AssetImage("assets/image/no_image.png"),
//                     radius: 30.0,
//                   );
//               //
//             },
//           ),
//         ),
//         Positioned(
//           right: 77.0,
//           child: StreamBuilder(
//             stream: user.getPartnerData(uidSender),
//             builder: (_, snapshot) {
//               return snapshot.data() as Map<String,dynamic>["photo_url"] != null
//                   ? FadeTransition(
//                     opacity: _animation,
//                     child: CircleAvatarWidget(
//                       imageUrl: snapshot.data() as Map<String,dynamic>["photo_url"],
//                       radius: 30.0,
//                     ),
//                   )
//                   : CircleAvatar(
//                     backgroundImage: AssetImage("assets/image/no_image.png"),
//                     radius: 30.0,
//                   );
//               //
//             },
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//             Center(
//               child: Container(
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Text(
//                     localizations.t('addPartners.textDialogAfterScan1') +
//                         " " +
//                         nameSender +
//                         " " +
//                         localizations.t('addPartners.textDialogAfterScan2'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Sans',
//                       fontSize: 12.0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             SizedBox(height: 10.0),
//             Center(
//               child: Container(
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Text(
//                     localizations.t('addPartners.textDialogAfterScan3'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 12.0,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             SizedBox(height: 20.0),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(width: 10.0),
//                   Container(
//                     height: 33.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50.0),
//                       color: Color(0xffBF2328),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         onPressed();
//                       },
//                       child: Text(
//                         localizations.t('startNegociation.okButtonDialog'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SansRegularlight',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class PopUpElementAfterPayment extends StatefulWidget {
//   final String receiveruid;
//   final String senderUid;
//   final String nameSender;
//   final String taskId;
//   final String imageSender;

//   const PopUpElementAfterPayment({
//     Key key,
//     this.receiveruid,
//     this.senderUid,
//     this.nameSender,
//     this.taskId,
//     this.imageSender,
//   }) : super(key: key);
//   @override
//   _PopUpElementAfterPaymentState createState() =>
//       _PopUpElementAfterPaymentState(
//         receiveruid,
//         senderUid,
//         nameSender,
//         taskId,
//         imageSender,
//       );
// }

// class _PopUpElementAfterPaymentState extends State<PopUpElementAfterPayment>
//     with TickerProviderStateMixin {
//   final String receiveruid;
//   final String senderUid;
//   final String nameSender;
//   final String taskId;
//   final String imageSender;

//   _PopUpElementAfterPaymentState(
//     this.receiveruid,
//     this.senderUid,
//     this.nameSender,
//     this.taskId,
//     this.imageSender,
//   );

//   Animation<Offset> _offsetFloatProflePicture;
//   Animation<Offset> _offsetFloatLeading;
//   AnimationController _controller;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );

//     _offsetFloatProflePicture = Tween<Offset>(
//       begin: Offset(-1, 0.0),
//       end: Offset(0.0, 0.0),
//     ).animate(_controller);
//     _controller.forward();

//     _offsetFloatLeading = Tween<Offset>(
//       begin: Offset(1.0, 0.0),
//       end: Offset.zero,
//     ).animate(_controller);
//     _controller.forward();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = UsuarioProvider();
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     return Stack(
//       children: [
//         Positioned(
//           left: 77,
//           child: SlideTransition(
//             position: _offsetFloatProflePicture,
//             child: StreamBuilder(
//               stream: user.getPartnerData(receiveruid),
//               builder: (_, snapshot) {
//                 return CircleAvatarWidget(
//                   imageUrl: snapshot.data() as Map<String,dynamic>["photo_url"],
//                   radius: 30.0,
//                 );
//                 //
//               },
//             ),
//           ),
//         ),
//         Positioned(
//           right: 77.0,
//           child: SlideTransition(
//             position: _offsetFloatLeading,
//             child: CircleAvatarWidget(imageUrl: imageSender, radius: 30.0),
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//             Center(
//               child: Container(
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Text(
//                     localizations.t('startNegociation.afterPaymentText1') +
//                         " " +
//                         nameSender,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Sans',
//                       fontSize: 12.0,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             SizedBox(height: 10.0),
//             Center(
//               child: Container(
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Text(
//                     localizations.t('startNegociation.afterPaymentDesc'),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SansRegularlight',
//                       fontSize: 12.0,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             SizedBox(height: 20.0),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(width: 10.0),
//                   Container(
//                     height: 33.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50.0),
//                       color: Color(0xffBF2328),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         Navigator.of(context).popAndPushNamed('chat_page');
//                       },
//                       child: Text(
//                         localizations.t('startNegociation.okButtonDialog'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SansRegularlight',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
