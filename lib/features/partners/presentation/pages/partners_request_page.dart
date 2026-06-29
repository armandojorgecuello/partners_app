import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/design_system/organisms/custom_app_bar.dart';
import 'package:partners_app/features/partners/domain/usecases/accept_partner_request_usecase.dart';
import 'package:partners_app/features/partners/presentation/providers/partners_providers.dart';
import 'package:partners_app/features/partners/presentation/widgets/partner_request_tile.dart';

/// Relocated from lib/partners/partners_requests_list.dart's `PartnersRequest`.
class PartnersRequestPage extends ConsumerWidget {
  const PartnersRequestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: localizations?.t('partnersRequest.title') ?? '',
          backLabel: localizations?.t('partnersRequest.back') ?? '',
        ),
        backgroundColor: const Color(0xff282828),
        body: AsyncValueView(
          value: ref.watch(incomingPartnerRequestsProvider(uid)),
          data: (requests) {
            if (requests.isEmpty) {
              return Center(
                child: Text(
                  localizations?.t('partnersRequest.messageEmptyList') ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'SansLightItalic'),
                ),
              );
            }
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (_, index) => PartnerRequestTile(
                user: uid,
                senderUid: requests[index].senderUid,
                localizations: localizations,
                onAccept: (user, senderUid, name, localizations) => _accept(context, ref, user, senderUid, name, localizations),
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

  Future<void> _accept(
    BuildContext context,
    WidgetRef ref,
    String user,
    String senderUid,
    String? name,
    AppLocalizations? localizations,
  ) async {
    await ref.read(acceptPartnerRequestUseCaseProvider).call(
      AcceptPartnerRequestParams(receiverUid: user, senderUid: senderUid),
    );
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff282828),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations?.t('partnersRequest.messageDialogAccept') ?? '',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '$name ${localizations?.t('partnersRequest.messageDialogAccept2') ?? ''}',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}
