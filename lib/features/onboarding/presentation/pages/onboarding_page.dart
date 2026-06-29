import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';

/// Relocated from lib/src/onboarding/onboarding.dart. Presentation-only
/// walkthrough carousel — no Firebase calls, no domain/data layers needed.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  String? _selectedQuery;
  final PageController _pageController = PageController(initialPage: 0);
  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _onboardingBase(localizations),
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              _page1(localizations),
              _page2(localizations),
              _page3(localizations),
              _page4(localizations),
              _page5(localizations),
            ],
          ),
        ],
      ),
    );
  }

  Widget _onboardingBase(AppLocalizations? localizations) {
    return Scaffold(
      backgroundColor: const Color(0xff282828),
      appBar: _appbar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _dropMenu(localizations),
            _taskPreviewCard(localizations),
            Expanded(child: Container()),
            Padding(padding: const EdgeInsets.all(8.0), child: _backgroundIcons()),
          ],
        ),
      ),
    );
  }

  Widget _taskPreviewCard(AppLocalizations? localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10.0,
          color: const Color(0xff393939),
          child: Stack(
            children: <Widget>[
              const Positioned(left: 5.0, top: 25.0, child: CircleAvatar(backgroundColor: Colors.grey, radius: 25.0)),
              const Positioned(left: 43.0, top: 25.0, child: CircleAvatar(backgroundColor: Colors.grey, radius: 25.0)),
              Positioned(
                left: 100.0,
                top: 15.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      localizations?.t('onboarding.titleTask') ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'SansSemiBold'),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Text(
                          '${localizations?.t('onboarding.reward') ?? ''} : ',
                          style: const TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                        Text(
                          localizations?.t('onboarding.rewardDesExample') ?? '',
                          style: const TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      localizations?.t('onboarding.status') ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 12.0),
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
                    localizations?.t('onboarding.taskButtom') ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _page1(AppLocalizations? localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              localizations?.t('onboarding.titleExp') ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 24.3, fontFamily: 'SansSemiBold'),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.68,
              child: const Text(
                'Velit veniam ut occaecat cupidatat ipsum culpa proident nulla ut exercitation nostrud excepteur duis.',
                style: TextStyle(fontSize: 14.0, fontFamily: 'SansSemiBold', color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _previousNextButton(const Icon(Icons.arrow_forward_ios), () {
          _pageController.nextPage(duration: _duration, curve: _curve);
        }),
      ],
    );
  }

  Widget _page2(AppLocalizations? localizations) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.465,
              child: SizedBox(width: MediaQuery.of(context).size.width, child: _prevNextRow()),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  localizations?.t('onboarding.addTask') ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'SansSemiBold', fontSize: 24.3),
                ),
                const SizedBox(height: 10.0),
                Text(
                  localizations?.t('onboarding.addTaskText') ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'SansSemiBold'),
                ),
                _coinBadge(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _page3(AppLocalizations? localizations) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.465,
              child: SizedBox(width: MediaQuery.of(context).size.width, child: _prevNextRow()),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  localizations?.t('onboarding.credits') ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'SansSemiBold', fontSize: 24.3),
                ),
                const SizedBox(height: 10.0),
                Text(
                  localizations?.t('onboarding.creditsDescriptions') ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'SansSemiBold'),
                ),
                _coinBadge(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _page4(AppLocalizations? localizations) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.465,
            child: SizedBox(width: MediaQuery.of(context).size.width, child: _prevNextRow()),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Text(
                  localizations?.t('onboarding.negociate') ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'SansSemiBold', fontSize: 24.3),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    localizations?.t('onboarding.negociateDescriptions') ?? '',
                    style: const TextStyle(fontFamily: 'SansSemiBold', color: Colors.white, fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width,
                    child: _taskPreviewCard(localizations),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _page5(AppLocalizations? localizations) {
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
                  _previousNextButton(const Icon(Icons.arrow_back_ios), () {
                    _pageController.previousPage(duration: _duration, curve: _curve);
                  }),
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
                const SizedBox(height: 40.0),
                Text(
                  localizations?.t('onboarding.finishOnboarding') ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'SansSemiBold', fontSize: 24.3),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    'Fugiat aliqua est ipsum exercitation laborum excepteur proident magna dolore anim. Laboris cillum ipsum mollit sint ipsum.',
                    style: TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'SansSemiBold'),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false),
                  child: Text(
                    localizations?.t('onboarding.buttomStarted') ?? '',
                    style: const TextStyle(color: Colors.white, fontFamily: 'SansRegular'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _prevNextRow() {
    return Row(
      children: [
        _previousNextButton(const Icon(Icons.arrow_back_ios), () {
          _pageController.previousPage(duration: _duration, curve: _curve);
        }),
        Expanded(child: Container()),
        _previousNextButton(const Icon(Icons.arrow_forward_ios), () {
          _pageController.nextPage(duration: _duration, curve: _curve);
        }),
      ],
    );
  }

  Widget _coinBadge() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: const Color(0xff0F9D75), borderRadius: BorderRadius.circular(60.0)),
            height: 80.0,
            width: 80.0,
            child: const Icon(FontAwesomeIcons.plus, color: Colors.white, size: 40.0),
          ),
        ],
      ),
    );
  }

  Widget _backgroundIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60.0)),
          height: 80.0,
          width: 120.0,
          child: Row(
            children: <Widget>[
              Image(image: const AssetImage('assets/image/Credits_Icon1.png'), width: 80.0, height: 80.0, fit: BoxFit.cover),
              const SizedBox(width: 5.0),
              const Text('X 0', style: TextStyle(color: Color(0xffFFFFFF), fontFamily: 'SansRegular', fontSize: 19.91)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: const Color(0xff0F9D75), borderRadius: BorderRadius.circular(60.0)),
          height: 80.0,
          width: 80.0,
          child: const Icon(FontAwesomeIcons.plus, color: Colors.white, size: 40.0),
        ),
      ],
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: const Text('Partners', style: TextStyle(fontFamily: 'SansSemiBold', fontSize: 22.0)),
      centerTitle: true,
      leading: const CircleAvatar(backgroundColor: Colors.grey),
      backgroundColor: const Color(0xff0f9d75),
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
                  onTap: () {},
                  child: const Image(image: AssetImage('assets/image/reward.png'), width: 24.0, height: 24.0),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Image(image: AssetImage('assets/image/notification.png'), width: 24.0, height: 24.0),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Image(image: AssetImage('assets/image/setting.png'), width: 24.0, height: 24.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropMenu(AppLocalizations? localizations) {
    const textStyleDrop = TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 14.0);
    const textStyle = TextStyle(color: Colors.black, fontFamily: 'Sans', fontSize: 14.0);
    return Container(
      color: const Color.fromRGBO(58, 58, 58, 0.98),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(_selectedQuery ?? localizations?.t('home_page.allTask') ?? '', style: textStyleDrop),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: localizations?.t('home_page.openNegociation') ?? '',
                textStyle: textStyleDrop,
                child: Text(localizations?.t('home_page.openNegociation') ?? '', style: textStyle),
              ),
            ],
            initialValue: localizations?.t('home_page.allTask') ?? '',
            onSelected: (value) => setState(() => _selectedQuery = value),
          ),
        ],
      ),
    );
  }

  Widget _previousNextButton(Icon icon, VoidCallback onPressed) {
    return IconButton(icon: icon, color: Colors.white, onPressed: onPressed, iconSize: 45.0);
  }
}
