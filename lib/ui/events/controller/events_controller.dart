import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/chat_screen/model/chat_data.dart';
import 'package:personal_injury_networking/ui/events_details/models/ticket_model.dart';
import 'package:personal_injury_networking/ui/notifications/view/notification_view.dart';

import '../../authentication/model/user_model.dart';
import '../../create_event/models/event_model.dart';
import '../../notifications/model/nitofications_model.dart';

class EventsController extends ChangeNotifier {
  EventsController() {
    getAllUsers();
    getAllEvents();
    getUserBookedEvents();
    // getAllChats();
  }

  CollectionReference ref = FirebaseFirestore.instance.collection("events");
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  // CollectionReference messagesRef =
  //     FirebaseFirestore.instance.collection("messages");

  StreamSubscription<QuerySnapshot<Object?>>? usersStream;
  StreamSubscription<QuerySnapshot<Object?>>? eventStream;
  StreamSubscription<QuerySnapshot<Object?>>? userEventsStream;
  StreamSubscription<QuerySnapshot<Object?>>? messagesStream;
  StreamSubscription<QuerySnapshot<Object?>>? res;
  List<TicketModel> userBookedEvents = [];
  List<TicketModel> eventTickets = [];
  List<EventModel> allEvents = [];
  List<UserModel> allUsers = [];
  List<ChatData> allMessages = [];

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

  // getAllChats() async {
  //   messagesStream =  messagesRef
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection("chats")
  //       .snapshots()
  //       .listen((messages) {
  //     allMessages = [];
  //     for (var element in messages.docs) {
  //       allMessages
  //           .add(ChatData.fromJson(element.data() as Map<String, dynamic>));
  //     }
  //   });
  // }

  getAllEvents() async {
    allEvents = [];
    eventStream = ref.snapshots().listen((event) async {
      allEvents = [];
      event.docs.forEach((element) {
        final event =
            EventModel.fromJson(element.data() as Map<String, dynamic>);
        if (event.isDeleted == false) allEvents.add(event);
      });
      allEvents = allEvents.sortedBy((event) => event.startTime ?? 0).toList();
    });
    // notifyListeners();
  }

  getAllEventsOnce() async {
    allEvents = [];
    await ref.get().then((event) {
      print("events -> ${event.docs.length}");
      for (var element in event.docs) {
        final event =
            EventModel.fromJson(element.data() as Map<String, dynamic>);
        if (event.isDeleted == false) allEvents.add(event);
      }
    });
    allEvents = allEvents.sortedBy((event) => event.startTime ?? 0).toList();
    notifyListeners();
  }

  getUserBookedEvents() {
    if (FirebaseAuth.instance.currentUser != null) {
      userEventsStream = users
          .doc(FirebaseAuth.instance.currentUser?.uid)
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

  sendInvite(String userId, EventModel? event, context) async {
    try {
      Functions.showLoaderDialog(context);
      var doc = users.doc(userId).collection("notifications").doc();
      var senderId = FirebaseAuth.instance.currentUser?.uid;
      await doc.set(NotificationsModel(
              id: doc.id,
              senderId: senderId,
              image: "",
              eId: event?.id ?? "",
              notificationContent:
                  "You are invited for ${event?.title ?? "event"} scheduled on ${DateTime(event?.dateTime ?? 0).day} of ${DateTime(event?.dateTime ?? 0).month} at ${event?.address}",
              time: DateTime.now().millisecondsSinceEpoch,
              notificationType: "Invite",
              status: '')
          .toJson());
      users.doc(userId).update({"isNewNotificationReceived": true});

      await updateEventInvite(event, userId);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }

  updateEventInvite(EventModel? event, String? userId) async {
    List<String?> invites = event?.invites ?? [];
    invites.add(userId);
    await ref.doc(event?.id).update({"invites": invites});
  }

  updateEventToDeleted(EventModel? event, BuildContext context) async {
    try {
      print("updateEventToDeleted called");
      await ref.doc(event?.id).update({"isDeleted": true});
      getAllEventsOnce();
      notifyListeners();
    } on Exception catch (error) {
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    res?.cancel();
    usersStream?.cancel();
    eventStream?.cancel();
    userEventsStream?.cancel();
    messagesStream?.cancel();
  }
}
