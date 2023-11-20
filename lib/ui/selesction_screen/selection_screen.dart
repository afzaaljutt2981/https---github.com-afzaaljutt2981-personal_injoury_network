import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/ui/home/view/navigation_view.dart';

import '../authentication/view/create_auth_view.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(color: Colors.white, height: screenHeight),
        Positioned(
          top: 0,
          child: SizedBox(
            width: screenWidth,
            height: screenHeight * 0.72,
            child: const Image(
              image: AssetImage('assets/images/intro_background_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: screenHeight * 0.3,
            child: SizedBox(
              width: screenWidth,
              child: Text(
                "Let's Get",
                textAlign: TextAlign.center,
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600)),
              ),
            )),
        Positioned(
            top: (screenHeight * 0.3) + 30,
            child: SizedBox(
              width: screenWidth,
              child: Text(
                "Connected!",
                textAlign: TextAlign.center,
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600)),
              ),
            )),
        Positioned(
          bottom: 0,
          child: Container(
            height: screenHeight * 0.33,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.sp),
                  topRight: Radius.circular(35.sp),
                )),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomSizeBox(25.h),
                  Image(
                    image:
                        const AssetImage('assets/images/intro_screen_logo.png'),
                    height: 80.sp,
                    width: 80.sp,
                  ),
                  CustomSizeBox(10.h),
                  // Text('Let’s get Started to get amazing features',
                  //     style: GoogleFonts.poppins(
                  //         color: Colors.black.withOpacity(0.56),
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 13.sp)),
                  CustomSizeBox(40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.sp),
                    child: GetButton(50.h, () {
                      Navigator.pop(context);
                      if (FirebaseAuth.instance.currentUser == null) {
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: widget,
                            type: PageTransitionType.rightToLeft,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: const CreateAuthenticationView(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: widget,
                            type: PageTransitionType.rightToLeft,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: BottomNavigationScreen(
                              selectedIndex: 0,
                            ),
                          ),
                        );
                      }
                    },
                        Text(
                          "Get Started",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600)),
                        )),
                  ),
                  CustomSizeBox(10.h),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
