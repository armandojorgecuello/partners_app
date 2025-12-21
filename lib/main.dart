// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:honey_iou_updated/phone_auth_temp/providers/countries.dart';
import 'package:honey_iou_updated/src/onboarding/onboarding.dart';
// import 'package:honey_iou_updated/src/pages/more/buy_credits.dart';
// import 'package:honey_iou_updated/src/pages/more/privacity_policy_page.dart';
// import 'package:honey_iou_updated/src/pages/more/terms_services_page.dart';
// import 'package:honey_iou_updated/src/pages/task/new_terms_chat.dart';
// import 'package:honey_iou_updated/src/pages/task/pay_your_partner.dart';
// import 'package:honey_iou_updated/src/pages/task/update_task.dart';
// import 'package:honey_iou_updated/src/pages/task/view_reward.dart';
// import 'package:honey_iou_updated/src/providers/login_provider.dart';
import 'package:provider/provider.dart';

// import 'partners/add_partner.dart';
// import 'partners/partner_accept_list.dart';
// import 'partners/partners_requests_list.dart';
import 'phone_auth_temp/firebase/auth/phone_auth/get_phone.dart';
import 'phone_auth_temp/firebase/auth/phone_auth/verify.dart';
// import 'phone_auth_temp/new_user.dart';
// import 'phone_auth_temp/providers/countries.dart';
// import 'phone_auth_temp/providers/phone_auth.dart';
// import 'src/pages/images/my_images_page.dart';
// import 'src/pages/more/notifications.dart';
// import 'src/pages/more/send_support.dart';
// import 'src/pages/more/show_notifi.dart';
// import 'src/pages/more/support_ticket.dart';
// import 'src/pages/others/phone_number.dart';
// import 'src/pages/others/profile_page.dart';
// import 'src/pages/others/settings_app.dart';
// import 'src/pages/others/validation_change_num.dart';
// import 'src/pages/task/complete_task.dart';
// import 'src/pages/task/negociation.dart';
// import 'src/pages/task/start_negociation_task.dart';
// import 'src/pages/task/view_task.dart';
// import 'src/pages/task/new_task_page.dart';
// import 'src/providers/buy_Credits_provider.dart';
// import 'src/providers/tasks_provider.dart';
import 'utils/locale_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase before running the app.
  // await Firebase.initializeApp();
  //final pref = UserPreferences();
  //await pref.intitPref();
  // FirebaseAdMob.instance.initialize(appId: "com.atomicvelvet.honeyiou");
  //InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> snackBar = GlobalKey<ScaffoldState>();
  //static final  user = UserPreferences();
  //String userUID = user.uid;
  //String taskID;
  //String senderUID;
  //String receiverUID;
  //String status;
  //String typeNoti;
  //final pref = UserPreferences();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Honey IOU ';
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<LoginState>(
        //   create: (BuildContext context) => LoginState(auth),
        // ),
        ChangeNotifierProvider(create: (context) => CountryProvider()),
        // ChangeNotifierProvider(
        //   create:
        //       (context) => PhoneAuthDataProvider(auth, context, navigatorKey),
        // ),
        // ChangeNotifierProvider<TasksListProvider>(
        //   create: (context) => TasksListProvider(),
        // ),
        // ChangeNotifierProvider<BuyCreditsProvider>(
        //   create: (context) => BuyCreditsProvider(),
        // ),
        // Placeholder provider so providers list is not empty while the real
        // providers above are commented out. Remove when enabling real ones.
        Provider<int>.value(value: 0),
      ],
      child: MaterialApp(
      // builder: (context, widget)=> ResponsiveWrapper.builder(
      //   BouncingScrollWrapper.builder(context, widget),
      //   maxWidth: 1250,
      //   minWidth: 450,
      //   defaultScale: true,
      //   breakpoints: [
      //     ResponsiveBreakpoint.resize(450, name:MOBILE),
      //     ResponsiveBreakpoint.autoScale(800, name:TABLET),
      //     ResponsiveBreakpoint.autoScale(1000, name:TABLET),
      //     ResponsiveBreakpoint.resize(1200, name:DESKTOP),
      //     ResponsiveBreakpoint.autoScale(2460, name: "4K")
      //   ],
      //   background: Container(color:Color(0xffab0000))
      // ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.red),
      routes: {
        "/": (BuildContext context) => LoginPage(),
        "loginPage": (BuildContext context) => LoginPage(),
        // "profile": (BuildContext context) => ProfilePage(),
        "code": (BuildContext context) => PhoneAuthVerify(),
        // "home_page": (BuildContext context) => TasksPage(),
        // "setting": (BuildContext context) => UserSettings(),
        // "partners_request": (BuildContext context) => PartnersRequest(),
        // "add_partners": (BuildContext context) => AddPartner(),
        // "change": (BuildContext context) => ChangeNumber(),
        // "notifications": (BuildContext context) => NotificationsPage(),
        // "images": (BuildContext context) => ImagesPage(),
        // "phone_number": (BuildContext context) => PhoneNumberPage(),
        // "privacy_policy": (BuildContext context) => PrivacityPolicyPage(),
        // "terms_service": (BuildContext context) => TermsOfServicePage(),
        // "new_task": (BuildContext context) => NewTaskPage(),
        // "start_negociation": (BuildContext context) => StartNegociationPage(),
        // "partners_accepted": (BuildContext context) => PartnersAccepted(),
        // "support_tiquet": (BuildContext context) => SupportTicketsPage(),
        // 'send_support_ticket':
        // (BuildContext context) => SendSupportTicketsPage(),
        // 'chat_page': (BuildContext context) => ChatPage(),
        // 'view_task': (BuildContext context) => ViewTask(),
        // 'view_reward': (BuildContext context) => ViewReward(),
        // 'update_task': (BuildContext context) => UpdateTaskPage(),
        // 'buy_credits': (BuildContext context) => BuyCredits(),
        // 'complete_task': (BuildContext context) => CompleteTask(),
        // 'pay_your_partner': (BuildContext context) => PayYourPartnerPage(),
        // 'notifications_page': (BuildContext context) => ShowNotifications(),
        'onboarding': (BuildContext context) => Onboarding(),
        // 'new_user': (BuildContext context) => NewUser(),
      },
      supportedLocales: [Locale('en'), Locale('es')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    )
    );
  }
}

