import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/authentication/model/country_state_model.dart';
import 'package:personal_injury_networking/ui/home/view/navigation_view.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../global/utils/custom_snackbar.dart';
import '../../../global/utils/functions.dart';
import '../model/user_model.dart';

class AuthController extends ChangeNotifier {
  List<CountryStateModel> employesList = [];
  bool saveChangesButton = false;
  CollectionReference ref = FirebaseFirestore.instance.collection("users");
  UserModel? user;
  void signup(
    BuildContext context, {
    required String firstName,
    required String lastName,
    required String companyName,
    required String website,
    required String phone,
    required String email,
    required String position,
    required String location,
    required String password,
    required String reference,
    required List<String> hobbies,
    required String userName,
  }) {
    try {
      Functions.showLoaderDialog(context);
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((value) async {
        if (value.user != null) {
          var doc = ref.doc(FirebaseAuth.instance.currentUser!.uid);
          UserModel model = UserModel(
              id: doc.id,
              location: location,
              position: position,
              email: email,
              firstName: firstName,
              lastName: lastName,
              phone: int.parse(phone),
              company: companyName,
              reference: reference,
              userName: userName,
              website: website,
              userType: 'user',
              hobbies: hobbies,
              followers: [],
              followings: []);
          await doc.set(model.toJson());
          getUserData(context);
          setSaveChangesButtonStatus(false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
              (route) => false);
          notifyListeners();
        }
      });
    } on Exception catch (error) {
      setSaveChangesButtonStatus(false);
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      notifyListeners();
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      Functions.showLoaderDialog(context);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ref.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) async {
        if (value.exists) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          user = UserModel.fromJson(data);
          if (user != null) {
            Constants.userType = user!.userType;
            Constants.userName = user!.firstName;
            Constants.userPosition = user!.position;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
                (route) => false);
          }
        } else {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
          CustomSnackBar(false).showInSnackBar("Login Failed", context);
        }
      });
    } catch (e) {
      // Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar("Invalid Credentials", context);
     
    }
  }

  getUserData(context) {
    ref.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) async {
      if (value.exists) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        user = UserModel.fromJson(data);
        if (user != null) {
          Constants.userType = user!.userType;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
              (route) => false);
        }
      } else {
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pop();
        CustomSnackBar(false).showInSnackBar("Login Failed", context);
      }
    });
  }
  Future<void> updateUser(
      BuildContext context, {
        required String lastName,
        required String companyName,
        required String website,
        required String phone,
        required String position,
        required String location,
        required String reference,
        required List<String> hobbies,
        required String userName,
      }) async {
    try {
      Functions.showLoaderDialog(context);
          var doc = ref.doc(FirebaseAuth.instance.currentUser!.uid);
          await doc.update({
            "lastName": lastName,
            "company": companyName,
            "location": location,
            "phone": int.parse(phone),
            "website": website,
            "reference":reference,
            "userName": userName,
            "position": position,
            "hobbies":hobbies,
          });
          // ignore: use_build_context_synchronously
          getUserData(context);
          setSaveChangesButtonStatus(false);
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
                  (route) => false);
          notifyListeners();
    } on Exception catch (error) {
      setSaveChangesButtonStatus(false);
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      notifyListeners();
    }
  }
  setSaveChangesButtonStatus(bool value) {
    saveChangesButton = value;
    notifyListeners();
  }


  









   String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  // String sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }
late final FirebaseAuth firebaseAuth;
  // Future<User> signInWithApple() async {
   
  //   try {
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     print(appleCredential.authorizationCode);
      // final oauthCredential = OAuthProvider("apple.com").credential(
      //   idToken: appleCredential.identityToken,
      // );
      // final authResult =
      //     await firebaseAuth.signInWithCredential(oauthCredential);

  //     final displayName =
  //         '${appleCredential.givenName} ${appleCredential.familyName}';
  //     final userEmail = '${appleCredential.email}';

  //     final firebaseUser = authResult.user;
  //     print(displayName);
      

  //     return firebaseUser!;
  //   } catch (exception) {
  //     print(exception);
  //   }
  // }
}
