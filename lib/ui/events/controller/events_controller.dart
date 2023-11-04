import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../authentication/model/user_model.dart';
import '../../create_event/models/event_model.dart';

class EventsController extends ChangeNotifier {
  EventsController(){
    getAllUsers();
    getAllEvents();
  }
  CollectionReference ref = FirebaseFirestore.instance.collection("events");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  StreamSubscription<QuerySnapshot<Object?>>? res;
  List<EventModel> allEvents = [];
  List<UserModel> allUsers = [];
  getAllUsers() {
    users.snapshots().listen((event) {
      for (var element in event.docs) {
        allUsers
            .add(UserModel.fromJson(element.data() as Map<String, dynamic>));
      }
    });
    notifyListeners();
  }
  getAllEvents(){
    allEvents = [];
    res =  ref.snapshots().listen((event) {
      event.docs.forEach((element) {
        allEvents.add(EventModel.fromJson(element.data() as Map<String,dynamic>));
        notifyListeners();
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    res?.cancel();
  }
}