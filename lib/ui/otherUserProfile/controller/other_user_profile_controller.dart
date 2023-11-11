import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';

import '../../events_details/models/ticket_model.dart';
import '../../notifications/model/nitofications_model.dart';

class OtherUserProfileController extends ChangeNotifier {
  OtherUserProfileController({String? userId}) {
    if (userId != null) {
      getOtherUserData(userId);
      getUserEvents(userId);
      getOtherUserNotifications(userId);
    }
  }

  CollectionReference user = FirebaseFirestore.instance.collection("users");
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? notificationsStream;
  UserModel? userModel;
  List<NotificationsModel> notifications = [];
  List<TicketModel> userTickets = [];

  getOtherUserNotifications(String userId) {
    notificationsStream = user
        .doc(userId)
        .collection("notifications")
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        notifications.add(NotificationsModel.fromJson(element.data()));
      }
      notifyListeners();
    });
  }

  getOtherUserData(String userId) {
    user.doc(userId).snapshots().listen((event) {
      userModel = UserModel.fromJson(event.data() as Map<String, dynamic>);
    });
    notifyListeners();
  }

  getUserEvents(String userId) {
    user.doc(userId).collection("tickets").snapshots().listen((event) {
      for (var element in event.docs) {
        userTickets.add(TicketModel.fromJson(element.data()));
      }
      notifyListeners();
    });
  }

  sendFollowRequest(String userId) {
    var doc = user.doc(userId).collection("notifications").doc();
    var senderId = FirebaseAuth.instance.currentUser!.uid;
    doc.set(NotificationsModel(
            id: doc.id,
            senderId: senderId,
            image: "",
            notificationContent: "",
            time: DateTime.now().millisecondsSinceEpoch,
            notificationType: "Follow",
            status: 'Pending')
        .toJson());
  }

  unFollow(String userId, String notificationId) async {
    await user
        .doc(userId)
        .collection("notifications")
        .doc(notificationId)
        .update({"status": "unFollowed"});
  }

  followTap(
    UserModel userModel,
  ) {
    String cId = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef =
        FirebaseFirestore.instance.collection("users").doc(userModel.id);
    var fList = userModel.followers;

    if (fList.contains(cId)) {
      fList.remove(cId);
    } else {
      fList.add(cId);
    }
    collectionRef.update(
      {
        "followers": fList,
      },
    ).then((value) {
      fList = [];
      // var uuid = const Uuid().v1();
      // SendNotification(
      //   id,
      //   uuid,
      //   'NewFollower'.tr,
      //   'youGotANewFollower'.tr,
      // ).sendPushMessage();
    });
  }

  followingTap(UserModel userModel, String uId) {
    String id = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef = user.doc(id);
    var fList = userModel.followings;

    if (fList.contains(uId)) {
      fList.remove(uId);
    } else {
      fList.add(uId);
    }
    collectionRef.update(
      {
        "followings": fList,
      },
    ).then((value) {
      fList = [];
    });
  }
}
