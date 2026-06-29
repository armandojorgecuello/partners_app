import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/tasks/domain/entities/chat_message.dart';

class ChatMessageModel {
  final String message;
  final String uidSender;
  final String uidReceiver;
  final Timestamp? dateTime;

  const ChatMessageModel({
    required this.message,
    required this.uidSender,
    required this.uidReceiver,
    this.dateTime,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    message: json['message'] ?? '',
    uidSender: json['uid_sender'] ?? '',
    uidReceiver: json['uid_receiver'] ?? '',
    dateTime: json['date_time'],
  );

  ChatMessage toEntity() => ChatMessage(
    message: message,
    senderUid: uidSender,
    receiverUid: uidReceiver,
    dateTime: dateTime?.toDate(),
  );
}
