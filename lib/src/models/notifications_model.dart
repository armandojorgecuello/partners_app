// // To parse this JSON data, do
// //
// //     final notificationsData = notificationsDataFromJson(jsonString);

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// NotificationsData notificationsDataFromJson(String str) => NotificationsData.fromJson(json.decode(str));

// String notificationsDataToJson(NotificationsData data) => json.encode(data.toJson());

// class NotificationsData {
//     NotificationsData({
//         this.taskId,
//         this.senderUid,
//         this.receiverUid,
//         this.type,
//         this.status,
//         this.dateTime,
//     });

//     String taskId;
//     String senderUid;
//     String receiverUid;
//     String type;
//     String status;
//     Timestamp dateTime;

//     factory NotificationsData.fromJson(Map<String, dynamic> json) => NotificationsData(
//         taskId: json["taskID"],
//         senderUid: json["sender_uid"],
//         receiverUid: json["receiver_uid"],
//         type: json["type"],
//         status: json["status"],
//         dateTime: json["datetime"],
//     );

//     Map<String, dynamic> toJson() => {
//         "taskID": taskId,
//         "senderUid": senderUid,
//         "receiverUid": receiverUid,
//         "type": type,
//         "status": status,
//         "dateTime": dateTime,
//     };
// }
