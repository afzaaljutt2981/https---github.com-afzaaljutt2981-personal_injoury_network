import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/custom_snackbar.dart';
import '../../../global/utils/functions.dart';
import '../controller/forget_password_controller.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    emailController.text = '';
    super.initState();
  }

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
              child: GetwhiteButton(50.sp, () async {
               if (emailController.text == ' '  || emailController.text.isEmpty) {
                  CustomSnackBar(false)
                      .showInSnackBar('Email field is empty!', context);
               }

               else {
                Functions.showLoaderDialog(context);
                bool isEmailValid = validateEmail(emailController.text);

                if (isEmailValid == false) {
                  Navigator.pop(context);
                  CustomSnackBar(false)
                      .showInSnackBar('Invalid email!', context);
                } else {
                  await context
                      .read<ForgetPasswordController>()
                      .resetPassword(emailController.text, context);
                }}
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

  bool validateEmail(String email) {
    String pattern =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
