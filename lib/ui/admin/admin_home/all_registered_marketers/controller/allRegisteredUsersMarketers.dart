import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';

import '../../../../authentication/model/user_model.dart';

class AllRegisteredMarketersController extends ChangeNotifier {
  AllRegisteredMarketersController() {
    getAllUsers();
  }

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  List<UserModel> allUsers = [];

  getAllUsers() {
    allUsers = [];
    users.snapshots().listen((event) {
      for (var element in event.docs) {
        print(element);
        allUsers
            .add(UserModel.fromJson(element.data() as Map<String, dynamic>));
      }
      notifyListeners();
    });
  }

  Future<void> updateUser(
    BuildContext context, {
    required String userUidToUpdate,
    required bool isDeleted,
  }) async {
    try {
      var doc = users.doc(userUidToUpdate);
      await doc.update({"isDeleted": isDeleted});
      getAllUsers();
      notifyListeners();
    } on Exception catch (error) {
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      notifyListeners();
    }
  }
}
