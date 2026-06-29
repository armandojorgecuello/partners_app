import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/partners/domain/entities/partner_request.dart';

class PartnerRequestModel {
  final String senderUid;
  final String receiverUid;
  final Timestamp? dateTime;

  const PartnerRequestModel({required this.senderUid, required this.receiverUid, this.dateTime});

  factory PartnerRequestModel.fromJson(Map<String, dynamic> json) => PartnerRequestModel(
    senderUid: json['sender_uid'] ?? '',
    receiverUid: json['receiver_uid'] ?? '',
    dateTime: json['date_time'],
  );

  PartnerRequest toEntity() =>
      PartnerRequest(senderUid: senderUid, receiverUid: receiverUid, dateTime: dateTime?.toDate());
}
