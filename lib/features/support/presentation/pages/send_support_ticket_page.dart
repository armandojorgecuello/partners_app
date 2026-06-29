import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/features/support/domain/usecases/create_support_ticket_usecase.dart';
import 'package:partners_app/features/support/presentation/providers/support_providers.dart';

/// Relocated from lib/src/pages/more/send_support.dart.
class SendSupportTicketPage extends ConsumerStatefulWidget {
  const SendSupportTicketPage({super.key});

  @override
  ConsumerState<SendSupportTicketPage> createState() => _SendSupportTicketPageState();
}

class _SendSupportTicketPageState extends ConsumerState<SendSupportTicketPage> {
  final _formKey = GlobalKey<FormState>();
  String _subject = '';
  String _description = '';
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(localizations?.t('messageSupport.title') ?? ''),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: AppColors.pageDark,
        body: _body(localizations),
      ),
    );
  }

  Widget _body(AppLocalizations? localizations) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10.0),
              child: Text(
                localizations?.t('messageSupport.message') ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'SansRegularlight'),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                localizations?.t('messageSupport.subject') ?? '',
                style: const TextStyle(fontFamily: 'Sans', color: Colors.white, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                validator: (value) => (value == null || value.isEmpty) ? 'Subject is empty' : null,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  hintText: localizations?.t('messageSupport.error') ?? '',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0, fontFamily: 'SansRegularlight'),
                ),
                onChanged: (value) => _subject = value,
                cursorColor: Colors.grey,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                localizations?.t('messageSupport.description') ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'Sans'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  hintText: localizations?.t('messageSupport.descriptionHint') ?? '',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0, fontFamily: 'SansRegularlight'),
                ),
                maxLines: 8,
                onChanged: (value) => _description = value,
                cursorColor: Colors.grey,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _sending
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70.0)),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        ),
                        onPressed: () => _submit(localizations),
                        child: Text(
                          localizations?.t('messageSupport.submit') ?? '',
                          style: const TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'SansRegularlight'),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(AppLocalizations? localizations) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    final uid = ref.read(currentUidProvider)!;
    final result = await ref.read(createSupportTicketUseCaseProvider).call(
      CreateSupportTicketParams(uid: uid, subject: _subject, description: _description),
    );
    if (!mounted) return;
    setState(() => _sending = false);
    result.fold(
      (ticketId) => _showDialog(localizations, ticketId),
      (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message))),
    );
  }

  void _showDialog(AppLocalizations? localizations, String ticketId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: const Color(0xff282828),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations?.t('messageSupport.dialogTitle') ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 14.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Ticket: $ticketId',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontFamily: 'SansSemiBold', fontSize: 14.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              localizations?.t('messageSupport.dialogsubTitle') ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontFamily: 'SansRegularlight', fontSize: 14.0),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(this.context).pop();
                },
                child: Text(
                  localizations?.t('messageSupport.buttomDialog') ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
