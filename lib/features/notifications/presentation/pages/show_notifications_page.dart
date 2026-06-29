import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:partners_app/features/notifications/presentation/widgets/notification_tile.dart';

/// Relocated from lib/src/pages/more/show_notifi.dart's `ShowNotifications`.
class ShowNotificationsPage extends ConsumerWidget {
  const ShowNotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(localizations?.t('notification.title') ?? ''),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: const Color(0xff282828),
        body: AsyncValueView(
          value: ref.watch(notificationsProvider(uid)),
          data: (notifications) {
            if (notifications.isEmpty) {
              return Center(
                child: Text(
                  localizations?.t('notification.textEmpty') ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'SansLightItalic', fontSize: 12.0),
                ),
              );
            }
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (_, index) =>
                  NotificationTile(uid: uid, notification: notifications[index], localizations: localizations),
            );
          },
        ),
      ),
    );
  }
}
