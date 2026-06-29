import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';

/// Relocated from lib/partners/partner_accept_list.dart's `_PartnerTile`.
class PartnerTile extends ConsumerWidget {
  final String user;
  final String partnerUid;
  final AppLocalizations? localizations;
  final Future<void> Function(String user, String partnerUid, AppLocalizations? localizations) onDelete;

  const PartnerTile({
    super.key,
    required this.user,
    required this.partnerUid,
    required this.localizations,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueView(
      value: ref.watch(userProfileProvider(partnerUid)),
      loading: SizedBox(height: MediaQuery.of(context).size.height * 0.1, child: const Center(child: CircularProgressIndicator())),
      data: (profile) => Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: localizations?.t('partnersAccepted.deleteButtom') ?? 'Delete',
              onPressed: (_) => onDelete(user, partnerUid, localizations),
            ),
          ],
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: AppColors.pageDark,
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: ListTile(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.newTask, arguments: partnerUid),
            leading: AppAvatar(radius: 25.0, imageUrl: profile.photoUrl),
            title: Text(
              profile.name ?? '',
              style: const TextStyle(color: Colors.white, fontFamily: 'SansSemiBold', fontSize: 12.0),
            ),
            subtitle: Text(
              (profile.preferences?.isNotEmpty ?? false)
                  ? profile.preferences!
                  : localizations?.t('partnersAccepted.textEmptyPreferences') ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 10.0),
            ),
          ),
        ),
      ),
    );
  }
}
