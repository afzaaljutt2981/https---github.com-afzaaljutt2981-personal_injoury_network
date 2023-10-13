import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/forgetPassword/view/verify_identity.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  TextEditingController emailController = TextEditingController();
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
                          'assets/images/lock_forget_password.png'),
                    ),
                  ),
                  CustomSizeBox(20.h),
                  text('Password Recovery', FontWeight.w700, 24),
                  CustomSizeBox(10.h),
                  text(
                      'Enter your registered email below to receive password instructions',
                      FontWeight.w400,
                      14),
                  CustomSizeBox(30.h),
                  textField('Email', 'Enter Email', emailController),
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: GetwhiteButton(50.sp, () {
                Navigator.push(
                  context,
                  PageTransition(
                    childCurrent: widget,
                    type: PageTransitionType.rightToLeft,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                    child: const VerifyIdentity(),
                  ),
                );
              },
                  Text(
                    'Send me email',
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

  Widget text(String text, FontWeight weight, int size) {
    return Text(
      text,
      style: AppTextStyles.josefin(
        style: TextStyle(
          // height: 1.1.sp,
          fontSize: size.sp,
          fontWeight: weight,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget textField(
    String identityText,
    String hintText,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          identityText,
          style: AppTextStyles.josefin(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500)),
        ),
        CustomSizeBox(5.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
          child: TextFormField(
            readOnly: false,
            textInputAction: TextInputAction.done,
            controller: controller,
            style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 10.w,
              ),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                  color: const Color(0xFF1F314A).withOpacity(0.31),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
