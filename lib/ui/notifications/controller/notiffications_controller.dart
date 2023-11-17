import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';

import '../../authentication/model/user_model.dart';

class NotificationsController extends ChangeNotifier {
  NotificationsController() {
    getUserNotifications();
  }

  CollectionReference user = FirebaseFirestore.instance.collection("users");
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? notificationsStream;
  List<NotificationsModel> notifications = [];

  getUserNotifications() {
    var uId = FirebaseAuth.instance.currentUser!.uid;
    notificationsStream = user
        .doc(uId)
        .collection("notifications")
        .orderBy("time", descending: true)
        .snapshots()
        .listen((event) {
      notifications = [];
      for (var element in event.docs) {
        notifications.add(NotificationsModel.fromJson(element.data()));
      }
      notifyListeners();
    });
    notifyListeners();
  }

  followTap(
      UserModel? userModel, String followerId, BuildContext context) async {
    final collectionRef = user.doc(userModel?.id??"");
    var fList = userModel?.followers??[];

    if (fList?.contains(followerId) == true) {
      fList?.remove(followerId);
    } else {
      fList?.add(followerId);
    }
    try {
      await collectionRef.update(
        {
          "followers": fList,
        },
      );
      fList = [];
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }

  followingTap(UserModel userModel, BuildContext context) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef = user.doc(userModel.id);
    var fList = userModel.followings;

    if (fList?.contains(id) == true) {
      fList?.remove(id);
    } else {
      fList?.add(id);
    }
    try {
      await collectionRef.update(
        {
          "followings": fList,
        },
      );
      fList = [];

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      CustomSnackBar(true).showInSnackBar("Request Accepted", context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }

  respondRequest(
      String notificationId, String status, BuildContext context) async {
    Functions.showLoaderDialog(context);
    var uId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await user
          .doc(uId)
          .collection("notifications")
          .doc(notificationId)
          .update({"status": status});
      if (status == "Rejected") {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        CustomSnackBar(false).showInSnackBar("Request $status", context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    notificationsStream?.cancel();
  }
}
