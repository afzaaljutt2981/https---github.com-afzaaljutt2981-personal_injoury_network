import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/chat_screen/model/chat_data.dart';
import 'package:personal_injury_networking/ui/chat_screen/model/chat_model.dart';

class ChatController extends ChangeNotifier {
  ChatController({String? otherUserId}) {
    if (otherUserId != null) {
      getUserMessages(otherUserId);
    }
  }

  CollectionReference messages =
      FirebaseFirestore.instance.collection("messages");
  StreamSubscription<QuerySnapshot<Object?>>? chatStream;
  List<ChatMessage> currentChat = [];
  bool isDone = false;

  getUserMessages(String otherUserId) {
    var uId = FirebaseAuth.instance.currentUser!.uid;
    chatStream = messages
        .doc(uId)
        .collection("chats")
        .doc(otherUserId)
        .collection("messages")
        .orderBy("dateTime", descending: false)
        .snapshots()
        .listen((event) {
      isDone = false;
      currentChat = [];
      // print("Displaying chats");
      // for (var chat in event.docs) {
      //   print(ChatMessage.fromJson(chat.data()).toJson());
      // }
      for (var element in event.docs) {
        currentChat.add(ChatMessage.fromJson(element.data()));
      }
      setMessageAsRead(
          uId, otherUserId, ChatMessage.fromJson(event.docs.last.data()));
      notifyListeners();
    });
  }

  setMessageAsRead(String uid, String otherUserId, ChatMessage message) {
    messages
        .doc(uid)
        .collection("chats")
        .doc(otherUserId)
        .update({"isRead": true});
  }

  sendMessage(
      String receiverId, String messageContent, String messageType) async {
    var uId = FirebaseAuth.instance.currentUser!.uid;
    var senderDoc = messages
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .doc();
    var receiverDoc = messages
        .doc(receiverId)
        .collection("chats")
        .doc(uId)
        .collection("messages")
        .doc();
    try {
      await senderDoc.set(ChatMessage(
              messageContent: messageContent,
              senderId: uId,
              id: senderDoc.id,
              dateTime: DateTime.now(),
              messageType: messageType,
              isRead: true)
          .toJson());
      await receiverDoc.set(ChatMessage(
              messageContent: messageContent,
              id: receiverDoc.id,
              dateTime: DateTime.now(),
              senderId: uId,
              messageType: messageType,
              isRead: false)
          .toJson());
      await saveUserChatData(uId, receiverId, messageContent);
    } catch (_) {}
  }

  saveUserChatData(String uId, String receiverId, String messageContent) async {
    await messages.doc(uId).collection("chats").doc(receiverId).set(ChatData(
            lastMessage: messageContent,
            name: "name",
            dateTime: DateTime.now(),
            image: "",
            to: receiverId,
            isRead: true)
        .toJson());
    await messages.doc(receiverId).collection("chats").doc(uId).set(ChatData(
            name: "name",
            lastMessage: messageContent,
            dateTime: DateTime.now(),
            image: "",
            to: uId,
            isRead: false)
        .toJson());
  }

  @override
  void dispose() {
    chatStream?.cancel();
    super.dispose();

  }
}
