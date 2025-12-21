import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honey_iou_updated/phone_auth_temp/firebase/auth/phone_auth/select_country.dart';
import 'package:honey_iou_updated/phone_auth_temp/firebase/auth/phone_auth/verify.dart';
import 'package:honey_iou_updated/phone_auth_temp/providers/countries.dart';
import 'package:honey_iou_updated/phone_auth_temp/providers/phone_auth.dart';
import 'package:honey_iou_updated/src/providers/login_provider.dart';
import 'package:honey_iou_updated/src/providers/tasks_provider.dart';
import 'package:honey_iou_updated/utils/locale_app.dart';

import 'package:provider/provider.dart';

import '../../../utils/widgets.dart';

/*
 *  PhoneAuthUI - this file contains whole ui and controllers of ui
 *  Background code will be in other class
 *  This code can be easily re-usable with any other service type, as UI part and background handling are completely from different sources
 *  code.dart - Class to control background processes in phone auth verification using Firebase
 */

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  /*
   *  This will be the index, we will modify each time the user selects a new country from the dropdown list(dialog),
   *  As a default case, we are using India as default country, index = 31
   */
  AnimationController? _controller;
  Animation<double>? _animation;
  Animation<Offset>? _offsetFloatTitle;
  Animation<Offset>? _offsetFloatProflePicture;
  Animation<Offset>? _offsetFloatButtom;
  Animation<Offset>? _offsetFloatLeading;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _controller?.forward();

    _offsetFloatTitle = Tween<Offset>(
      begin: Offset(0.0, -2),
      end: Offset(0.0, 0),
    ).animate(_controller!);
    _controller?.forward();

    _offsetFloatProflePicture = Tween<Offset>(
      begin: Offset(-1, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(_controller!);
    _controller!.forward();

    _offsetFloatButtom = Tween<Offset>(
      begin: Offset(0.0, 1),
      end: Offset(0.0, 0),
    ).animate(_controller!);
    _controller!.forward();

    _offsetFloatLeading = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(_controller!);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>(
    debugLabel: "scaffold-get-phone",
  );

  final bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final countriesProvider = Provider.of<CountryProvider>(context);
    // final loader = Provider.of<PhoneAuthDataProvider>(context).loading;
    /*  Scaffold: Using a Scaffold widget as parent
     *  SafeArea: As a precaution - wrapping all child descendants in SafeArea, so that even notched phones won't loose data
     *  Center: As we are just having Card widget - making it to stay in Center would really look good
     *  SingleChildScrollView: There can be chances arising where
     */
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white.withOpacity(0.95),
        body: Stack(
          children: [
            Opacity(
              opacity: 1,
              child: AbsorbPointer(
                absorbing: _loading,
                child: _getBody(countriesProvider),
              ),
            ),
            Opacity(
              opacity: _loading ? 1.0 : 0,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.85),
                  Center(child: SizedBox(child: CircularProgressIndicator())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody(countriesProvider) {
    AppLocalizations? localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: SingleChildScrollView(
              child: Image(image: AssetImage("assets/image/Screenshot1.png")),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                child: FadeTransition(
                  opacity: _animation!,
                  child: Column(
                    children: <Widget>[
                      Text(
                        localizations?.t('loginPage.appName'),
                        style: TextStyle(
                          fontFamily: 'Yesteryear',
                          fontSize: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                      Text(
                        localizations?.t('loginPage.text_1'),
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          localizations?.t('loginPage.text_2'),
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeTransition(
                opacity: _animation!,
                child: Container(
                  child: Center(
                    child: SingleChildScrollView(
                      child: _phoneAuth(countriesProvider, localizations),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              FadeTransition(
                opacity: _animation!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Divider(color: Colors.white),
                      ),
                    ),

                    Text('or', style: TextStyle(color: Colors.white)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Divider(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              FadeTransition(
                opacity: _animation!,
                child:
                    Platform.isIOS
                        ? Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 57.0,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            child: FaIcon(
                              FontAwesomeIcons.apple,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              // Provider.of<LoginState>(
                              //   context,
                              //   listen: false,
                              // ).login(
                              //   context,
                              //   LoginProvider.APPLE,
                              //   "apple",
                              //   () {
                              //     setState(() => _loading = true);
                              //   },
                              // );
                              // setState(() => _loading = true);
                            },
                          ),
                        )
                        : Container(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FadeTransition(
                      opacity: _animation!,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        // color: Colors.ligh
                        height: 57.0,
                        width: 180.0,
                        child: ElevatedButton(
                          child: FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            // Provider.of<LoginState>(
                            //   context,
                            //   listen: false,
                            // ).login(
                            //   context,
                            //   LoginProvider.FACEBOOK,
                            //   "facebook",
                            //   () {
                            //     setState(() => _loading = true);
                            //   },
                            // );
                            // setState(() => _loading = true);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: FadeTransition(
                        opacity: _animation!,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          // color: Colors.ligh
                          height: 57.0,
                          width: 180.0,
                          child: ElevatedButton(
                            child: FaIcon(FontAwesomeIcons.google, size: 30.0),
                            onPressed: () async {
                              // Provider.of<LoginState>(
                              //   context,
                              //   listen: false,
                              // ).login(
                              //   context,
                              //   LoginProvider.GOOGLE,
                              //   "google",
                              //   () {
                              //     setState(() => _loading = true);
                              //   },
                              // );
                              // setState(() => _loading = true);
                              // Provider.of<TasksListProvider>(
                              //   context,
                              //   listen: false,
                              // ).firstFilter = localizations?.t(
                              //   'home_page.allTask',
                              // );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  showPopup(context) {}
  Widget _phoneAuth(CountryProvider countriesProvider, localizations) =>
  /*
         * Fetching countries data from JSON file and storing them in a List of Country model:
         * ref:- List<Country> countries
         * Until the data is fetched, there will be CircularProgressIndicator showing, describing something is on it's way
         * (Previously there was a FutureBuilder rather that the below thing, which created unexpected exceptions and had to be removed)
         */
  // countriesProvider.countries.length > 0
  _getColumnBody(countriesProvider, context, localizations);
  // : Center(child: CircularProgressIndicator());

  Widget _getColumnBody(
    CountryProvider countriesProvider,
    BuildContext context,
    localizations,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 15.0),
      Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // SizedBox(height: 10.0,),
            /*
           *  Select your country, this will be a custom DropDown menu, rather than just as a dropDown
           *  onTap of this, will show a Dialog asking the user to select country they reside,
           *  according to their selection, prefix will change in the PhoneNumber TextFormField
           */
            // Padding(
            //   padding: const EdgeInsets.only(left: 0.0),
            //   child: ShowSelectedCountry(
            //     country: countriesProvider.selectedCountry,
            //     onPressed: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => SelectCountry()),
            //       );
            //     },
            //   ),
            // ),
            //  Subtitle for Enter your phone
            SizedBox(width: 5.0),
            // PhoneNumberField(
            //   controller:
            //       Provider.of<PhoneAuthDataProvider>(
            //         context,
            //         listen: false,
            //       ).phoneNumberController,
            //   prefix: "",
            // ),
            /*
             *  Button: OnTap of this, it appends the dial code and the phone number entered by the user to send OTP,
             *  knowing once the OTP has been sent to the user - the user will be navigated to a new Screen,
             *  where is asked to enter the OTP he has received on his mobile (or) wait for the system to automatically detect the OTP
             */
          ],
        ),
      ),
      SizedBox(height: 10.0),
      Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.064,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            onPressed: () {
              startPhoneAuth(context, localizations);
              //Provider.of<PhoneAuthDataProvider>(context, listen: false).context = context;
            },
            child: Text(
              localizations.t('loginPage.buttomText'),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );

  startPhoneAuth(context, localizations) async {
  //   final phoneAuthDataProvider = Provider.of<PhoneAuthDataProvider>(
  //     context,
  //     listen: false,
  //   );
  //   phoneAuthDataProvider.loading = true;
  //   phoneAuthDataProvider.typeAuth = "phone";
  //   var countryProvider = Provider.of<CountryProvider>(context, listen: false);
  //   bool validPhone = await phoneAuthDataProvider.instantiate(
  //     dialCode: countryProvider.selectedCountry.dialCode,
  //     onCodeSent: () {
  //       Navigator.of(context).push(
  //         CupertinoPageRoute(
  //           builder: (BuildContext context) => PhoneAuthVerify(),
  //         ),
  //       );
  //     },
  //     onVerified: () {
  //       setState(() {});
  //     },
  //     onFailed: () {
  //       // _showSnackBar(phoneAuthDataProvider.message);
  //       print(phoneAuthDataProvider.message);
  //     },
  //     onError: () {
  //       // _showSnackBar(phoneAuthDataProvider.message);
  //     },
  //   );
  //   if (!validPhone) {
  //     phoneAuthDataProvider.loading = false;
  //     // _showSnackBar("Oops! Number seems invaild");
  //     return;
  //   }
  //   Navigator.of(context).push(
  //     CupertinoPageRoute(builder: (BuildContext context) => PhoneAuthVerify()),
  //   );
  }
}
