import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/notifications/domain/entities/app_notification.dart';
import 'package:partners_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/tasks/presentation/providers/tasks_providers.dart';

/// Relocated from lib/src/pages/more/show_notifi.dart's `_NotificationTile`.
class NotificationTile extends ConsumerWidget {
  final String uid;
  final AppNotification notification;
  final AppLocalizations? localizations;

  const NotificationTile({super.key, required this.uid, required this.notification, required this.localizations});

  String _messageKey() {
    switch (notification.type) {
      case 'partner_request':
        return 'notification.receivedRequest';
      case 'partner_accepted':
        return 'notification.autoAllow';
      case 'new_task':
        return 'notification.newTask';
      case 'chat_message':
        return 'notification.sendMessage';
      case 'task_status':
        switch (notification.status) {
          case 'open':
            return 'notification.openTask';
          case 'rejected':
            return 'notification.rejectedTask';
          case 'paid_upfront':
            return 'notification.paidUpFrontTask';
          default:
            return 'notification.updateTask';
        }
      default:
        return 'notification.updateTask';
    }
  }

  Future<void> _onTap(BuildContext context, WidgetRef ref) async {
    await ref.read(notificationRepositoryProvider).markAsRead(uid, notification.id);
    if (!context.mounted) return;
    final taskId = notification.taskId;
    if (taskId != null) {
      final task = await ref.read(taskRepositoryProvider).getTask(taskId);
      if (!context.mounted || task == null) return;
      Navigator.of(context).pushNamed(AppRoutes.viewTask, arguments: task);
    } else if (notification.type == 'partner_request') {
      Navigator.of(context).pushNamed(AppRoutes.partnersRequest);
    } else if (notification.type == 'partner_accepted') {
      Navigator.of(context).pushNamed(AppRoutes.partnersAccepted);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate = notification.dateTime != null ? DateFormat('HH:mm').format(notification.dateTime!) : '';
    return AsyncValueView(
      value: ref.watch(userProfileProvider(notification.actorUid)),
      data: (actor) => ListTile(
        leading: AppAvatar(radius: 22.0, imageUrl: actor.photoUrl),
        tileColor: notification.read ? null : const Color(0xff333333),
        title: Text(
          '${actor.name ?? ''} ${localizations?.t(_messageKey()) ?? ''}',
          style: const TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'SansSemiBold'),
        ),
        trailing: Text(formattedDate, style: const TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'SansSemiBold')),
        onTap: () => _onTap(context, ref),
      ),
    );
  }
}
