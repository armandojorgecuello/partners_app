class PartnerRequest {
  final String senderUid;
  final String receiverUid;
  final DateTime? dateTime;

  const PartnerRequest({required this.senderUid, required this.receiverUid, this.dateTime});
}
