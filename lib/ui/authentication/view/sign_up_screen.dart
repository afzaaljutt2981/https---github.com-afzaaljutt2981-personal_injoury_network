import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';

import '../../../global/utils/app_text_styles.dart';
import '../../home/view/home_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final textFieldController =
      List.generate(12, (i) => TextEditingController(), growable: true);
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSizeBox(65.h),
            Center(
              child: Image(
                height: 90.sp,
                width: 90.sp,
                image: const AssetImage('assets/images/primary_icon.png'),
              ),
            ),
            CustomSizeBox(20.h),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.sp),
                child: Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          height: 1.1.sp,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              ),
            ),
            CustomSizeBox(15.h),
            processStagesCount(index),
            CustomSizeBox(25.h),
            index == 1
                ? process1()
                : index == 2
                    ? process2()
                    : process3(),
            index == 3
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 30.w, right: 30.w, top: index == 1 ? 80.h : 80.h),
                    child: GetwhiteButton(50.sp, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView()));
                    },
                        Text(
                          "Save",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 18.sp)),
                        )),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.w,
                  right: 30.w,
                  top: index == 1
                      ? 80.h
                      : index == 2
                          ? 40.h
                          : 30.h),
              child: GetwhiteButton(50.sp, () {
                if (index == 1) {
                  setState(() {
                    index = index + 1;
                  });
                } else if (index == 2) {
                  setState(() {
                    index++;
                  });
                }
              },
                  Text(
                    index < 3 ? "Next" : "QR Scan",
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: AppColors.kPrimaryColor, fontSize: 18.sp)),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget processStagesCount(index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20.sp,
          width: 20.sp,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Center(
            child: Text(
              "1",
              style: AppTextStyles.josefin(
                  style: TextStyle(color: Colors.white, fontSize: 11.sp)),
            ),
          ),
        ),
        Container(
          height: 1.5.sp,
          width: 60.sp,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.sp,
          width: 20.sp,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < 2 ? Colors.white : Colors.red),
          child: Center(
            child: Text(
              "2",
              style: AppTextStyles.josefin(
                  style: TextStyle(color: Colors.white, fontSize: 11.sp)),
            ),
          ),
        ),
        Container(
          height: 1.5.sp,
          width: 60.sp,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.sp,
          width: 20.sp,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < 3 ? Colors.white : Colors.red),
          child: Center(
            child: Text(
              "3",
              style: AppTextStyles.josefin(
                  style: TextStyle(color: Colors.white, fontSize: 11.sp)),
            ),
          ),
        )
      ],
    );
  }

  Widget textfield(String hintTest, TextEditingController controller,
      int maxLines, int last) {
    return Column(
      children: [
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          style: AppTextStyles.josefin(
              style:
                  TextStyle(color: const Color(0xFF1F314A), fontSize: 15.sp)),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.w),
              border: InputBorder.none,
              hintText: hintTest,
              hintStyle: AppTextStyles.josefin(
                  style: TextStyle(
                      color: const Color(0xFF1F314A).withOpacity(0.40),
                      fontSize: 14.sp))),
        ),
        last == 0
            ? Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[200],
              )
            : const SizedBox(),
      ],
    );
  }

  Widget process1() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                height: 85.sp,
                width: 85.sp,
                decoration: const BoxDecoration(shape: BoxShape.circle),
              ),
              Image(
                height: 75.sp,
                width: 75.sp,
                image: const AssetImage('assets/images/profile_pic.png'),
              ),
              Positioned(
                right: 0,
                top: 38.sp,
                child: Image(
                  height: 20.sp,
                  width: 20.sp,
                  image: const AssetImage('assets/images/edit_icon.png'),
                ),
              ),
            ],
          ),
        ),
        CustomSizeBox(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: Colors.white,
            ),
            child: Column(
              children: [
                textfield("First Name", textFieldController[0], 1, 0),
                textfield("Last Name", textFieldController[1], 1, 0),
                textfield("Company", textFieldController[2], 1, 0),
                textfield("Position/ Job", textFieldController[3], 1, 1),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget process2() {
    return Column(
      children: [
        CustomSizeBox(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: Colors.white,
            ),
            child: Column(
              children: [
                textfield("Cellphone", textFieldController[4], 1, 0),
                textfield("Email", textFieldController[5], 1, 0),
                textfield("Website", textFieldController[6], 1, 0),
                Padding(
                  padding: EdgeInsets.only(
                      top: 13.h, left: 15.w, bottom: 3.h, right: 15.w),
                  child: Column(
                    children: [
                      Text(
                        'Describe what you look for in Networking events:',
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color:
                                    const Color(0xFF1F314A).withOpacity(0.40),
                                fontSize: 11.sp)),
                      ),
                      Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9).withOpacity(0.35),
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: textfield('', textFieldController[7], 4, 0),
                      ),
                      CustomSizeBox(10.h)
                    ],
                  ),
                ),
                textfield("Hobbies/ Interests", textFieldController[8], 1, 0),
                CustomSizeBox(20.h)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget process3() {
    return Column(
      children: [
        CustomSizeBox(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: Colors.white,
            ),
            child: Column(
              children: [
                textfield("Username", textFieldController[9], 1, 0),
                textfield("Password", textFieldController[10], 1, 0),
                textfield("Confirm Password", textFieldController[11], 1, 0),
                CustomSizeBox(20.h),
              ],
            ),
          ),
        )
      ],
    );
  }
}
