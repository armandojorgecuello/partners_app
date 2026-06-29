import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/support/presentation/pages/send_support_ticket_page.dart';
import 'package:partners_app/features/support/presentation/providers/support_providers.dart';
import 'package:partners_app/features/support/presentation/widgets/support_ticket_tile.dart';

/// Relocated from lib/src/pages/more/support_ticket.dart.
class SupportTicketsPage extends ConsumerWidget {
  const SupportTicketsPage({super.key});

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
          title: Text(localizations?.t('support.title') ?? ''),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: AppColors.pageDark,
        body: Stack(
          children: [
            AsyncValueView(
              value: ref.watch(supportTicketsProvider(uid)),
              data: (tickets) {
                if (tickets.isEmpty) {
                  return Center(
                    child: Text(
                      localizations?.t('support.emptyListMessage') ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  itemCount: tickets.length,
                  itemBuilder: (context, index) =>
                      SupportTicketTile(ticket: tickets[index], localizations: localizations),
                );
              },
            ),
            Positioned(
              bottom: 16.0,
              left: 10.0,
              right: 10.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70.0)),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SendSupportTicketPage()),
                ),
                child: Text(
                  localizations?.t('support.submitTicket') ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'SansRegularlight'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
