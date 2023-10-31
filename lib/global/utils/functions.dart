import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;

import 'app_strings.dart';

class Functions {
  static showSnackBar(BuildContext context, String message, {Color? color}) {
    color ??= Colors.white;
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(
          color: AppColors.kPrimaryColor,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showLoaderDialog(BuildContext context, {String text = 'Loading'}) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<String> uploadPic(Uint8List file,String name) async {
    try {
      final firebasestorage.FirebaseStorage _storage =
          firebasestorage.FirebaseStorage.instance;
      var uid = FirebaseAuth.instance.currentUser!.uid;

      int mills = DateTime.now().millisecondsSinceEpoch;
      String mils = '$mills';
      var reference = _storage.ref().child(name).child(uid).child(mils);
      var r = await reference.putData(
          file, SettableMetadata(contentType: 'image/jpeg'));
      if (r.state == firebasestorage.TaskState.success) {
        String url = await reference.getDownloadURL();
        return url;
      } else {
        throw PlatformException(
            code: "404", message: AppStrings.noDownloadLinkFound);
      }
    } catch (e) {
      rethrow;
    }
  }
}
