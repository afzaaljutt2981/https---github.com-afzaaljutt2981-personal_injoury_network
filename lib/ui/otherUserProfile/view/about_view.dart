import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

import '../../authentication/model/user_model.dart';

// ignore: must_be_immutable
class OrganizerAbout extends StatelessWidget {
  OrganizerAbout({super.key, required this.user});

  UserModel user;

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
            text(user?.company ?? "", FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Job/Position', FontWeight.w600),
            text(user.position ?? "", FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Email', FontWeight.w600),
            text(user.email ?? "", FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Website', FontWeight.w600),
            text(user.website ?? "", FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Cellphone', FontWeight.w600),
            text(user.phone.toString(), FontWeight.w600,
                color: AppColors.kLiteBlueColor),
            CustomSizeBox(9.h),
            text('Hobbies', FontWeight.w600),
            Row(
              children: [
                for (var e in user.hobbies ?? [])
                  text("$e,", FontWeight.w600, color: AppColors.kLiteBlueColor),
              ],
            ),
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
