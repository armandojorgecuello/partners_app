import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/core/utils/validators.dart';
import 'package:partners_app/design_system/atoms/app_button.dart';
import 'package:partners_app/design_system/atoms/app_checkbox_tile.dart';
import 'package:partners_app/design_system/molecules/labeled_text_field.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/domain/entities/user_profile.dart';
import 'package:partners_app/features/profile/domain/usecases/update_profile_flags_usecase.dart';
import 'package:partners_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/profile/presentation/widgets/profile_picture_widget.dart';

/// Relocated from lib/phone_auth_temp/new_user.dart — the profile-completion
/// step shown by AuthGatePage in place of the home page while
/// `UserProfile.isComplete` is false. No explicit navigation happens on
/// submit: once the Firestore write resolves, the profile stream emits the
/// completed profile and AuthGatePage reactively swaps to the home page.
class NewUserPage extends ConsumerStatefulWidget {
  const NewUserPage({super.key});

  @override
  ConsumerState<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends ConsumerState<NewUserPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _preferences;
  String? _email;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pageDark,
        appBar: AppBar(
          title: Text(
            localizations?.t('profilePage.titleProfile') ?? '',
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
        ),
        body: AsyncValueView(
          value: ref.watch(userProfileProvider(uid)),
          data: (profile) => _form(profile, localizations),
        ),
      ),
    );
  }

  Widget _form(UserProfile profile, AppLocalizations? localizations) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20.0),
              Center(child: ProfilePictureWidget(profile: profile)),
              const SizedBox(height: 24.0),
              LabeledTextField(
                label: localizations?.t('profileInputs.name') ?? '',
                hintText: localizations?.t('profileInputs.nameLabel') ?? '',
                onChanged: (v) => _name = v,
                validator: (v) => Validators.required(v, message: 'Empty camp'),
              ),
              const SizedBox(height: 20.0),
              LabeledTextField(
                label: localizations?.t('profileInputs.preferences') ?? '',
                hintText: localizations?.t('profileInputs.preferencesText') ?? '',
                onChanged: (v) => _preferences = v,
                validator: (v) => Validators.required(v, message: 'Empty camp'),
              ),
              const SizedBox(height: 20.0),
              LabeledTextField(
                label: localizations?.t('profileInputs.email') ?? '',
                hintText: localizations?.t('profileInputs.emailLabel') ?? '',
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => _email = v,
                validator: (v) => Validators.email(v, message: 'Enter your e-mail'),
              ),
              const SizedBox(height: 32.0),
              AppCheckboxTile(
                label: localizations?.t('profileInputs.partnerCheck') ?? '',
                value: profile.partnerCheck,
                onChanged: (value) => ref.read(updateProfileFlagsUseCaseProvider).call(
                  UpdateProfileFlagsParams(uid: profile.uid, partnerCheck: value ?? true),
                ),
              ),
              AppCheckboxTile(
                label: localizations?.t('profileInputs.accepTerms') ?? '',
                value: profile.acceptTerms,
                onChanged: (value) => ref.read(updateProfileFlagsUseCaseProvider).call(
                  UpdateProfileFlagsParams(uid: profile.uid, acceptTerms: value ?? true),
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: AppButton(
                  label: localizations?.t('profileInputs.textButtomProfile') ?? '',
                  loading: _saving,
                  onPressed: () => _submit(profile),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(UserProfile profile) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    await ref.read(updateProfileUseCaseProvider).call(
      UpdateProfileParams(
        uid: profile.uid,
        name: _name ?? profile.name,
        email: _email ?? profile.email,
        preferences: _preferences ?? profile.preferences,
        celNumber: profile.celNumber,
      ),
    );
    if (!mounted) return;
    setState(() => _saving = false);
  }
}
