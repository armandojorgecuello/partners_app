// import 'package:firebase_messaging/firebase_messaging.dart';


// import 'dart:async';




// class PushNotificationprovider{


//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   final _notiStreamController = StreamController<dynamic>.broadcast(); 
//   Stream<Map <String,dynamic>> get info => _notiStreamController.stream;
  


//   // initNotificactions()async {
//   //   _firebaseMessaging.requestNotificationPermissions();
//   //   _firebaseMessaging.configure(
//   //        onMessage: (Map<String, dynamic> info) async {


//   //       if (Platform.isAndroid) {
        
//   //       _notiStreamController.sink.add(info);

//   //       }
//   //     },
//   //     onLaunch: (Map<String, dynamic>  info) async {
        
//   //       if (Platform.isAndroid) {
        
//   //       _notiStreamController.sink.add(info);

//   //       }
//   //     },
//   //     onResume: (Map<String, dynamic> info) async {
        
//   //       if (Platform.isAndroid) {
        
//   //       _notiStreamController.sink.add(info);

//   //       }
//   //     },
//   //   );
//   // }

//   // disponse(){
//   //   _notiStreamController?.close();
//   // }

// }