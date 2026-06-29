import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/partners/domain/entities/accepted_partner.dart';

class AcceptedPartnerModel {
  final String uid;
  final String partnerUid;
  final Timestamp? dateTime;

  const AcceptedPartnerModel({required this.uid, required this.partnerUid, this.dateTime});

  factory AcceptedPartnerModel.fromJson(Map<String, dynamic> json) => AcceptedPartnerModel(
    uid: json['uid'] ?? '',
    partnerUid: json['partner_uid'] ?? '',
    dateTime: json['date_time'],
  );

  AcceptedPartner toEntity() =>
      AcceptedPartner(uid: uid, partnerUid: partnerUid, dateTime: dateTime?.toDate());
}
