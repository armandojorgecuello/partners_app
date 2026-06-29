import 'package:partners_app/features/partners/domain/entities/accepted_partner.dart';
import 'package:partners_app/features/partners/domain/entities/partner_request.dart';

abstract class PartnerRepository {
  Stream<List<PartnerRequest>> watchIncomingRequests(String uid);

  Stream<List<AcceptedPartner>> watchAcceptedPartners(String uid);

  Future<bool> requestExists({required String senderUid, required String receiverUid});

  Future<bool> isAlreadyPartner({required String senderUid, required String receiverUid});

  Future<void> createRequest({required String senderUid, required String receiverUid});

  Future<void> acceptRequest({required String receiverUid, required String senderUid});

  Future<void> deleteRequest({required String receiverUid, required String senderUid});

  Future<void> removePartnerLink(String uid, String partnerUid);
}
