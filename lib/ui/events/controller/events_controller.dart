import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/events_details/models/ticket_model.dart';

import '../../authentication/model/user_model.dart';
import '../../create_event/models/event_model.dart';
import '../../notifications/model/nitofications_model.dart';

class EventsController extends ChangeNotifier {
  EventsController() {
    getAllUsers();
    getAllEvents();
    getUserBookedEvents();
  }

  CollectionReference ref = FirebaseFirestore.instance.collection("events");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  StreamSubscription<QuerySnapshot<Object?>>? usersStream;
  StreamSubscription<QuerySnapshot<Object?>>? eventStream;
  StreamSubscription<QuerySnapshot<Object?>>? userEventsStream;
  StreamSubscription<QuerySnapshot<Object?>>? res;
  List<TicketModel> userBookedEvents = [];
  List<EventModel> allEvents = [];
  List<UserModel> allUsers = [];

  getAllUsers() {
    usersStream = users.snapshots().listen((event) {
      allUsers = [];
      for (var element in event.docs) {
        allUsers
            .add(UserModel.fromJson(element.data() as Map<String, dynamic>));
      }
      notifyListeners();
    });
  }

  getAllEvents() {
    allEvents = [];
    eventStream = ref.snapshots().listen((event) {
      allEvents = [];
      event.docs.forEach((element) {
        allEvents
            .add(EventModel.fromJson(element.data() as Map<String, dynamic>));
        notifyListeners();
      });
    });
  }

  getUserBookedEvents() {
    if (FirebaseAuth.instance.currentUser != null) {
      userEventsStream = users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("tickets")
          .snapshots()
          .listen((event) {
        event.docs.forEach((element) {
          userBookedEvents.add(TicketModel.fromJson(element.data()));
        });
        notifyListeners();
      });
    }
  }

  sendInvite(String userId, EventModel event, context) async {
    try {
      Functions.showLoaderDialog(context);
      var doc = users.doc(userId).collection("notifications").doc();
      var senderId = FirebaseAuth.instance.currentUser!.uid;
      await doc.set(NotificationsModel(
              id: doc.id,
              senderId: senderId,
              image: "",
              eId: event.id,
              notificationContent: "",
              time: DateTime.now().millisecondsSinceEpoch,
              notificationType: "Invite",
              status: '')
          .toJson());
      await updateEventInvite(event, userId);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }
updateEventInvite(EventModel event,String userId) async {
    List<String> invites = event.invites;
    invites.add(userId);
    await ref.doc(event.id).update({
      "invites":invites
    });
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    res?.cancel();
    usersStream?.cancel();
    eventStream?.cancel();
    userEventsStream?.cancel();
  }
}
