import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/partners/domain/usecases/remove_partner_usecase.dart';
import 'package:partners_app/features/partners/presentation/providers/partners_providers.dart';
import 'package:partners_app/features/partners/presentation/widgets/partner_tile.dart';

/// Relocated from lib/partners/partner_accept_list.dart's `PartnersAccepted`.
class PartnersAcceptedPage extends ConsumerWidget {
  const PartnersAcceptedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(context, localizations),
        backgroundColor: const Color(0xff282828),
        body: AsyncValueView(
          value: ref.watch(acceptedPartnersProvider(uid)),
          data: (partners) {
            if (partners.isEmpty) {
              return Center(
                child: Text(
                  localizations?.t('partnersAccepted.messageEmptyList') ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'SansLightItalic'),
                ),
              );
            }
            return ListView.builder(
              itemCount: partners.length,
              itemBuilder: (_, index) => PartnerTile(
                user: uid,
                partnerUid: partners[index].partnerUid,
                localizations: localizations,
                onDelete: (user, partnerUid, localizations) => _confirmDelete(context, ref, user, partnerUid, localizations),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () => Navigator.pushNamed(context, AppRoutes.addPartners),
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context, AppLocalizations? localizations) {
    return AppBar(
      title: Text(localizations?.t('partnersAccepted.title') ?? ''),
      backgroundColor: AppColors.primary,
      actions: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.userGroup),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.partnersRequest),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String user,
    String partnerUid,
    AppLocalizations? localizations,
  ) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(localizations?.t('partnersAccepted.textDelete') ?? '', style: const TextStyle(color: Colors.white)),
          content: Text(localizations?.t('partnersAccepted.textDelete2') ?? '', style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations?.t('home_page.option') ?? 'Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await ref.read(removePartnerUseCaseProvider).call(
                  RemovePartnerParams(uid: user, partnerUid: partnerUid),
                );
                if (context.mounted) Navigator.of(context).pop();
              },
              child: Text(
                localizations?.t('partnersAccepted.continueButtom') ?? 'Continue',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
