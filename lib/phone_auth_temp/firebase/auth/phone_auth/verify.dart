import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honey_iou_updated/phone_auth_temp/providers/countries.dart';
import 'package:honey_iou_updated/phone_auth_temp/providers/phone_auth.dart';
import 'package:honey_iou_updated/utils/locale_app.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';

class PhoneAuthVerify extends StatefulWidget {
  final String? phoneNumber;

  const PhoneAuthVerify({Key? key, this.phoneNumber}) : super(key: key);
  /*
   *  cardBackgroundColor & logo values will be passed to the constructor
   *  here we access these params in the _PhoneAuthState using "widget"
   */

  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
}

class _PhoneAuthVerifyState extends State<PhoneAuthVerify>
    with TickerProviderStateMixin {
  double? _height, _width, _fixedPadding;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";
  bool _loading = false;
  AnimationController? _controller;
  Animation<double>? _animation;
  Animation<Offset>? _offsetFloatTitle;
  Animation<Offset>? _offsetFloatButtom;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);

    _offsetFloatTitle = Tween<Offset>(
      begin: Offset(0.0, -2),
      end: Offset(0.0, 0),
    ).animate(_controller!);
    _controller!.forward();

    _offsetFloatButtom = Tween<Offset>(
      begin: Offset(0.0, 1),
      end: Offset(0.0, 0),
    ).animate(_controller!);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>(
    debugLabel: "scaffold-verify-phone",
  );
  final _formKey = GlobalKey<FormState>();
  String? codeAuth;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    //  Fetching height & width parameters from the MediaQuery
    AppLocalizations? localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    //  _logoPadding will be a constant, scaling it according to device's size
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height! * 0.025;

    // final phoneAuthDataProvider = Provider.of<PhoneAuthDataProvider>(
    //   context,
    //   listen: false,
    // );

    // phoneAuthDataProvider.setMethods(
    //   onStarted: onStarted,
    //   onError: onError,
    //   onFailed: onFailed,
    //   onVerified: onVerified,
    //   onCodeResent: onCodeResent,
    //   onCodeSent: onCodeSent,
    //   onAutoRetrievalTimeout: onAutoRetrievalTimeOut,
    // );

    /*
     *  Scaffold: Using a Scaffold widget as parent
     *  SafeArea: As a precaution - wrapping all child descendants in SafeArea, so that even notched phones won't loose data
     *  Center: As we are just having Card widget - making it to stay in Center would really look good
     *  SingleChildScrollView: There can be chances arising where
     */
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _builBackground(),
            SingleChildScrollView(child: _getBody(localizations)),
            Positioned(
              left: 10.0,
              // top:MediaQuery.of(context).size.height*0.1,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builBackground() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: SingleChildScrollView(
        child: Image(image: AssetImage("assets/image/Screenshot1.png")),
      ),
    );
  }

  Widget _crearTexto(localizations) {
    return Center(
      child: FadeTransition(
        opacity: _animation!,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              "Honey IOU",
              style: TextStyle(
                fontFamily: 'Yesteryear',
                fontSize: 50.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              localizations.t('verify.textVal'),
              // '',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ],
        ),
      ),
    );
  }

  Widget _getBody(localizations) => Container(
    child: FadeTransition(
      opacity: _animation!,
      child: _getColumnBody(localizations),
    ),
  );

  Widget _getColumnBody(localizations) => Form(
    key: _formKey,
    child: Column(
      children: <Widget>[
        _crearTexto(localizations),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              obscureText: false,
              obscuringCharacter: '*',
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 6) {
                  return null;
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                // shape:
                shape: PinCodeFieldShape.circle,
                activeColor: Colors.red,
                disabledColor: Colors.white,
                selectedFillColor: Colors.red,
                inactiveColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedColor: Colors.red,
                // borderRadius: BorderRadius.circular(40),
                fieldHeight: 60,
                fieldWidth: 50,
                activeFillColor: hasError ? Colors.white : Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              textStyle: TextStyle(
                fontSize: 20,
                height: 1.6,
                color: Colors.white,
              ),
              backgroundColor: Colors.white.withOpacity(0.0),
              enableActiveFill: false,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
              onCompleted: (v) {
                print("Completed");
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                print(value);
                setState(() {
                  codeAuth = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
          ),
        ),
        SizedBox(height: 24.0),
        FadeTransition(
          opacity: _animation!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  localizations.t('verify.haventCode'),
                  // " ",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _resendCode(localizations);
                  },
                  child: Text(
                    localizations.t('verify.buttomResend'),
                    // 'Resend',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0),
        FadeTransition(
          opacity: _animation!,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                signIn(localizations);
                setState(() => _loading = true);
              } else {
                _showSnackBar("");
              }
            },
            child: Padding(
              padding:
                  _loading == true ? EdgeInsets.all(2.0) : EdgeInsets.all(8.0),
              child:
                  _loading == false
                      ? Text(
                        localizations.t('verify.verifyButtom'),
                        // 'VERIFY',
                        style: TextStyle(color: Colors.white),
                      )
                      : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
            ),
          ),
        ),
      ],
    ),
  );

  _showSnackBar(String text) {
    // final snackBar = SnackBar(
    //   content: Text(text, style: TextStyle(color: Colors.white)),
    //   duration: Duration(seconds: 4),
    // );
    //    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    // scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  signIn(localizations) async {
    if (codeAuth!.length != 6) {
      _showSnackBar(localizations.t('verify.snackBarText1'));
    }
    // Provider.of<PhoneAuthDataProvider>(context, listen: false).typeAuth = "phone";
    // Provider.of<PhoneAuthDataProvider>(
    //   context,
    //   listen: false,
    // ).verifyOTPAndLogin(smsCode: codeAuth!, context: context);
  }

  _resendCode(localizations) async {
    // final phoneAuthDataProvider = Provider.of<PhoneAuthDataProvider>(
    //   context,
    //   listen: false,
    // );
    // phoneAuthDataProvider.loading = true;
    // var countryProvider = Provider.of<CountryProvider>(context, listen: false);
    // bool validPhone = await phoneAuthDataProvider.instantiate(
    //   dialCode: '+57',
    //   onCodeSent: () {},
    //   onFailed: () {
    //     _showSnackBar(phoneAuthDataProvider.message);
    //   },
    //   onError: () {
    //     _showSnackBar(phoneAuthDataProvider.message);
    //   },
    // );
    // if (!validPhone) {
    //   phoneAuthDataProvider.loading = false;
    //   _showSnackBar(
    //     '',
    //     // localizations.t('verify.snackBarText2'),
    //     // "
    //   );
      // return;
    // }
  }

  // This will return pin field - it accepts only single char
  Widget getPinField({String? key, FocusNode? focusNode}) => Container(
    // decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.all(Radius.circular(50.0))),
    height: 50.0,
    width: 50.0,
    // color: Colors.white,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50.0),
    ),
    child: TextField(
      maxLengthEnforcement: MaxLengthEnforcement.none,
      key: Key(key!),
      expands: false,
      autofocus: false,
      focusNode: focusNode,
      onChanged: (String value) {
        if (value.length == 1) {
          code += value;
          switch (code.length) {
            case 1:
              FocusScope.of(context).requestFocus(focusNode2);
              break;
            case 2:
              FocusScope.of(context).requestFocus(focusNode3);
              break;
            case 3:
              FocusScope.of(context).requestFocus(focusNode4);
              break;
            case 4:
              FocusScope.of(context).requestFocus(focusNode5);
              break;
            case 5:
              FocusScope.of(context).requestFocus(focusNode6);
              break;
            default:
              FocusScope.of(context).requestFocus(FocusNode());
              break;
          }
        }
      },
      textAlign: TextAlign.center,
      cursorColor: Colors.white,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.white,
      ),
    ),
  );
  onStarted() {
    // AppLocalizations? localizations = Localizations.of<AppLocalizations>(
    //   context,
    //   AppLocalizations,
    // );
    // _showSnackBar(
    //   "",
    //   // localizations.t('verifyCode.phoneAuthStarted')
    // );
  }

  onCodeSent() {
    // final phoneNumber =
    //     Provider.of<PhoneAuthDataProvider>(context, listen: false).phone;
    // AppLocalizations? localizations = Localizations.of<AppLocalizations>(
    //   context,
    //   AppLocalizations,
    // );

    // _showSnackBar(
    //   "",
    //   // localizations.t('verifyCode.textVerification') + " " + "$phoneNumber "
    // );
  }

  onCodeResent() {
    // AppLocalizations? localizations = Localizations.of<AppLocalizations>(
    //   context,
    //   AppLocalizations,
    // );
    // final phoneNumber =
    //     Provider.of<PhoneAuthDataProvider>(context, listen: false).phone;
    // _showSnackBar(
    //   localizations?.t('verifyCode.resentCode') + " " + " $phoneNumber ",
    // );
  }

  onVerified() async {
    // await Future.delayed(Duration(seconds: 1));
    // setState(() {});
    // _showSnackBar(
    //   "${Provider.of<PhoneAuthDataProvider>(context, listen: false).message}",
    // );
  }

  onFailed() {
    _showSnackBar("PhoneAuth failed");
  }

  onError() {
    // _showSnackBar(
    //   "PhoneAuth error ${Provider.of<PhoneAuthDataProvider>(context, listen: false).message}",
    // );
  }

  onAutoRetrievalTimeOut() {
    _showSnackBar('');
  }
}
