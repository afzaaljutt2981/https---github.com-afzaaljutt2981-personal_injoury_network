import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';

class CampaignController extends ChangeNotifier {
  CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
  CollectionReference campaignsRef =
      FirebaseFirestore.instance.collection("campaigns");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  List<UserModel> allUsers = [];
  String? county;
  String? job;

  CampaignController() {
    getAllUsers();
  }

  setCounty(String county) {
    this.county = county;
    getAllUsers();
  }

  setJob(String job) {
    this.job = job;
    getAllUsers();
  }

  getAllUsers() {
    allUsers = [];
    users.snapshots().listen((event) {
      UserModel user;
      for (var element in event.docs) {
        user = UserModel.fromJson(element.data() as Map<String, dynamic>);
        if ((user.county == county || county == "all") && (user.position == job || job == "all")) {
          allUsers.add(user);
        }
      }
      notifyListeners();
    });
  }

  createCampaign({
    required String campaignCountry,
    required String campaignJob,
    required String campaignDescription,
    required String pImage,
  }) async {
    print("campaignCountry -> $campaignCountry");
    print("campaignJob -> $campaignJob");
    print("pImage -> $pImage");
    print("campaignDescription -> $campaignDescription");
    List<String?> users = [];
    usersRef
        .where("position", isEqualTo: campaignJob)
        .where("country", isEqualTo: campaignCountry)
        .get()
        .then((usersSnapShot) async {
      // for (var element in usersSnapShot.docs) {
      //   users
      //       .add(ChatMessage.fromJson(element.data() as Map<String, dynamic>?));
      // }
      // print("userSnapShot lenght ->  ${usersSnapShot.docs.length}");
      usersSnapShot.docs.forEach((user) {
        if (user.data() != null) {
          users
              .add(UserModel.fromJson(user.data() as Map<String, dynamic>?).id);
        }
      });
      users.forEach((element) {
        print(element.toString());
      });
      // for (var element in event.docs) {
      //   eventTickets.add(TicketModel.fromJson(element.data()));
      // }
      print(
          "campaign new object -> ${CampaignModel(id: "campaignDoc.id", pImage: pImage, status: "Draft", country: campaignCountry, jobOrPosition: campaignJob, message: campaignDescription, timeCreated: DateTime.now().millisecondsSinceEpoch, members: users).toJson()}");
      var campaignDoc = campaignsRef.doc();

      await campaignDoc.set(CampaignModel(
              id: campaignDoc.id,
              pImage: pImage,
              status: "Draft",
              country: campaignCountry,
              jobOrPosition: campaignJob,
              message: campaignDescription,
              timeCreated: DateTime.now().millisecondsSinceEpoch,
              members: users)
          .toJson());
      notifyListeners();
    });
  }
}
