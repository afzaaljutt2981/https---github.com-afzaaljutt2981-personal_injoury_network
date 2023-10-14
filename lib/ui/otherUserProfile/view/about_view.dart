import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

class OrgnaizerAbout extends StatefulWidget {
  const OrgnaizerAbout({super.key});

  @override
  State<OrgnaizerAbout> createState() => _OrgnaizerAboutState();
}

class _OrgnaizerAboutState extends State<OrgnaizerAbout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      // child: Text(
      //   'Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.',
      //   style: AppTextStyles.josefin(
      //       style: TextStyle(fontSize: 13.sp, height: 1.5.h)),
      // ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('Company', FontWeight.w600),
            text('Fiverr LLC', FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Job/Position', FontWeight.w600),
            text('Manager', FontWeight.w600, color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Email', FontWeight.w600),
            text('www.xyz@gmail.com ', FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Website', FontWeight.w600),
            text('www.xyz.com ', FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Cellphone', FontWeight.w600),
            text('+1 234 456 5435 ', FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Hobbies', FontWeight.w600),
            text('www.xyz@gmail.com', FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
          ],
        ),
      ),
    );
  }

  Widget text(String text, FontWeight weight, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Text(
        text,
        style: AppTextStyles.josefin(
            style: TextStyle(
                fontSize: 12.sp,
                color: color ?? const Color(0xFF1A1167),
                fontWeight: weight)),
      ),
    );
  }
}
