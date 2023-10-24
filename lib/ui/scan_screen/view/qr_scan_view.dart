import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

import '../../../global/helper/custom_sized_box.dart';

class HomeQrScanView extends StatefulWidget {
  const HomeQrScanView({super.key});

  @override
  State<HomeQrScanView> createState() => _HomeQrScanViewState();
}

class _HomeQrScanViewState extends State<HomeQrScanView> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSizeBox(65.h),
            Center(
              child: Image(
                height: 80.sp,
                width: 80.sp,
                image: const AssetImage('assets/images/primary_icon.png'),
              ),
            ),
            CustomSizeBox(20.h),
            // Stack
            Stack(
              children: [
                //  Container
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 45.h),
                    child: Container(
                      width: 290.w,
                      height: 300.h,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),

                      //  Container Data
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9, right: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomSizeBox(50.h),
                            Text(
                              "Isaac Anderson",
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600)),
                            ),
                            CustomSizeBox(5.h),
                            Text(
                              "Musician",
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                color: const Color(0xFFA1A1A1),
                                fontSize: 12.sp,
                              )),
                            ),
                            CustomSizeBox(35.h),
                            Image(
                              height: 150.sp,
                              width: 150.sp,
                              image: const AssetImage(
                                  'assets/images/qr_screen_blue.png'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: screenHeight * 0.01,
                    left: screenWidth * 0.38,
                    child: Image(
                      height: 80.sp,
                      width: 80.sp,
                      image: const AssetImage('assets/images/profile_pic.png'),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
