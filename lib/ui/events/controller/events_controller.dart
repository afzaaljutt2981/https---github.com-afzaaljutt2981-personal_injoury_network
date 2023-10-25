import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../create_event/models/event_model.dart';

class EventsController extends ChangeNotifier {
  EventsController(){
    getAllEvents();
  }
  CollectionReference ref = FirebaseFirestore.instance.collection("events");
  StreamSubscription<QuerySnapshot<Object?>>? res;
  List<EventModel> allEvents = [];
  getAllEvents(){
    allEvents = [];
   var res =  ref.snapshots().listen((event) {
      event.docs.forEach((element) {
        allEvents.add(EventModel.fromJson(element.data() as Map<String,dynamic>));
        notifyListeners();
      });
      notifyListeners();
    });
  }
}