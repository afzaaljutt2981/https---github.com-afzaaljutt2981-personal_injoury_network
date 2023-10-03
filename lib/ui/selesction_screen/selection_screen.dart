import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

import '../authentication/view/sign_up_screen.dart';

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
            height: screenHeight * 0.7,
            child: const Image(
              image: AssetImage('assets/images/intro_background_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: screenHeight * 0.3,
            left: screenWidth * 0.4,
            child: Text(
              "Text Here",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800)),
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
                  CustomSizeBox(20.h),
                  Image(
                    image:
                        const AssetImage('assets/images/intro_screen_logo.png'),
                    height: 70.sp,
                    width: 70.sp,
                  ),
                  CustomSizeBox(20.h),
                  Text(
                    'Look What Our Maids Can Do !!!.',
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp)),
                  ),
                  CustomSizeBox(40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.sp),
                    child: GetButton(50.h, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
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
