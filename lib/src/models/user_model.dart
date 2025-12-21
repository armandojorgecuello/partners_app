import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserPhoneModel {
//   static UserCredential? user;
// }

// class User {
//   static DocumentSnapshot? documentSnapshot;
// }

class Lang {
  static String? lang;
}

// To parse this JSON data, do
//
//     final taskData = taskDataFromJson(jsonString);

TaskData taskDataFromJson(String str) => TaskData.fromJson(json.decode(str));

String taskDataToJson(TaskData data) => json.encode(data.toJson());

class TaskData {
  TaskData({
    // required this.dateTime,
    // required this.deliveryTime,
    required this.receiverUid,
    required this.rewardDescription,
    required this.rewardImgUrl,
    required this.senderUid,
    required this.status,
    required this.title,
    required this.uidTask,
    required this.reviewValue,
    required this.reviewDescription,
  });

  // Timestamp dateTime;
  // Timestamp deliveryTime;
  String receiverUid;
  String rewardDescription;
  String rewardImgUrl = "";
  String senderUid;
  String status;
  String title;
  String uidTask;
  String reviewValue;
  String reviewDescription;

  factory TaskData.fromJson(Map<String, dynamic> json) => TaskData(
    // dateTime: json["date_time"],
    // deliveryTime: json["delivery_time"],
    receiverUid: json["receiver_uid"],
    rewardDescription: json["reward_description"],
    rewardImgUrl: json["reward_img_url"],
    senderUid: json["sender_uid"],
    status: json["status"],
    title: json["title"],
    uidTask: json["uid_task"],
    reviewValue: json["review_value"],
    reviewDescription: json["review_description!"],
  );

  Map<String, dynamic> toJson() => {
    // "date_time": dateTime,
    // "delivery_time": deliveryTime,
    "receiver_uid": receiverUid,
    "reward_description": rewardDescription,
    "reward_img_url": rewardImgUrl,
    "sender_uid": senderUid,
    "status": status,
    "title": title,
    "uid_task": uidTask,
    "review_value": reviewValue,
    "review_description!": reviewDescription,
  };
}
