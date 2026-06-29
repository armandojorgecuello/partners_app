import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/features/support/domain/entities/support_ticket.dart';

/// Relocated from lib/src/pages/more/support_ticket.dart's `_ticketTile`.
class SupportTicketTile extends StatelessWidget {
  final SupportTicket ticket;
  final AppLocalizations? localizations;

  const SupportTicketTile({super.key, required this.ticket, required this.localizations});

  @override
  Widget build(BuildContext context) {
    final formattedDate = ticket.dateTime != null ? DateFormat("MMM d 'at' HH:mm").format(ticket.dateTime!) : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Ticket: ${ticket.ticketId}', style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 14.0)),
              const SizedBox(width: 5.0),
              Text(ticket.status, style: const TextStyle(color: Colors.greenAccent, fontFamily: 'Sans', fontSize: 14.0)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '${localizations?.t('support.date') ?? ''}: $formattedDate',
              style: const TextStyle(color: Colors.white, fontFamily: 'SansRegular', fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(localizations?.t('support.subject') ?? '', style: const TextStyle(color: Colors.white, fontFamily: 'SansRegular', fontSize: 14.0)),
          ),
          Text(ticket.subject, style: const TextStyle(color: Colors.white, fontFamily: 'SansRegular', fontSize: 14.0)),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(localizations?.t('support.description') ?? '', style: const TextStyle(color: Colors.white, fontFamily: 'SansRegular', fontSize: 14.0)),
          ),
          Text(ticket.description, style: const TextStyle(color: Colors.white, fontFamily: 'SansRegular', fontSize: 14.0)),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }
}
