class SupportTicket {
  final String ticketId;
  final String subject;
  final String description;
  final String status;
  final DateTime? dateTime;

  const SupportTicket({
    required this.ticketId,
    required this.subject,
    required this.description,
    required this.status,
    this.dateTime,
  });
}
