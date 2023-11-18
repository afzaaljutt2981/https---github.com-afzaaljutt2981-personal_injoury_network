import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/authentication/model/country_state_model.dart';
import 'package:personal_injury_networking/ui/home/view/navigation_view.dart';

import '../../../global/utils/custom_snackbar.dart';
import '../../../global/utils/functions.dart';
import '../../forgetPassword/view/create_verify_identity_view.dart';
import '../../forgetPassword/view/verify_identity.dart';
import '../model/user_model.dart';

class AuthController extends ChangeNotifier {
  List<CountryStateModel> employesList = [];
  bool saveChangesButton = false;
  CollectionReference ref = FirebaseFirestore.instance.collection("users");
  UserModel? user;
  FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  Future<String?> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();
    String? token = await fMessaging.getToken();
    return token;
  }

  Future<void> signup(
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
  }) async {
    try {
      Functions.showLoaderDialog(context);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((value) async {
        if (value.user != null) {
          var doc = ref.doc(FirebaseAuth.instance.currentUser!.uid);
          String? token = await getFirebaseMessagingToken();
          UserModel model = UserModel(
              id: doc.id,
              location: location,
              position: position,
              email: email,
              firstName: firstName,
              lastName: lastName,
              fcmToken: token??"",
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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateVerifyIdentityView(
                        email: email.toString(),
                        from: 2,
                      )),
              (route) => false);
          notifyListeners();
        }
      });
    } on Exception catch (error) {
      Navigator.pop(context);
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
            if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
              Constants.userType = user?.userType ?? "";
              Constants.userName =
                  user?.firstName ?? "" + (user?.lastName ?? "");
              Constants.userPosition = user?.position ?? "";
              await updateUserToken(user!.id);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
                  (route) => false);
            } else {
              Constants.userType = user?.userType ?? "";
              Constants.userName =
                  user?.firstName ?? "" + (user?.lastName ?? "");
              Constants.userPosition = user?.position ?? "";
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CreateVerifyIdentityView(
                            email: "",
                            from: 2,
                          )),
                  (route) => false);
            }
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
          Constants.userType = user?.userType ?? "";
          await Navigator.pushAndRemoveUntil(
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
    required String firstName,
    required String lastName,
    required String companyName,
    required String email,
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
        "firstName": firstName,
        "lastName": lastName,
        "company": companyName,
        "email": email,
        "location": location,
        "phone": int.parse(phone),
        "website": website,
        "reference": reference,
        "userName": userName,
        "position": position,
        "hobbies": hobbies,
      });
      // ignore: use_build_context_synchronously
      getUserData(context);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
          (route) => false);
      notifyListeners();
    } on Exception catch (error) {
      // ignore: use_build_context_synchronously
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      notifyListeners();
    }
  }

  updateUserToken(String userId) async {
    String? token = await getFirebaseMessagingToken();
    if (token != null) {
     await ref.doc(userId).update({"fcmToken": token});
    }
  }
}
