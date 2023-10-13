import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/app_buttons/white_background_button.dart';
import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';

class VerifyIdentity extends StatefulWidget {
  const VerifyIdentity({super.key});

  @override
  State<VerifyIdentity> createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizeBox(40.h),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                  CustomSizeBox(20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Image(
                      height: 65.sp,
                      width: 65.sp,
                      image: const AssetImage(
                          'assets/images/peron_verify_identity.png'),
                    ),
                  ),
                  CustomSizeBox(20.h),
                  text('Verify your identity', FontWeight.w700, 24),
                  CustomSizeBox(10.h),
                  text('Password recovery link has been sent at your Email ',
                      FontWeight.w400, 14),
                  CustomSizeBox(30.h),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.h, horizontal: 17.w),
                      child: Row(
                        children: [
                          Image(
                            height: 20.sp,
                            width: 20.sp,
                            image: const AssetImage(
                                'assets/images/check_verify_identity.png'),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text('Email', FontWeight.w700, 16,
                                  color: AppColors.kPrimaryColor),
                              CustomSizeBox(7.h),
                              text('afzaal@gmail.com', FontWeight.w500, 12,
                                  color: const Color(0xFF6B7280)),
                            ],
                          )),
                          Image(
                            height: 25.sp,
                            width: 25.sp,
                            image: const AssetImage(
                                'assets/images/mail_verify_identity.png'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: GetwhiteButton(50.sp, () {
                //on Tap Function
              },
                  Text(
                    'Done',
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget text(String text, FontWeight weight, int size, {Color? color}) {
    return Text(
      text,
      style: AppTextStyles.josefin(
        style: TextStyle(
          // height: 1.1.sp,
          fontSize: size.sp,
          fontWeight: weight,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