// class InitialPage extends StatefulWidget {
//   const InitialPage({super.key});

//   @override
//   _InitialPageState createState() => _InitialPageState();
// }

// class _InitialPageState extends State<InitialPage> {
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations? localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     // FirebaseAuth sb = Provider.of<LoginState>(context).auth;
//     //final pref = UserPreferences();
//     //String typeAuth = pref.type;

//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: sb.authStateChanges(),
//         builder: (context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return AlertDialog(
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text("Getting Authentication Status"),
//                   SizedBox(height: 5.0),
//                   Container(
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         backgroundColor: Color(0xffab0000),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               backgroundColor: Colors.black12,
//             );
//           } else {
//             if (snapshot.hasData) {
//               return StreamBuilder(
//                 stream:
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(snapshot.data!.uid)
//                         .collection(snapshot.data!.uid)
//                         .doc(snapshot.data!.uid)
//                         .snapshots(),
//                 builder: (context, AsyncSnapshot snap) {
//                   if (snap.connectionState == ConnectionState.waiting) {
//                     return AlertDialog(
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text("Getting Authentication Status"),
//                           SizedBox(height: 5.0),
//                           Container(
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 backgroundColor: Color(0xffab0000),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       backgroundColor: Colors.black12,
//                     );
//                   } else {
//                     if (snap.hasData) {
//                       if ((snap.data() as Map<String,dynamic>)["first_launch"] != true &&
//                           (snap.data() as Map<String,dynamic>)["name"] != null) {
//                         return TasksPage(
//                           firstFilterInitialValue: localizations?.t(
//                             'home_page.receiveFromPartner',
//                           ),
//                         );
//                       } else {
//                         return NewUser();
//                       }
//                     } else {
//                       return LoginPage();
//                     }
//                   }
//                 },
//               );
//             } else {
//               return LoginPage();
//             }
//           }
//         },
//       ),
//     );
//   }
// }
