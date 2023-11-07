import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';

import '../../../global/utils/custom_snackbar.dart';
import '../view/verify_identity.dart';

class ForgetPasswordController extends ChangeNotifier {
  Future resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyIdentity(
                    email: email.toString(),
                    from: 1,
                  )));
    } catch (e) {
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }

  Future sendVerificationEmail(BuildContext context) async {
    try {
      Functions.showLoaderDialog(context);
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => BottomNavigationScreen(selectedIndex: 0,
      //           // email: email.toString(),
      //           // from: 1,
      //         )));
      CustomSnackBar(true)
          .showInSnackBar("Verification email sent successfully", context);
    } catch (e) {
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }
}
