import 'package:partners_app/features/support/domain/entities/support_ticket.dart';

abstract class SupportRepository {
  Stream<List<SupportTicket>> watchTickets(String uid);

  Future<String> createTicket({required String uid, required String subject, required String description});
}
