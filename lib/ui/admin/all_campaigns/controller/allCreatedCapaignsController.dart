import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/helper/api_functions.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';

import '../../../compaign/models/campaign_model.dart';

class AllCreatedCampaignsController extends ChangeNotifier {
  AllCreatedCampaignsController() {
    getAllCampaigns();
  }

  CollectionReference campaignsRef =
      FirebaseFirestore.instance.collection("campaigns");
  CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
  List<CampaignModel> allCampaigns = [];
  StreamSubscription<QuerySnapshot<Object?>>? campaignsStream;

  getAllCampaigns() {
    campaignsStream = campaignsRef.snapshots().listen((event) {
      allCampaigns = [];
      for (var element in event.docs) {
        final campaign =
            CampaignModel.fromJson(element.data() as Map<String, dynamic>);
        if (campaign.isDeleted == false)
          allCampaigns.add(
              CampaignModel.fromJson(element.data() as Map<String, dynamic>));
      }
      notifyListeners();
    });
  }

  getAllCampaignsOnce() {
    campaignsRef.get().then((event) {
      allCampaigns = [];
      for (var element in event.docs) {
        final campaign =
            CampaignModel.fromJson(element.data() as Map<String, dynamic>);
        if (campaign.isDeleted == false) allCampaigns.add(campaign);
      }
      notifyListeners();
    });
  }

  Future<void> initiateCampaign(
    BuildContext context, {
    required CampaignModel campaign,
  }) async {
    try {
      var doc = campaignsRef.doc(campaign.id);
      await doc.update({"status": "initiated"});
      campaign.members?.forEach((userId) async {
        usersRef.doc(userId).get().then((userSnapShot) async {
          UserModel? user =
              UserModel.fromJson(userSnapShot.data() as Map<String, dynamic>?);
          if (user.fcmToken != null) {
            // await context
            // .read<EventDetailsController>()
            // .notifyCancelEvent(element!.id!,
            // widget.event.title!);
            await CountryStateCityRepo.sendPushNotification(
                campaign.title ?? "Admin Campaign", "", user.fcmToken ?? "");
            await usersRef
                .doc(userId)
                .update({"isNewNotificationReceived": true});
          }
        });
      });
      await doc.update({"status": "Completed"});
      getAllCampaigns();
      notifyListeners();
    } on Exception catch (error) {
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      notifyListeners();
    }
  }

  Future<void> deleteCampaign(
    BuildContext context, {
    required CampaignModel campaign,
  }) async {
    try {
      print("deleteCampaign initiated");
      var doc = campaignsRef.doc(campaign.id);
      await doc.update({"isDeleted": true});
      getAllCampaignsOnce();
      notifyListeners();
    } on Exception catch (error) {
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      notifyListeners();
    }
  }

  refreshState() {
    notifyListeners();
  }

  @override
  void dispose() {
    campaignsStream?.cancel();
    super.dispose();
  }
}
