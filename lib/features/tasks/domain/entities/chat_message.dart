class ChatMessage {
  final String message;
  final String senderUid;
  final String receiverUid;
  final DateTime? dateTime;

  const ChatMessage({
    required this.message,
    required this.senderUid,
    required this.receiverUid,
    this.dateTime,
  });
}
