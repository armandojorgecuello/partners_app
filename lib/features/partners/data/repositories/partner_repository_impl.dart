import 'package:partners_app/features/partners/data/datasources/partner_remote_data_source.dart';
import 'package:partners_app/features/partners/domain/entities/accepted_partner.dart';
import 'package:partners_app/features/partners/domain/entities/partner_request.dart';
import 'package:partners_app/features/partners/domain/repositories/partner_repository.dart';

class PartnerRepositoryImpl implements PartnerRepository {
  final PartnerRemoteDataSource _remote;

  PartnerRepositoryImpl(this._remote);

  @override
  Stream<List<PartnerRequest>> watchIncomingRequests(String uid) {
    return _remote.watchIncomingRequests(uid).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Stream<List<AcceptedPartner>> watchAcceptedPartners(String uid) {
    return _remote.watchAcceptedPartners(uid).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<bool> requestExists({required String senderUid, required String receiverUid}) =>
      _remote.requestExists(senderUid, receiverUid);

  @override
  Future<bool> isAlreadyPartner({required String senderUid, required String receiverUid}) =>
      _remote.isAlreadyPartner(senderUid, receiverUid);

  @override
  Future<void> createRequest({required String senderUid, required String receiverUid}) =>
      _remote.createRequest(senderUid, receiverUid);

  @override
  Future<void> acceptRequest({required String receiverUid, required String senderUid}) =>
      _remote.acceptRequest(receiverUid, senderUid);

  @override
  Future<void> deleteRequest({required String receiverUid, required String senderUid}) =>
      _remote.deleteRequest(receiverUid, senderUid);

  @override
  Future<void> removePartnerLink(String uid, String partnerUid) => _remote.removePartnerLink(uid, partnerUid);
}
