import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';

import '../../authentication/model/user_model.dart';

class HelpController extends ChangeNotifier {
  HelpController() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
