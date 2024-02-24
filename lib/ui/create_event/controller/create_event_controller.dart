import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';

class CreateEventController extends ChangeNotifier {
  CollectionReference ref = FirebaseFirestore.instance.collection("events");

  addEvent(
      {required DateTime endTime,
      required DateTime startTime,
      required String address,
      required String description,
      required String title,
      required String pImage,
      required DateTime dateTime,
      required double latitude,
      required double longitude}) async {
    var doc = ref.doc();
    var uId = FirebaseAuth.instance.currentUser!.uid;
    await doc.set(EventModel(
            endTime: endTime.millisecondsSinceEpoch,
            startTime: startTime.millisecondsSinceEpoch,
            id: doc.id,
            pImage: pImage,
            address: address,
            description: description,
            uId: uId,
            status: "UpComing",
            invites: [],
            title: title,
            participants: 0,
            dateTime: dateTime.millisecondsSinceEpoch,
            longitude: longitude,
            latitude: latitude,
            isDeleted: false)
        .toJson());
  }
}
