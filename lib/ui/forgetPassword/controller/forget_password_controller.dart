

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../global/utils/custom_snackbar.dart';
import '../view/verify_identity.dart';

class ForgetPasswordController extends ChangeNotifier {
  Future resetPassword(String email, BuildContext context ) async {

    try {
      
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,

        
      );
      // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> VerifyIdentity(   email: email.toString(),)  )
                ); 
    } catch (e) {
    
      CustomSnackBar(false).showInSnackBar(e.toString(), context);
    }
  }
}
