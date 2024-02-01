import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/forgetPassword/view/create_verify_identity_view.dart';

import '../../../global/utils/custom_snackbar.dart';
import '../../selesction_screen/selection_screen.dart';

class ForgetPasswordController extends ChangeNotifier {
  Future resetPassword(String email, BuildContext context) async {
    try {
      print("Sending email to " + email);
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateVerifyIdentityView(
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
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => BottomNavigationScreen(selectedIndex: 0,
      //           // email: email.toString(),
      //           // from: 1,
      //         )));
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const SelectionScreen()));
      CustomSnackBar(true)
          .showInSnackBar("Verification email sent successfully", context);
    } catch (e) {
      print(e.toString());
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }
}
