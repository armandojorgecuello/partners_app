import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/design_system/molecules/nav_list_tile.dart';
import 'package:partners_app/features/auth/presentation/providers/auth_providers.dart';

/// Relocated from lib/src/pages/others/settings_app.dart. Navigation to
/// sibling features goes through named routes (AppRoutes) instead of
/// importing their page widgets directly, keeping this feature decoupled
/// from partners/images/notifications/support/legal.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations?.t('setting.settings') ?? ''),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: AppColors.pageDark,
        body: ListView(
          children: <Widget>[
            _section(localizations?.t('setting.myAccount') ?? '', [
              NavListTile(
                icon: Icons.person,
                title: localizations?.t('setting.myProfile') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
              ),
              NavListTile(
                icon: Icons.people,
                title: localizations?.t('setting.myPartner') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.partnersAccepted),
              ),
              NavListTile(
                icon: Icons.photo_library,
                title: localizations?.t('setting.myImages') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.myImages),
              ),
              NavListTile(
                icon: Icons.notifications,
                title: localizations?.t('setting.notifications') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationSettings),
              ),
              NavListTile(
                icon: Icons.support_agent,
                title: localizations?.t('setting.support') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.supportTickets),
              ),
              NavListTile(
                icon: Icons.phone,
                title: localizations?.t('setting.changePhone') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.changeNumber),
              ),
            ]),
            const SizedBox(height: 40.0),
            _section(localizations?.t('setting.more') ?? '', [
              NavListTile(
                icon: Icons.privacy_tip,
                title: localizations?.t('setting.privPolicy') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.privacyPolicy),
              ),
              NavListTile(
                icon: Icons.description,
                title: localizations?.t('setting.termsServ') ?? '',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.termsOfService),
              ),
            ]),
            const SizedBox(height: 40.0),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 10.0),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
              title: const Text('Sign Out', style: TextStyle(fontSize: 16.0, color: Colors.red)),
              onTap: () => _signOut(context, ref),
            ),
            const Divider(color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> tiles) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 10.0),
          title: Text(title, style: const TextStyle(fontSize: 20.0, color: Colors.white)),
        ),
        const Divider(color: Colors.white),
        ...tiles,
      ],
    );
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    await ref.read(signOutUseCaseProvider).call(const NoParams());
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.root, (route) => false);
  }
}
