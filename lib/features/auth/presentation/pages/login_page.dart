import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/core/utils/validators.dart';
import 'package:partners_app/design_system/atoms/app_button.dart';
import 'package:partners_app/design_system/molecules/labeled_text_field.dart';
import 'package:partners_app/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:partners_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:partners_app/features/auth/presentation/providers/auth_providers.dart';

/// Relocated from lib/phone_auth_temp/firebase/auth/phone_auth/get_phone.dart.
/// Phone OTP was replaced with email + password (see SignUpPage for account
/// creation, which is a separate flow from sign-in).
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        body: Stack(
          children: [
            Opacity(
              opacity: 1,
              child: AbsorbPointer(absorbing: _loading, child: _body(localizations)),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: _loading ? 1.0 : 0,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(AppLocalizations? localizations) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Center(
                child: FadeTransition(
                  opacity: _animation,
                  child: Column(
                    children: <Widget>[
                      Text(
                        localizations?.t('loginPage.appName') ?? '',
                        style: const TextStyle(fontFamily: 'SansSemiBold', fontSize: 50.0, color: Colors.white),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                      Text(
                        localizations?.t('loginPage.text_1') ?? '',
                        style: const TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          localizations?.t('loginPage.text_2') ?? '',
                          style: const TextStyle(fontSize: 15.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: _emailForm(localizations),
                ),
              ),
              FadeTransition(
                opacity: _animation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: const Divider(color: Colors.white),
                      ),
                    ),
                    const Text('or', style: TextStyle(color: Colors.white)),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: const Divider(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Center(
                child: FadeTransition(
                  opacity: _animation,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 57.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _signInWithGoogle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.google, size: 24.0),
                          const SizedBox(width: 12.0),
                          Text(
                            localizations?.t('loginPage.googleButtomText') ?? 'Google',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emailForm(AppLocalizations? localizations) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledTextField(
            label: localizations?.t('loginPage.emailLabel') ?? '',
            hintText: localizations?.t('loginPage.emailHint') ?? '',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => Validators.required(v) ?? Validators.email(v),
          ),
          const SizedBox(height: 14.0),
          LabeledTextField(
            label: localizations?.t('loginPage.passwordLabel') ?? '',
            hintText: localizations?.t('loginPage.passwordHint') ?? '',
            controller: _passwordController,
            obscureText: true,
            validator: (v) => Validators.required(v),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _loading ? null : () => _onForgotPassword(localizations),
              child: Text(
                localizations?.t('loginPage.forgotPassword') ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            height: 57.0,
            child: AppButton(
              label: localizations?.t('loginPage.buttomText') ?? '',
              loading: _loading,
              onPressed: () => _onSignInPressed(localizations),
            ),
          ),
          const SizedBox(height: 14.0),
          Center(
            child: GestureDetector(
              onTap: _loading ? null : _onSignUpPressed,
              child: Text.rich(
                TextSpan(
                  text: '${localizations?.t('loginPage.noAccountText') ?? ''} ',
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: localizations?.t('loginPage.signUpLink') ?? '',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSignInPressed(AppLocalizations? localizations) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    final result = await ref.read(signInWithEmailUseCaseProvider).call(
      SignInWithEmailParams(email: _emailController.text.trim(), password: _passwordController.text),
    );
    if (!mounted) return;
    result.fold(
      (_) {},
      (failure) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message)));
      },
    );
  }

  Future<void> _onForgotPassword(AppLocalizations? localizations) async {
    final email = _emailController.text.trim();
    if (Validators.required(email) != null || Validators.email(email) != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations?.t('loginPage.invalidEmail') ?? '')),
      );
      return;
    }
    setState(() => _loading = true);
    final result = await ref.read(sendPasswordResetUseCaseProvider).call(email);
    if (!mounted) return;
    setState(() => _loading = false);
    result.fold(
      (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations?.t('loginPage.resetEmailSent') ?? '')),
      ),
      (failure) =>
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message))),
    );
  }

  void _onSignUpPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _loading = true);
    final result = await ref.read(signInWithGoogleUseCaseProvider).call(const NoParams());
    if (!mounted) return;
    result.fold(
      (_) {},
      (failure) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message)));
      },
    );
  }
}
