import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/support/data/models/support_ticket_model.dart';

class SupportRemoteDataSource {
  final FirebaseFirestore _firestore;

  SupportRemoteDataSource(this._firestore);

  CollectionReference _ticketsFor(String uid) =>
      _firestore.collection('support_messages').doc(uid).collection('tickets');

  Stream<List<SupportTicketModel>> watchTickets(String uid) {
    return _ticketsFor(uid).orderBy('date_time', descending: true).snapshots().map(
      (snap) => snap.docs.map((d) => SupportTicketModel.fromJson(d.data() as Map<String, dynamic>)).toList(),
    );
  }

  Future<String> createTicket(String uid, String subject, String description) async {
    final docRef = await _ticketsFor(uid).add({
      'subject': subject,
      'description': description,
      'status': 'open',
      'date_time': Timestamp.now(),
      'ticket_id': '',
    });
    final ticketId = docRef.id.substring(0, 6).toUpperCase();
    await docRef.update({'ticket_id': ticketId});
    return ticketId;
  }
}
