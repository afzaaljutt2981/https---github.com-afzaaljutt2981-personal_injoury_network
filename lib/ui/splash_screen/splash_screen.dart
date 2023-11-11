import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/ui/authentication/view/sign_up_screen.dart';
import 'package:personal_injury_networking/ui/home/view/navigation_view.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:provider/provider.dart';

import '../../global/helper/custom_sized_box.dart';
import '../authentication/model/user_model.dart';
import '../selesction_screen/selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7)).then((value) async {
      if (FirebaseAuth.instance.currentUser != null) {
        await Provider.of<MyProfileController>(context, listen: false)
            .getUserData();
        getUserData();
        // ignore: use_build_context_synchronously
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const SelectionScreen()));
      }
    });
    // Timer(
    //     const Duration(seconds: 3),
    //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (BuildContext context) => const SelectionScreen())));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              height: 130.sp,
              width: 130.sp,
              image: const AssetImage('assets/images/logo_gif_final.gif'),
            ),
          ),
          CustomSizeBox(25.h),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              child: Text(
                'PERSONAL INJURY\n NETWORKING',
                textAlign: TextAlign.center,
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        height: 1.1.sp,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getUserData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      UserModel user = UserModel.fromJson(event.data() as Map<String, dynamic>);
      if (user.userName == "") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => SignUpScreen(
                      screenType: 1,
                      isUpdate: true,
                    )),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => BottomNavigationScreen(selectedIndex: 0)),
            (route) => false);
      }
    });
  }
}
