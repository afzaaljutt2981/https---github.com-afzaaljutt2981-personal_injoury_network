import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';

import '../models/ticket_model.dart';

class EventDetailsController extends ChangeNotifier {
  EventDetailsController(){

  }
  List<UserModel> allUsers = [];
  List<TicketModel> eventTickets = [];
CollectionReference events = FirebaseFirestore.instance.collection("events");
CollectionReference users = FirebaseFirestore.instance.collection("users");
getAllUsers(){
  users.snapshots().listen((event) {
    event.docs.forEach((element) {
      allUsers.add(UserModel.fromJson(element.data() as Map<String,dynamic>));
    });
    notifyListeners();
  });
}
getEventTickets(String eventId){
  events.doc(eventId).collection("tickets").snapshots().listen((event) {
    event.docs.forEach((element) {
      eventTickets.add(TicketModel.fromJson(element.data()));
    });
    notifyListeners();
  });
}
  addEventTicket(String eventId) async {
   var tickDoc = events.doc(eventId).collection("tickets").doc();
   await tickDoc.set({
     "uId": FirebaseAuth.instance.currentUser!.uid,
     "id": tickDoc.id
   });
  }
  addUserTicket(String eventId) async {
    var uId = FirebaseAuth.instance.currentUser!.uid;
    var tickDoc = users.doc(uId).collection("tickets").doc();
    await tickDoc.set({
      "eId":eventId,
      "id": tickDoc.id
    });
  }
}