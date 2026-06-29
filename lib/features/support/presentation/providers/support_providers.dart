import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/features/support/data/datasources/support_remote_data_source.dart';
import 'package:partners_app/features/support/data/repositories/support_repository_impl.dart';
import 'package:partners_app/features/support/domain/entities/support_ticket.dart';
import 'package:partners_app/features/support/domain/repositories/support_repository.dart';
import 'package:partners_app/features/support/domain/usecases/create_support_ticket_usecase.dart';

final supportRemoteDataSourceProvider = Provider(
  (ref) => SupportRemoteDataSource(ref.watch(firestoreProvider)),
);

final supportRepositoryProvider = Provider<SupportRepository>(
  (ref) => SupportRepositoryImpl(ref.watch(supportRemoteDataSourceProvider)),
);

final supportTicketsProvider = StreamProvider.family<List<SupportTicket>, String>(
  (ref, uid) => ref.watch(supportRepositoryProvider).watchTickets(uid),
);

final createSupportTicketUseCaseProvider = Provider(
  (ref) => CreateSupportTicketUseCase(ref.watch(supportRepositoryProvider)),
);
