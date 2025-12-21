// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:honeyiou/phone_auth_temp/data_models/country.dart';
// import 'package:honeyiou/phone_auth_temp/firebase/auth/phone_auth/select_country.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/cupertino.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/phone_auth_temp/firebase/auth/phone_auth/verify.dart';
// import 'package:honeyiou/phone_auth_temp/providers/countries.dart';
// import 'package:honeyiou/phone_auth_temp/providers/phone_auth.dart';
// import 'package:honeyiou/phone_auth_temp/utils/widgets.dart';

// import 'settings_app.dart';

// class PhoneNumberPage extends StatefulWidget {
//   const PhoneNumberPage({super.key});

//   @override
//   _PhoneNumberPageState createState() => _PhoneNumberPageState();
// }

// class _PhoneNumberPageState extends State<PhoneNumberPage> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//     getCountryName();
//   }

//   String phoneCode;
//   String flagUrl;
//   final scaffoldKey = GlobalKey<ScaffoldState>(
//     debugLabel: "scaffold-get-phone",
//   );
//   Future<String> getCountryName() async {
//     Position position = await Geolocator().getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     debugPrint('location: ${position.heading}');
//     final coordinates = Coordinates(position.latitude, position.longitude);
//     var addresses = await Geocoder.local.findAddressesFromCoordinates(
//       coordinates,
//     );
//     var first = addresses.first;
//     var myUri = Uri.parse('${first.countryName}');
//     final response = await http.get(
//       'https://restcountries.eu/rest/v2/name/$myUri?fullText=true}',
//     );
//     List<dynamic> decodeBody = json.decode(response.body);

//     for (var element in decodeBody) {
//       List<dynamic> data = element["callingCodes"];

//       for (var number in data) {
//         setState(() {
//           phoneCode = '+' + number;
//         });
//       }
//       print(phoneCode);
//     }
//     var country = Country(dialCode: phoneCode);
//     return first.countryName; // this will return country name
//   }

//   @override
//   Widget build(BuildContext context) {
//     final countriesProvider = Provider.of<CountryProvider>(context);
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );

//     //    getPhoneNumber('234 708 228 6079');
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             children: [
//               GestureDetector(
//                 child: SizedBox(
//                   height: 40.0,
//                   width: 90.0,
//                   // color:Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.arrow_back_ios, color: Colors.white),
//                       Text(
//                         localizations.t('phoneNumber.back'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap:
//                     () => Navigator.of(context).push(
//                       CupertinoPageRoute(builder: (context) => UserSettings()),
//                     ),
//               ),
//               Text(localizations.t('phoneNumber.title')),
//             ],
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xff7a1418),
//           // backgroundColor: Colors.red,
//           automaticallyImplyLeading: false,
//         ),
//         backgroundColor: Color(0xff393939),
//         // backgroundColor: Colors.grey[900],
//         body: SingleChildScrollView(
//           child: _getBody(countriesProvider, localizations),
//         ),
//       ),
//     );
//   }

//   Widget _getBody(CountryProvider countriesProvider, localizations) =>
//       countriesProvider.countries.length > 0
//           ? _getColumnBody(countriesProvider, localizations)
//           : Center(child: CircularProgressIndicator());

//   Widget _getColumnBody(
//     CountryProvider countriesProvider,
//     localizations,
//   ) => SizedBox(
//     height: MediaQuery.of(context).size.height * 0.88,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 15.0),
//         Center(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 0.0),
//                 child: ShowSelectedCountry(
//                   country: countriesProvider.selectedCountry,
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => SelectCountry()),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(width: 5.0),
//               PhoneNumberField(
//                 controller:
//                     Provider.of<PhoneAuthDataProvider>(
//                       context,
//                       listen: false,
//                     ).phoneNumberController,
//                 prefix: "",
//               ),
//             ],
//           ),
//         ),
//         Expanded(child: Container()),
//         Center(
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 15.0,
//               right: 15.0,
//               bottom: MediaQuery.of(context).size.height * 0.03,
//             ),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: ElevatedButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(70.0),
//                 ),
//                 elevation: 0.0,
//                 color: Color(0xff7A1418),
//                 padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//                 onPressed: startPhoneAuth,
//                 child: Container(
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         localizations.t('phoneNumber.buttonText'),
//                         // "Scan QR Code",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15.0,
//                           fontFamily: 'SansRegularlight',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
//   _showSnackBar(String text) {
//     final snackBar = SnackBar(content: Text(text));
//     scaffoldKey.currentState.showSnackBar(snackBar);
//   }

//   startPhoneAuth() async {
//     final phoneAuthDataProvider = Provider.of<PhoneAuthDataProvider>(
//       context,
//       listen: false,
//     );
//     phoneAuthDataProvider.loading = true;
//     var countryProvider = Provider.of<CountryProvider>(context, listen: false);
//     bool validPhone = await phoneAuthDataProvider.instantiate(
//       dialCode: phoneCode ?? countryProvider.selectedCountry.dialCode,
//       onCodeSent: () {
//         Navigator.of(context).pushReplacement(
//           CupertinoPageRoute(
//             builder: (BuildContext context) => PhoneAuthVerify(),
//           ),
//         );
//       },
//       onFailed: () {
//         _showSnackBar(phoneAuthDataProvider.message);
//       },
//       onError: () {
//         _showSnackBar(phoneAuthDataProvider.message);
//       },
//     );
//     if (!validPhone) {
//       phoneAuthDataProvider.loading = false;
//       _showSnackBar("Oops! Number seems invaild");
//       return;
//     }
//   }
// }
