import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../authentication/model/user_model.dart';


class AllRegisteredMarketersController extends ChangeNotifier {
  AllRegisteredMarketersController(){
    getAllUsers();
  }
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  List<UserModel> allUsers = [];
  getAllUsers() {
    users.snapshots().listen((event) {
      for (var element in event.docs) {
        allUsers
            .add(UserModel.fromJson(element.data() as Map<String, dynamic>));
      }
      notifyListeners();
    });
  }
}