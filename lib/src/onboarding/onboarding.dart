// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honey_iou_updated/utils/locale_app.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _OnboardingState createState() => _OnboardingState();
}

String? _selectedQuery;

class _OnboardingState extends State<Onboarding> {
  // static final pref = UserPreferences();
  // String user = pref.uid;
  // String initialval = pref.initialValueTask;

  @override
  void initState() {
    super.initState();
    // _selectedQuery = initialval;
    setState(() {});
  }

  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          onboardingBase(localizations),
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          PageView(
            physics: ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              page1(localizations),
              page2(localizations),
              page3(localizations),
              page4(localizations),
              page5(localizations),
            ],
          ),
        ],
      ),
    );
  }

  Widget onboardingBase(localizations) {
    return Scaffold(
      backgroundColor: Color(0xff282828),
      appBar: _appbar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _crearDropMenu(localizations),
            card(localizations),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: backgroundicon(localizations),
            ),
          ],
        ),
      ),
    );
  }

  Widget card(localizations) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10.0,
          color: Color(0xff393939),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 5.0,
                top: 25.0,
                child: CircleAvatar(backgroundColor: Colors.grey, radius: 25.0),
              ),
              Positioned(
                left: 43.0,
                top: 25.0,
                child: CircleAvatar(backgroundColor: Colors.grey, radius: 25.0),
              ),
              Positioned(
                left: 100.0,
                top: 15.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      localizations.t('onboarding.titleTask'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontFamily: 'SansSemiBold',
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Text(
                          localizations.t('onboarding.reward') + " : ",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                        Container(
                          child: Text(
                            localizations.t('onboarding.rewardDesExample'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      localizations.t('onboarding.status'),
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 5.0,
                child: ElevatedButton(
                  
                  onPressed: () {},
                  child: Text(
                    localizations.t('onboarding.taskButtom'),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget page1(localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                localizations.t('onboarding.titleExp'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.3,
                  fontFamily: "Quick",
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.68,
              child: Text(
                'Velit veniam ut occaecat cupidatat ipsum culpa proident nulla ut exercitation nostrud excepteur duis.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'SansSemiBold',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        previusNextButton(Icon(Icons.arrow_forward_ios), () {
          _pageController.nextPage(duration: _duration, curve: _curve);
        }),
      ],
    );
  }

  Widget page2(localizations) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.465,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    previusNextButton(Icon(Icons.arrow_back_ios), () {
                      _pageController.previousPage(
                        duration: _duration,
                        curve: _curve,
                      );
                    }),
                    Expanded(child: Container()),
                    previusNextButton(Icon(Icons.arrow_forward_ios), () {
                      _pageController.nextPage(
                        duration: _duration,
                        curve: _curve,
                      );
                    }),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Text(
                    localizations.t('onboarding.addTask'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Quick',
                      fontSize: 24.3,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: Text(
                    localizations.t('onboarding.addTaskText'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'SansSemiBold',
                    ),
                  ),
                ),
                //Colocar Imagen de Credito
                addTask(localizations),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget page3(localizations) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.465,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    previusNextButton(Icon(Icons.arrow_back_ios), () {
                      _pageController.previousPage(
                        duration: _duration,
                        curve: _curve,
                      );
                    }),
                    Expanded(child: Container()),
                    previusNextButton(Icon(Icons.arrow_forward_ios), () {
                      _pageController.nextPage(
                        duration: _duration,
                        curve: _curve,
                      );
                    }),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Text(
                    localizations.t('onboarding.credits'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Quick',
                      fontSize: 24.3,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: Text(
                    localizations.t('onboarding.creditsDescriptions'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'SansSemiBold',
                    ),
                  ),
                ),
                //Colocar Imagen de Credito
                creditsIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget page4(localizations) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.465,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  previusNextButton(Icon(Icons.arrow_back_ios), () {
                    _pageController.previousPage(
                      duration: _duration,
                      curve: _curve,
                    );
                  }),
                  Expanded(child: Container()),
                  previusNextButton(Icon(Icons.arrow_forward_ios), () {
                    _pageController.nextPage(
                      duration: _duration,
                      curve: _curve,
                    );
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Container(
                  child: Text(
                    localizations.t('onboarding.negociate'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Quick',
                      fontSize: 24.3,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    localizations.t('onboarding.negociateDescriptions'),
                    style: TextStyle(
                      fontFamily: 'SansSemiBold',
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Crear Aqui una tarjeta de una tarea Falsa
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 10.0,
                      color: Color(0xff393939),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 5.0,
                            top: 25.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 25.0,
                            ),
                          ),
                          Positioned(
                            left: 43.0,
                            top: 25.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 25.0,
                            ),
                          ),
                          Positioned(
                            left: 100.0,
                            top: 15.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  localizations.t('onboarding.titleTask'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontFamily: 'Sans',
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      localizations.t('onboarding.reward') +
                                          " : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontFamily: 'SansLightItalic',
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        localizations.t(
                                          'onboarding.rewardDesExample',
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontFamily: 'Sans',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  localizations.t('onboarding.status'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontFamily: 'SansLightItalic',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10.0,
                            bottom: 5.0,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                localizations.t('onboarding.taskButtom'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SansRegular',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget page5(localizations) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.465,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  previusNextButton(Icon(Icons.arrow_back_ios), () {
                    _pageController.previousPage(
                      duration: _duration,
                      curve: _curve,
                    );
                  }),
                  // ,
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40.0),
                Container(
                  child: Text(
                    localizations.t('onboarding.finishOnboarding'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Quick',
                      fontSize: 24.3,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Fugiat aliqua est ipsum exercitation laborum excepteur proident magna dolore anim. Laboris cillum ipsum mollit sint ipsum.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'SansSemiBold',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  
                  onPressed: () {
                    // final pref = UserPreferences();
                    String user = 'pref.uid';
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      'home_page',
                      (Route<dynamic> route) => false,
                    );
                    // FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(user)
                    //     .collection(user)
                    //     .doc(user)
                    //     .update({'first_launch': false});
                  },
                  child: Text(
                    localizations.t('onboarding.buttomStarted'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SansRegular',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget creditsIcon() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
            ),
            height: 80.0,
            width: 120.0,
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/image/Credits_Icon1.png'),
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 5.0),
                Text(
                  'X 0',
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontFamily: 'SansRegular',
                    fontSize: 19.91,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addTask(localizations) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xffBF2328),
              borderRadius: BorderRadius.circular(60.0),
            ),
            height: 80.0,
            width: 80.0,
            child: Icon(FontAwesomeIcons.plus, color: Colors.white, size: 40.0),
          ),
        ],
      ),
    );
  }

  Widget backgroundicon(localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                height: 80.0,
                width: 120.0,
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/image/Credits_Icon1.png'),
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'X 0',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontFamily: 'SansRegular',
                        fontSize: 19.91,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xffBF2328),
            borderRadius: BorderRadius.circular(60.0),
          ),
          height: 80.0,
          width: 80.0,
          child: Icon(FontAwesomeIcons.plus, color: Colors.white, size: 40.0),
        ),
      ],
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text(
        "Honey IOU",
        style: TextStyle(fontFamily: "Quick", fontSize: 22.0),
      ),
      centerTitle: true,
      leading: CircleAvatar(backgroundColor: Colors.grey),
      backgroundColor: const Color(0xff7a1418),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: SizedBox(
            width: 94.0,
            height: 24.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  child: Image(
                    image: AssetImage('assets/image/reward.png'),
                    width: 24.0,
                    height: 24.0,
                  ),
                  onTap: () {},
                ),
                GestureDetector(
                  child: Image(
                    image: AssetImage('assets/image/notification.png'),
                    width: 24.0,
                    height: 24.0,
                  ),
                  onTap: () {},
                ),
                GestureDetector(
                  child: Image(
                    image: AssetImage('assets/image/setting.png'),
                    width: 24.0,
                    height: 24.0,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearDropMenu(localizations) {
    var textStyleDrop = TextStyle(
      color: Colors.white,
      fontFamily: 'Sans',
      fontSize: 14.0,
    );
    var textStyle = TextStyle(
      color: Colors.black,
      fontFamily: 'Sans',
      fontSize: 14.0,
    );
    return Container(
      color: Color.fromRGBO(58, 58, 58, 0.98),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                _selectedQuery ?? localizations.t('home_page.allTask'),
                style: textStyleDrop,
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: localizations.t('home_page.openNegociation'),
                    textStyle: textStyleDrop,
                    child: Text(
                      localizations.t('home_page.openNegociation'),
                      style: textStyle,
                    ),
                  ),
                ],
            initialValue: localizations.t('home_page.allTask'),
            onSelected: (value) {
              setState(() {
                _selectedQuery = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget previusNextButton(Icon icon, Function onPressed) {
    return IconButton(
      icon: icon,
      color: Colors.white,
      onPressed: () {
        onPressed();
      },
      iconSize: 45.0,
    );
  }
}
