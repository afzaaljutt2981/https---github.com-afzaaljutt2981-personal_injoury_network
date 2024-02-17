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
  List<String> county = [];
  List<String> job = [];

  CampaignController() {
    getAllUsers();
  }

  setCounty(List<String> county) {
    this.county = county;
    getAllUsers();
  }

  setJob(List<String> job) {
    this.job = job;
    getAllUsers();
  }

  getAllUsers() {
    allUsers = [];
    users.snapshots().listen((event) {
      UserModel user;
      for (var element in event.docs) {
        user = UserModel.fromJson(element.data() as Map<String, dynamic>);
        if ((county.contains(user.county) || county.contains("all")) &&
            (job.contains(user.position) || job.contains("all"))) {
          allUsers.add(user);
        }
      }
      notifyListeners();
    });
  }

  createCampaign({
    required List<String> campaignCountry,
    required List<String> campaignJob,
    required String campaignDescription,
    required String pImage,
  }) async {
    print("campaignCountry -> $campaignCountry");
    print("campaignJob -> $campaignJob");
    print("pImage -> $pImage");
    print("campaignDescription -> $campaignDescription");
    List<String?> users = [];
    usersRef
        // .where("position", isEqualTo: campaignJob)
        // .where("country", isEqualTo: campaignCountry)
        .get()
        .then((usersSnapShot) async {
      // for (var element in usersSnapShot.docs) {
      //   users
      //       .add(ChatMessage.fromJson(element.data() as Map<String, dynamic>?));
      // }
      // print("userSnapShot lenght ->  ${usersSnapShot.docs.length}");
      UserModel parsedUser;
      usersSnapShot.docs.forEach((user) {
        parsedUser = UserModel.fromJson(user.data() as Map<String, dynamic>?);
        if (user.data() != null &&
            (campaignCountry[0] == "all" ||
                parsedUser.county == campaignCountry) &&
            (campaignJob[0] == "all" || parsedUser.position == campaignJob)) {
          users.add(parsedUser.id);
        }
      });
      users.forEach((element) {
        print(element.toString());
      });
      // for (var element in event.docs) {
      //   eventTickets.add(TicketModel.fromJson(element.data()));
      // }
      // print(
      //     "campaign new object -> ${CampaignModel(id: "campaignDoc.id", pImage: pImage, status: "Draft", country: campaignCountry, jobOrPosition: campaignJob, message: campaignDescription, timeCreated: DateTime.now().millisecondsSinceEpoch, members: users).toJson()}");
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
