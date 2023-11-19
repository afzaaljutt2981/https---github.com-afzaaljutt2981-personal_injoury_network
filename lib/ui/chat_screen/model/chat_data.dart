import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  String? name;
  String? image;
  DateTime? dateTime;
  String? lastMessage;
  String? to;

  ChatData(
      {required this.lastMessage,
      required this.name,
      required this.dateTime,
      required this.to,
      required this.image});

  factory ChatData.fromJson(Map<String, dynamic>? json) {
    return ChatData(
        lastMessage: json?['lastMessage'],
        to: json?['to'],
        name: json?['name'],
        dateTime: (json?['dateTime'] as Timestamp).toDate(),
        image: json?['image']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "dateTime": dateTime,
        "image": image,
        "to": to,
        "lastMessage": lastMessage
      };
}
