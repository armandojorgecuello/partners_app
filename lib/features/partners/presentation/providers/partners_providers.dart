import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:partners_app/features/partners/data/datasources/partner_remote_data_source.dart';
import 'package:partners_app/features/partners/data/repositories/partner_repository_impl.dart';
import 'package:partners_app/features/partners/domain/entities/accepted_partner.dart';
import 'package:partners_app/features/partners/domain/entities/partner_request.dart';
import 'package:partners_app/features/partners/domain/repositories/partner_repository.dart';
import 'package:partners_app/features/partners/domain/usecases/accept_partner_request_usecase.dart';
import 'package:partners_app/features/partners/domain/usecases/remove_partner_usecase.dart';
import 'package:partners_app/features/partners/domain/usecases/send_partner_request_usecase.dart';
import 'package:partners_app/features/tasks/presentation/providers/tasks_providers.dart';

final partnerRemoteDataSourceProvider = Provider(
  (ref) => PartnerRemoteDataSource(ref.watch(firestoreProvider)),
);

final partnerRepositoryProvider = Provider<PartnerRepository>(
  (ref) => PartnerRepositoryImpl(ref.watch(partnerRemoteDataSourceProvider)),
);

final incomingPartnerRequestsProvider = StreamProvider.family<List<PartnerRequest>, String>(
  (ref, uid) => ref.watch(partnerRepositoryProvider).watchIncomingRequests(uid),
);

final acceptedPartnersProvider = StreamProvider.family<List<AcceptedPartner>, String>(
  (ref, uid) => ref.watch(partnerRepositoryProvider).watchAcceptedPartners(uid),
);

final sendPartnerRequestUseCaseProvider = Provider(
  (ref) => SendPartnerRequestUseCase(ref.watch(partnerRepositoryProvider), ref.watch(sendNotificationUseCaseProvider)),
);

final acceptPartnerRequestUseCaseProvider = Provider(
  (ref) => AcceptPartnerRequestUseCase(ref.watch(partnerRepositoryProvider), ref.watch(sendNotificationUseCaseProvider)),
);

final removePartnerUseCaseProvider = Provider(
  (ref) => RemovePartnerUseCase(ref.watch(partnerRepositoryProvider), ref.watch(taskRepositoryProvider)),
);
