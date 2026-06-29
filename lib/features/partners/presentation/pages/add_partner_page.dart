import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/molecules/confirm_dialog.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/partners/domain/usecases/send_partner_request_usecase.dart';
import 'package:partners_app/features/partners/presentation/providers/partners_providers.dart';

/// Relocated from lib/partners/add_partner.dart.
class AddPartnerPage extends ConsumerStatefulWidget {
  const AddPartnerPage({super.key});

  @override
  ConsumerState<AddPartnerPage> createState() => _AddPartnerPageState();
}

class _AddPartnerPageState extends ConsumerState<AddPartnerPage> {
  final TextEditingController _codeController = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff282828),
        appBar: _appBar(localizations),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Text(
                localizations?.t('addPartners.userCodeDesc0') ?? '',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              AsyncValueView(
                value: ref.watch(userProfileProvider(uid)),
                data: (profile) {
                  final code = profile.usercode;
                  if (code == null) return const CircularProgressIndicator();
                  return InkWell(
                    onTap: () => FlutterClipboard.copy(code).then((_) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(localizations?.t('addPartners.snackbarCopyCode') ?? '')),
                      );
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0), color: Colors.grey[200]),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 8.0),
                          Text(code, style: const TextStyle(fontSize: 18.0, letterSpacing: 2.0)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30.0),
              const Divider(color: Colors.white),
              const SizedBox(height: 20.0),
              Text(
                localizations?.t('addPartners.addPopupTextI') ?? '',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _codeController,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(color: Colors.white, fontSize: 18.0, letterSpacing: 2.0),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20.0),
              _sending
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => _submitCode(uid, localizations),
                      child: Text(localizations?.t('addPartners.buttomII') ?? 'Enter code'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitCode(String uid, AppLocalizations? localizations) async {
    final code = _codeController.text.trim().toUpperCase();
    if (code.isEmpty) return;
    setState(() => _sending = true);

    final lookup = await ref.read(findPartnerByCodeUseCaseProvider).call(code);
    if (!mounted) return;

    final partnerUid = lookup.fold((uid) => uid, (_) => null);
    if (partnerUid == null || partnerUid == uid) {
      setState(() => _sending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations?.t('addPartners.errortext') ?? '')),
      );
      return;
    }

    final result = await ref.read(sendPartnerRequestUseCaseProvider).call(
      SendPartnerRequestParams(senderUid: uid, receiverUid: partnerUid),
    );
    if (!mounted) return;
    setState(() => _sending = false);

    result.fold(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations?.t('addPartners.messageSnackbar') ?? '')),
        );
        _codeController.clear();
      },
      (failure) => _showValidationDialog(failure, localizations),
    );
  }

  void _showValidationDialog(Failure failure, AppLocalizations? localizations) {
    final isRequestExists = failure is ValidationFailure && failure.message == 'request_exists';
    showInfoDialog(
      context,
      title: isRequestExists
          ? localizations?.t('addPartners.popUpPartnerRequesExistsTitle') ?? ''
          : localizations?.t('addPartners.popUpPartnerAccepExistsTitle') ?? '',
      message: isRequestExists
          ? localizations?.t('addPartners.popUpPartnerRequesExistsDesc') ?? ''
          : localizations?.t('addPartners.popUpPartnerAccepExistsDesc') ?? '',
    );
  }

  PreferredSizeWidget _appBar(AppLocalizations? localizations) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(localizations?.t('addPartners.title') ?? ''),
      actions: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.userGroup),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.partnersRequest),
        ),
      ],
    );
  }
}
