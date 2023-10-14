import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';

import '../../../global/helper/auth_text_field.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../home/view/navigation_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = PageController(initialPage: 0);
  final textFieldController =
      List.generate(12, (i) => TextEditingController(), growable: true);
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizeBox(40.h),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (index == 1) {
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          index--;
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              CustomSizeBox(10.h),
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              CustomSizeBox(15.h),
              processStagesCount(index),
              CustomSizeBox(25.h),
              SizedBox(
                height: 330.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: PageView(
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      process1(),
                      process2(),
                      process3(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                  right: 30.w,
                  top: index == 1
                      ? 0.h
                      : index == 2
                          ? 40.h
                          : 30.h,
                ),
                child: GetwhiteButton(
                  50.sp,
                  () async {
                    if (index == 1) {
                      setState(() {
                        index = index + 1;
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    } else if (index == 2) {
                      setState(() {
                        index = index + 1;
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    }
                    if (index == 3 && textFieldController[9].text.isNotEmpty) {
                      Navigator.push(
                        context,
                        PageTransition(
                          childCurrent: widget,
                          type: PageTransitionType.leftToRight,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 200),
                          reverseDuration: const Duration(milliseconds: 200),
                          child:  BottomNavigationScreen(selectedIndex: 0,),
                        ),
                      );
                    }
                  },
                  Text(
                    index < 3 ? "Next" : "Save",
                    style: AppTextStyles.josefin(
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              CustomSizeBox(15.h),
            ],
          ),
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
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              "1",
              style: AppTextStyles.josefin(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
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
            color: index < 2 ? Colors.white : Colors.red,
          ),
          child: Center(
            child: Text(
              "2",
              style: AppTextStyles.josefin(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
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
            color: index < 3 ? Colors.white : Colors.red,
          ),
          child: Center(
            child: Text(
              "3",
              style: AppTextStyles.josefin(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        )
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: Colors.white,
          ),
          child: Column(
            children: [
              AuthTextFieldClass(
                controller: textFieldController[0],
                hintText: 'First Name',
                last: 0,
                maxLines: 1,
              ),
              AuthTextFieldClass(
                controller: textFieldController[1],
                hintText: 'Last Name',
                last: 0,
                maxLines: 1,
              ),
              AuthTextFieldClass(
                controller: textFieldController[2],
                hintText: 'Company',
                last: 0,
                maxLines: 1,
              ),
              AuthTextFieldClass(
                controller: textFieldController[3],
                hintText: 'Position/ Job',
                last: 1,
                maxLines: 1,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget process2() {
    return Column(
      children: [
        CustomSizeBox(10.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: Colors.white,
          ),
          child: Column(
            children: [
              AuthTextFieldClass(
                controller: textFieldController[4],
                hintText: 'Cellphone',
                last: 0,
                maxLines: 1,
              ),
              AuthTextFieldClass(
                controller: textFieldController[5],
                hintText: 'Email',
                last: 0,
                maxLines: 1,
              ),
              AuthTextFieldClass(
                controller: textFieldController[6],
                hintText: 'Location',
                last: 0,
                maxLines: 1,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 13.h,
                  left: 15.w,
                  bottom: 3.h,
                  right: 15.w,
                ),
                child: Column(
                  children: [
                    Text(
                      'Describe what you look for in Networking events:',
                      style: AppTextStyles.josefin(
                        style: TextStyle(
                          color: const Color(0xFF1F314A).withOpacity(0.40),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9).withOpacity(0.35),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: AuthTextFieldClass(
                        controller: textFieldController[7],
                        hintText: ' ',
                        last: 0,
                        maxLines: 4,
                      ),
                    ),
                    CustomSizeBox(10.h)
                  ],
                ),
              ),
              AuthTextFieldClass(
                controller: textFieldController[8],
                hintText: 'Hobbies/ Interests',
                last: 0,
                maxLines: 1,
              ),
              CustomSizeBox(20.h)
            ],
          ),
        )
      ],
    );
  }

  Widget process3() {
    return Column(
      children: [
        CustomSizeBox(10.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: Colors.white,
          ),
          child: Column(
            children: [
              AuthTextFieldClass(
                controller: textFieldController[9],
                hintText: 'Username',
                last: 0,
                maxLines: 1,
              ),
              AuthTextFieldClass(
                controller: textFieldController[10],
                hintText: 'Password',
                last: 0,
                maxLines: 1,
              ),
              AuthTextFieldClass(
                controller: textFieldController[11],
                hintText: 'Confirm Password',
                last: 0,
                maxLines: 1,
              ),
              CustomSizeBox(20.h),
            ],
          ),
        )
      ],
    );
  }
}



//   Future loader() async {
//     return Timer(
//         const Duration(seconds: 0),
//         () => showDialog(
//             context: context,
//             builder: (context) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }));
//   }
// }
