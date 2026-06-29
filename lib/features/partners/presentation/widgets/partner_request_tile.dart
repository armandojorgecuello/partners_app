import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';

/// Relocated from lib/partners/partners_requests_list.dart's `_PartnerRequestTile`.
class PartnerRequestTile extends ConsumerWidget {
  final String user;
  final String senderUid;
  final AppLocalizations? localizations;
  final Future<void> Function(String user, String senderUid, String? name, AppLocalizations? localizations) onAccept;

  const PartnerRequestTile({
    super.key,
    required this.user,
    required this.senderUid,
    required this.localizations,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueView(
      value: ref.watch(userProfileProvider(senderUid)),
      loading: const SizedBox(height: 90.0, child: Center(child: CircularProgressIndicator())),
      data: (profile) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children: [
            AppAvatar(imageUrl: profile.photoUrl, radius: 30.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${localizations?.t('partnersRequest.preferences') ?? ''}: ${profile.preferences ?? 'N/A'}',
                    style: const TextStyle(color: Colors.white70, fontSize: 13.0),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () => onAccept(user, senderUid, profile.name, localizations),
              child: Text(localizations?.t('partnersRequest.buttomAccept') ?? '', style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
