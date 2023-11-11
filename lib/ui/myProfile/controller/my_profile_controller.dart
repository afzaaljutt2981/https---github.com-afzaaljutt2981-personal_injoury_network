import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';

import '../../authentication/model/user_model.dart';

class MyProfileController extends ChangeNotifier {
  MyProfileController() {
    getUserData();
  }

  CollectionReference ref = FirebaseFirestore.instance.collection("users");
  StreamSubscription<DocumentSnapshot<Object?>>? stream;
  UserModel? user;

  getUserData() {
    if (FirebaseAuth.instance.currentUser != null) {
      stream = ref
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        if (event.data() != null) {
          Map<String, dynamic> data = event.data() as Map<String, dynamic>;
          user = UserModel.fromJson(data);
          if (user != null) {
            Constants.userType = user!.userType;
          }
        }
        notifyListeners();
      });
    }
  }

  becomeMarketer() async {
    await ref.doc(user!.id).update({"userType": "marketer"});
    Constants.userType = "marketer";
  }

  updateUser({
    String? pImage,
    required String userName,
    required String company,
    required String position,
    required String cellPhone,
    required String website,
    required String location,
  }) async {
    String docId = FirebaseAuth.instance.currentUser!.uid;
    await ref.doc(docId).update({
      "userName": userName,
      "company": company,
      "position": position,
      "phone": int.parse(cellPhone),
      "website": website,
      "location": location,
      if (pImage != null) "pImage": pImage
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stream?.cancel();
  }
}
