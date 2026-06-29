import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/core/utils/validators.dart';
import 'package:partners_app/design_system/atoms/app_button.dart';
import 'package:partners_app/design_system/molecules/labeled_text_field.dart';
import 'package:partners_app/features/auth/domain/usecases/sign_up_with_email_usecase.dart';
import 'package:partners_app/features/auth/presentation/providers/auth_providers.dart';

/// Pushed on top of [LoginPage]. On success it clears back to [AppRoutes.root]
/// so `AuthGatePage` can reactively swap in home/complete-profile — mirroring
/// how the rest of the auth flow hands routing decisions to AuthGatePage.
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      body: SafeArea(
        child: Stack(
          children: [
            _background(),
            SingleChildScrollView(child: _form(localizations)),
            Positioned(
              left: 10.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: _loading ? null : () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _background() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
    );
  }

  Widget _form(AppLocalizations? localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Text(
              localizations?.t('signUpPage.title') ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'SansSemiBold', fontSize: 28.0, color: Colors.white),
            ),
            const SizedBox(height: 32.0),
            LabeledTextField(
              label: localizations?.t('signUpPage.emailLabel') ?? '',
              hintText: localizations?.t('signUpPage.emailHint') ?? '',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => Validators.required(v) ?? Validators.email(v),
            ),
            const SizedBox(height: 16.0),
            LabeledTextField(
              label: localizations?.t('signUpPage.passwordLabel') ?? '',
              hintText: localizations?.t('signUpPage.passwordHint') ?? '',
              controller: _passwordController,
              obscureText: true,
              validator: (v) => Validators.required(v) ?? Validators.password(v),
            ),
            const SizedBox(height: 16.0),
            LabeledTextField(
              label: localizations?.t('signUpPage.confirmPasswordLabel') ?? '',
              hintText: localizations?.t('signUpPage.confirmPasswordHint') ?? '',
              controller: _confirmPasswordController,
              obscureText: true,
              validator: (v) {
                final required = Validators.required(v);
                if (required != null) return required;
                if (v != _passwordController.text) {
                  return localizations?.t('signUpPage.passwordMismatch') ?? '';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              height: 57.0,
              child: AppButton(
                label: localizations?.t('signUpPage.buttomText') ?? '',
                loading: _loading,
                onPressed: () => _onSubmit(localizations),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: GestureDetector(
                onTap: _loading ? null : () => Navigator.of(context).pop(),
                child: Text.rich(
                  TextSpan(
                    text: '${localizations?.t('signUpPage.haveAccountText') ?? ''} ',
                    style: const TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: localizations?.t('signUpPage.loginLink') ?? '',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit(AppLocalizations? localizations) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    final result = await ref.read(signUpWithEmailUseCaseProvider).call(
      SignUpWithEmailParams(email: _emailController.text.trim(), password: _passwordController.text),
    );
    if (!mounted) return;
    result.fold(
      (_) => Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.root, (route) => false),
      (failure) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message)));
      },
    );
  }
}
