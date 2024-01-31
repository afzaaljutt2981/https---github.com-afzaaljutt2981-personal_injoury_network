import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String? id;
  String? messageContent;
  String? messageType;
  String? senderId;
  DateTime? dateTime;
  bool? isRead;

  ChatMessage(
      {required this.messageContent,
      required this.id,
      required this.dateTime,
      required this.messageType,
      required this.senderId,
      required this.isRead});

  factory ChatMessage.fromJson(Map<String, dynamic>? json) {
    return ChatMessage(
        messageContent: json?['messageContent'],
        id: json?['id'],
        dateTime: (json?['dateTime'] as Timestamp).toDate(),
        messageType: json?['messageType'],
        senderId: json?['senderId'],
        isRead: json?['isRead']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "messageContent": messageContent,
        "messageType": messageType,
        "senderId": senderId,
        "dateTime": dateTime,
        "isRead": isRead
      };

  @override
  String toString() {
    return 'ChatMessage{id: $id, messageContent: $messageContent, messageType: $messageType, senderId: $senderId, dateTime: $dateTime, isRead: $isRead}';
  }
}
