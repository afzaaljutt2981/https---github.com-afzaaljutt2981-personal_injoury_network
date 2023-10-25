import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/model/user_model.dart';

class MyProfileController extends ChangeNotifier {
  MyProfileController(){
    getUserData();
  }
  CollectionReference ref = FirebaseFirestore.instance.collection("users");
  UserModel? user;
  getUserData(){
    if (FirebaseAuth.instance.currentUser != null) {
      ref.doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        if (event.data() != null) {
          Map<String, dynamic> data = event.data() as Map<String, dynamic>;
          user = UserModel.fromJson(data);
           }
        notifyListeners();
      });
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (_) => BottomNavigationScreen(selectedIndex: 0)), (route) => false);
    }else{
      // Navigator.pop(context);
      // Functions.showSnackBar(context, "something went wrong");
    }
  }
  becomeMarketer() async {
    await ref.doc(user!.id).update({
      "userType": "marketer"
    });
  }
}