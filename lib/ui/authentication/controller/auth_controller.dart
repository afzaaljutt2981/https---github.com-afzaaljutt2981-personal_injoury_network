import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/authentication/model/country_state_model.dart';
import 'package:personal_injury_networking/ui/home/view/navigation_view.dart';
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
              userType: 'user', hobbies: hobbies, followers: [], followings: []);
          await doc.set(model.toJson());
          getUserData(context);
          setSaveChangesButtonStatus(false);
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
      String email, String password,BuildContext context) async {
    try {
      Functions.showLoaderDialog(context);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ref
          .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) async {
        if(value.exists){
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          user = UserModel.fromJson(data);
          if(user != null){
            Constants.userType = user!.userType;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
                    (route) => false);
          }
        }else{
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
          CustomSnackBar(false).showInSnackBar("Login Failed", context);
        }
      });
    } catch (e) {
      // Navigator.pop(context);
      Navigator.pop(context);
      CustomSnackBar(false).showInSnackBar("Invalid Credentials", context);
      print(e.toString());
      print("error is here");
    }
  }

  getUserData(context) {
    ref
          .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) async {
            if(value.exists){
              Map<String, dynamic> data = value.data() as Map<String, dynamic>;
              user = UserModel.fromJson(data);
              if(user != null){
                Constants.userType = user!.userType;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
                        (route) => false);
              }
            }else{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              CustomSnackBar(false).showInSnackBar("Login Failed", context);
            }
      });
    }

  setSaveChangesButtonStatus(bool value) {
    saveChangesButton = value;
    notifyListeners();
  }
}
