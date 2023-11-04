import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';

class NotificationsController extends ChangeNotifier {
  NotificationsController(){
    print("start");
    getOtherUserNotifications();
  }
  CollectionReference user = FirebaseFirestore.instance.collection("users");
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? notificationsStream;
  List<NotificationsModel> notifications = [];
  getOtherUserNotifications(){
    var uId = FirebaseAuth.instance.currentUser!.uid;
    print(uId);
    print("object");
    notificationsStream  = user.doc(uId).collection("notifications").snapshots().listen((event) {
      for (var element in event.docs) {
        notifications.add(NotificationsModel.fromJson(element.data()));
      }
      notifyListeners();
    });
    print(notifications.length);
    notifyListeners();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    notificationsStream?.cancel();
  }
}
