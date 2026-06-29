import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/design_system/organisms/custom_app_bar.dart';
import 'package:partners_app/features/profile/domain/usecases/update_profile_flags_usecase.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';

/// Relocated from lib/src/pages/more/notifications.dart. Toggles fields on
/// the user's own profile document, so it lives under features/profile
/// rather than features/notifications (which owns the notification feed).
class NotificationSettingsPage extends ConsumerWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: localizations?.t('notifications.title') ?? '',
          backLabel: localizations?.t('notifications.back') ?? '',
        ),
        backgroundColor: AppColors.pageDark,
        body: AsyncValueView(
          value: ref.watch(userProfileProvider(uid)),
          data: (profile) => ListView(
            children: <Widget>[
              const SizedBox(height: 10.0),
              SwitchListTile(
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.red,
                title: Text(
                  localizations?.t('notifications.pushNotifi') ?? '',
                  style: const TextStyle(color: Colors.grey, fontFamily: 'SansRegularlight', fontSize: 14),
                ),
                value: profile.allowPush,
                onChanged: (value) => ref.read(updateProfileFlagsUseCaseProvider).call(
                  UpdateProfileFlagsParams(uid: uid, allowPush: value),
                ),
              ),
              const Divider(color: Colors.grey),
              SwitchListTile(
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.red,
                title: Text(
                  localizations?.t('notifications.emailNotifi') ?? '',
                  style: const TextStyle(color: Colors.grey, fontFamily: 'SansRegularlight', fontSize: 14),
                ),
                value: profile.allowEmail,
                onChanged: (value) => ref.read(updateProfileFlagsUseCaseProvider).call(
                  UpdateProfileFlagsParams(uid: uid, allowEmail: value),
                ),
              ),
              const Divider(color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
