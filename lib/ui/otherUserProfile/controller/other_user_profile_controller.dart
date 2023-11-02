import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';

import '../../events_details/models/ticket_model.dart';

class OtherUserProfileController extends ChangeNotifier {
  OtherUserProfileController({String? userId}){
    if(userId != null){
    getUserData(userId);
    getUserEvents(userId);
    }
  }
CollectionReference user = FirebaseFirestore.instance.collection("users");
UserModel? userModel;
List<TicketModel> userTickets = [];
  getUserData(String userId){
    user.doc(userId).snapshots().listen((event) {
      userModel = UserModel.fromJson(event.data() as Map<String,dynamic>);
      notifyListeners();
    });
  }
  getUserEvents(String userId){
    user.doc(userId).collection("tickets").snapshots().listen((event) {
      for (var element in event.docs) {
        userTickets.add(TicketModel.fromJson(element.data()));
      }
      notifyListeners();
    });

  }
  followTap(
      UserModel userModel,
      String id,
      ) {
    String cId = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef =
    FirebaseFirestore.instance.collection("users").doc(id);
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

  followingTap(
      UserModel userModel,
      String id,
      ) {
    final collectionRef =
    FirebaseFirestore.instance.collection("users").doc(id);
    var fList = userModel.followers;

    if (fList.contains(id)) {
      fList.remove(id);
    } else {
      fList.add(id);
    }
    collectionRef.update(
      {
        "following": fList,
      },
    ).then((value) {
      fList = [];
    });
  }
}