import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/ui/home/view/navigation_view.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:provider/provider.dart';

import '../../global/helper/custom_sized_box.dart';
import '../authentication/controller/auth_controller.dart';
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
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (FirebaseAuth.instance.currentUser != null) {
        await Provider.of<MyProfileController>(context, listen: false)
            .getUserData();

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                BottomNavigationScreen(selectedIndex: 0)));
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
              image: const AssetImage('assets/images/logo_gif.gif'),
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
}
