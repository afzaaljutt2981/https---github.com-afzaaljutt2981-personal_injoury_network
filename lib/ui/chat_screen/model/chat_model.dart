import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String id;
  String messageContent;
  String messageType;
  String senderId;
  DateTime dateTime;

  ChatMessage(
      {required this.messageContent,
      required this.id,
      required this.dateTime,
      required this.messageType,
      required this.senderId});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        messageContent: json['messageContent'],
        id: json['id'],
        dateTime: (json['dateTime'] as Timestamp).toDate(),
        messageType: json['messageType'],
        senderId: json['senderId']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "messageContent": messageContent,
        "messageType": messageType,
        "senderId": senderId,
        "dateTime": dateTime
      };
}
