import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/support/domain/entities/support_ticket.dart';

class SupportTicketModel {
  final String ticketId;
  final String subject;
  final String description;
  final String status;
  final Timestamp? dateTime;

  const SupportTicketModel({
    required this.ticketId,
    required this.subject,
    required this.description,
    required this.status,
    this.dateTime,
  });

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) => SupportTicketModel(
    ticketId: json['ticket_id'] ?? '',
    subject: json['subject'] ?? '',
    description: json['description'] ?? '',
    status: json['status'] ?? 'open',
    dateTime: json['date_time'],
  );

  SupportTicket toEntity() => SupportTicket(
    ticketId: ticketId,
    subject: subject,
    description: description,
    status: status,
    dateTime: dateTime?.toDate(),
  );
}
