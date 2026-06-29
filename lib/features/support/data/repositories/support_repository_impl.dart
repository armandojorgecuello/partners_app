import 'package:partners_app/features/support/data/datasources/support_remote_data_source.dart';
import 'package:partners_app/features/support/domain/entities/support_ticket.dart';
import 'package:partners_app/features/support/domain/repositories/support_repository.dart';

class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDataSource _remote;

  SupportRepositoryImpl(this._remote);

  @override
  Stream<List<SupportTicket>> watchTickets(String uid) {
    return _remote.watchTickets(uid).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<String> createTicket({required String uid, required String subject, required String description}) {
    return _remote.createTicket(uid, subject, description);
  }
}
