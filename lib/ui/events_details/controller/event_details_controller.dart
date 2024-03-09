import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';

import '../../notifications/model/nitofications_model.dart';
import '../models/ticket_model.dart';

class EventDetailsController extends ChangeNotifier {
  EventDetailsController(String eventId) {
    getAllUsers();
    getEventTickets(eventId);
  }

  List<UserModel> allUsers = [];
  List<TicketModel> eventTickets = [];
  CollectionReference events = FirebaseFirestore.instance.collection("events");
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  getAllUsers() {
    users.snapshots().listen((event) {
      for (var element in event.docs) {
        allUsers
            .add(UserModel.fromJson(element.data() as Map<String, dynamic>));
      }
    });
    notifyListeners();
  }

  getEventTickets(String eventId) {
    events.doc(eventId).collection("tickets").snapshots().listen((event) {
      for (var element in event.docs) {
        eventTickets.add(TicketModel.fromJson(element.data()));
      }
      notifyListeners();
    });
  }

  addEventTicket(EventModel? event) async {
    var tickDoc = events.doc(event?.id).collection("tickets").doc();
    await events
        .doc(event?.id)
        .update({"participants": (event?.participants ?? 0) + 1});
    await tickDoc.set(TicketModel(
            id: tickDoc.id,
            eId: event?.id,
            uId: FirebaseAuth.instance.currentUser?.uid)
        .toJson());
  }

  addUserTicket(String eventId) async {
    var uId = FirebaseAuth.instance.currentUser?.uid;
    var tickDoc = users.doc(uId).collection("tickets").doc();
    await tickDoc.set(TicketModel(
            id: tickDoc.id,
            eId: eventId,
            uId: FirebaseAuth.instance.currentUser?.uid)
        .toJson());
  }

  deleteEvent(String eventId) async {
    await events.doc(eventId).update({"status": "Cancelled"});
    notifyListeners();
  }

  notifyCancelEvent(String? userId, String eventName) async {
    var doc = users.doc(userId).collection("notifications").doc();
    var senderId = FirebaseAuth.instance.currentUser?.uid;
    await doc.set(NotificationsModel(
            id: doc.id,
            senderId: senderId,
            image: "",
            notificationContent: "Cancelled $eventName",
            time: DateTime.now().millisecondsSinceEpoch,
            notificationType: "cancel Event",
            status: 'Pending')
        .toJson());
    await users.doc(userId).update({"isNewNotificationReceived": true});

    print("i am here");
  }
}
