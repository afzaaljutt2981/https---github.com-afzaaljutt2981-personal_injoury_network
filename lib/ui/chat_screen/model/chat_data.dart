import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  String? name;
  String? image;
  DateTime? dateTime;
  String? lastMessage;
  String? to;
  bool? isRead;

  ChatData(
      {required this.lastMessage,
      required this.name,
      required this.dateTime,
      required this.to,
      required this.image,
      required this.isRead});

  factory ChatData.fromJson(Map<String, dynamic>? json) {
    return ChatData(
        lastMessage: json?['lastMessage'],
        to: json?['to'],
        name: json?['name'],
        dateTime: (json?['dateTime'] as Timestamp).toDate(),
        image: json?['image'],
        isRead: json?['isRead']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "dateTime": dateTime,
        "image": image,
        "to": to,
        "lastMessage": lastMessage,
        "isRead": isRead
      };

  @override
  String toString() {
    return 'ChatData{name: $name, image: $image, dateTime: $dateTime, lastMessage: $lastMessage, to: $to, isRead: $isRead}';
  }
}
