import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/chat_screen/model/chat_data.dart';

class UserChatData extends ChangeNotifier {
  UserChatData(){
getUserChats();
  }
  CollectionReference messages =
  FirebaseFirestore.instance.collection("messages");
  List<ChatData> userChatsData = [];
  //comment
  getUserChats(){
    var uId = FirebaseAuth.instance.currentUser!.uid;
    messages.doc(uId).collection("chats").snapshots().listen((event) {
      userChatsData = [];
      for (var element in event.docs) {
        userChatsData.add(ChatData.fromJson(element.data()));
      }
      notifyListeners();
    });
  }
}