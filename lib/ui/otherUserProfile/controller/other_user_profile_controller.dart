import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';

import '../../events_details/models/ticket_model.dart';
import '../../notifications/model/nitofications_model.dart';

class OtherUserProfileController extends ChangeNotifier {
  OtherUserProfileController({String? userId}) {
    if (userId != null) {
      getOtherUserData(userId);
      getUserEvents(userId);
      getOtherUserNotifications(userId);
      // getAllUsers();
    }
  }

  CollectionReference user = FirebaseFirestore.instance.collection("users");
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? notificationsStream;
  StreamSubscription<QuerySnapshot<Object?>>? usersStream;
  UserModel? userModel;
  List<NotificationsModel> notifications = [];
  List<TicketModel> userTickets = [];
  List<UserModel> allUsers = [];

  getOtherUserNotifications(String userId) {
    notificationsStream = user
        .doc(userId)
        .collection("notifications")
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        notifications.add(NotificationsModel.fromJson(element.data()));
      }
    });
    notifyListeners();
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

  sendFollowRequest(String userId, BuildContext context) async {
    var senderId = FirebaseAuth.instance.currentUser!.uid;
    var sender = await user.doc(senderId).get().then((userSnapShot) {
      return UserModel.fromJson(userSnapShot.data() as Map<String, dynamic>);
    });
    print("userId -> ${userId}");
    if (await getTotalRequests(sender) < 3) {
      var doc = user.doc(userId).collection("notifications").doc();
      await doc.set(NotificationsModel(
              id: doc.id,
              senderId: senderId,
              image: "",
              notificationContent: "",
              time: DateTime.now().millisecondsSinceEpoch,
              notificationType: "Follow",
              status: 'Pending')
          .toJson());
      print("sender.id ->  ${sender.id}");
      print("sender.followingRequests ->  ${sender.followingRequests}");
      final collectionRef = user.doc(sender.id);
      var fList = sender.followingRequests;
      print("fList -> ${fList}");
      if (fList?.contains(userId) == false) {
        fList?.add(userId);
        try {
          await collectionRef.update(
            {
              "followingRequests": fList,
            },
          );
        } catch (ex) {
          print("exception -> ${ex}");
        }

        fList = [];
      }
      print("fList -> ${fList}");
    } else {
      CustomSnackBar(false)
          .showInSnackBar('Follow request limit reached', context);
    }
    notifyListeners();
  }

  Future<int> getTotalRequests(UserModel sender) async {
    //Todo correct the code with help of firebase structure
    List<NotificationsModel> allNotificationsOfCurrentUser = [];
    print("sender.followingRequests -> ${sender.followingRequests}");
    // Iterate over each user
    for (var user in sender.followingRequests ?? []) {
      // For each user, get their notifications where senderId is "xyz"
      print(user);
      await FirebaseFirestore.instance
          .collection('users/${user}/notifications')
          .where('senderId', isEqualTo: sender.id)
          .get()
          .then((requests) {
        for (var element in requests.docs) {
          allNotificationsOfCurrentUser
              .add(NotificationsModel.fromJson(element.data()));
        }
      });

      // for (var element in notificationsSnapshot.docs) {
      //   allNotificationsOfCurrentUser
      //       .add(NotificationsModel.fromJson(element.data()));
      // }
      // // Process each notification
      // for (var notification in notificationsSnapshot.docs) {
      //   allNotificationsOfCurrentUser.
      // }
    }

    print(allNotificationsOfCurrentUser);
    var totalRequestsSentToday = allNotificationsOfCurrentUser
        .where((element) =>
    DateTime.now()
        .difference(
        DateTime.fromMillisecondsSinceEpoch(element.time ?? 0))
        .inDays ==
        0);
    print(
        "totalRequestsSentToday -> ${totalRequestsSentToday}");
    print(
        "len totalRequestsSentToday -> ${totalRequestsSentToday.length}");


    // return user.doc(senderId).collection("notifications").get().then((events) {
    //   for (var element in events.docs) {
    //     allNotificationsOfCurrentUser
    //         .add(NotificationsModel.fromJson(element.data()));
    //   }
    //   return allNotificationsOfCurrentUser
    //       .where((element) =>
    //           DateTime.fromMillisecondsSinceEpoch(element.time ?? 0)
    //               .difference(DateTime.now())
    //               .inDays ==
    //           0)
    //       .length;
    // });
    return totalRequestsSentToday.length;
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

    if (fList?.contains(cId) == true) {
      fList?.remove(cId);
    } else {
      fList?.add(cId);
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

  followingTap(UserModel? userModel, String? uId) {
    String id = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef = user.doc(id);
    var fList = userModel?.followings ?? [];

    if (fList.contains(uId)) {
      fList.remove(uId);
    } else {
      fList.add(uId ?? "");
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
