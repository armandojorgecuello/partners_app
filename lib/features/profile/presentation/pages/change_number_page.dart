import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/atoms/app_button.dart';
import 'package:partners_app/design_system/atoms/app_text_field.dart';
import 'package:partners_app/features/profile/domain/usecases/update_cel_number_usecase.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';

/// Relocated from lib/src/pages/others/validation_change_num.dart. The OTP
/// step still talks to FirebaseAuth directly (as the original code did,
/// bypassing the sign-in auth feature entirely) — only the final Firestore
/// write goes through the profile domain layer.
class ChangeNumberPage extends ConsumerStatefulWidget {
  const ChangeNumberPage({super.key});

  @override
  ConsumerState<ChangeNumberPage> createState() => _ChangeNumberPageState();
}

class _ChangeNumberPageState extends ConsumerState<ChangeNumberPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? _verificationId;
  bool _codeSent = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(localizations?.t('phoneNumber.title') ?? ''),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: AppColors.pageDark,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              if (!_codeSent) _phoneStep(localizations) else _codeStep(localizations),
              if (_error != null) ...[
                const SizedBox(height: 16.0),
                Text(_error!, style: const TextStyle(color: Colors.redAccent)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _phoneStep(AppLocalizations? localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          hintText: localizations?.t('phoneNumber.hint') ?? '',
        ),
        const SizedBox(height: 30.0),
        _loading
            ? const Center(child: CircularProgressIndicator())
            : AppButton(label: localizations?.t('phoneNumber.buttonText') ?? '', onPressed: _sendCode),
      ],
    );
  }

  Widget _codeStep(AppLocalizations? localizations) {
    return Column(
      children: [
        Text(localizations?.t('phoneNumber.codeSent') ?? '', style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 20.0),
        PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          validator: (v) => null,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.circle,
            activeColor: Colors.red,
            disabledColor: Colors.white,
            selectedFillColor: Colors.red,
            inactiveColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedColor: Colors.red,
            fieldHeight: 50,
            fieldWidth: 42,
            activeFillColor: Colors.white,
          ),
          cursorColor: Colors.black,
          textStyle: const TextStyle(fontSize: 18, color: Colors.white),
          onCompleted: _confirmCode,
          onChanged: (_) {},
        ),
        const SizedBox(height: 20.0),
        if (_loading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Future<void> _sendCode() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    await ref.read(firebaseAuthProvider).verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) => _applyCredential(credential, phone),
      verificationFailed: (e) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _error = e.message;
        });
      },
      codeSent: (verificationId, _) {
        if (!mounted) return;
        setState(() {
          _verificationId = verificationId;
          _codeSent = true;
          _loading = false;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> _confirmCode(String smsCode) async {
    if (_verificationId == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
    await _applyCredential(credential, _phoneController.text.trim());
  }

  Future<void> _applyCredential(PhoneAuthCredential credential, String phone) async {
    try {
      final uid = ref.read(firebaseAuthProvider).currentUser!.uid;
      await ref.read(firebaseAuthProvider).currentUser!.updatePhoneNumber(credential);
      await ref.read(updateCelNumberUseCaseProvider).call(
        UpdateCelNumberParams(uid: uid, celNumber: phone),
      );
      if (!mounted) return;
      final localizations = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations?.t('phoneNumber.success') ?? '')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }
}
