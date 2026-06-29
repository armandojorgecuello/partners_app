import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/partners/data/models/accepted_partner_model.dart';
import 'package:partners_app/features/partners/data/models/partner_request_model.dart';

class PartnerRemoteDataSource {
  final FirebaseFirestore _firestore;

  PartnerRemoteDataSource(this._firestore);

  CollectionReference get _requests => _firestore.collection('partner_requests');

  CollectionReference _acceptedFor(String uid) =>
      _firestore.collection('partners_accepted').doc(uid).collection('partners');

  String _requestId(String receiverUid, String senderUid) => '${receiverUid}_$senderUid';

  Stream<List<PartnerRequestModel>> watchIncomingRequests(String uid) {
    return _requests.where('receiver_uid', isEqualTo: uid).snapshots().map(
      (snap) => snap.docs.map((d) => PartnerRequestModel.fromJson(d.data() as Map<String, dynamic>)).toList(),
    );
  }

  Stream<List<AcceptedPartnerModel>> watchAcceptedPartners(String uid) {
    return _acceptedFor(uid).snapshots().map(
      (snap) => snap.docs.map((d) => AcceptedPartnerModel.fromJson(d.data() as Map<String, dynamic>)).toList(),
    );
  }

  Future<bool> requestExists(String senderUid, String receiverUid) async {
    final doc = await _requests.doc(_requestId(receiverUid, senderUid)).get();
    return doc.exists;
  }

  Future<bool> isAlreadyPartner(String senderUid, String receiverUid) async {
    final doc = await _acceptedFor(senderUid).doc(receiverUid).get();
    return doc.exists;
  }

  Future<void> createRequest(String senderUid, String receiverUid) {
    return _requests.doc(_requestId(receiverUid, senderUid)).set({
      'sender_uid': senderUid,
      'receiver_uid': receiverUid,
      'date_time': Timestamp.now(),
    });
  }

  Future<void> acceptRequest(String receiverUid, String senderUid) async {
    final now = Timestamp.now();
    final batch = _firestore.batch();
    batch.set(_acceptedFor(receiverUid).doc(senderUid), {
      'uid': receiverUid,
      'partner_uid': senderUid,
      'date_time': now,
    });
    batch.set(_acceptedFor(senderUid).doc(receiverUid), {
      'uid': senderUid,
      'partner_uid': receiverUid,
      'date_time': now,
    });
    batch.delete(_requests.doc(_requestId(receiverUid, senderUid)));
    await batch.commit();
  }

  Future<void> deleteRequest(String receiverUid, String senderUid) {
    return _requests.doc(_requestId(receiverUid, senderUid)).delete();
  }

  Future<void> removePartnerLink(String uid, String partnerUid) async {
    await _acceptedFor(uid).doc(partnerUid).delete();
    await _acceptedFor(partnerUid).doc(uid).delete();
  }
}
