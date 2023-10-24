import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:provider/provider.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../home/view/navigation_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final textFieldController =
      List.generate(13, (i) => TextEditingController(), growable: true);
  int index = 1;
  final controller = PageController(initialPage: 0);
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizeBox(40.h),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // if (index == 1) {
                      Navigator.pop(context);
                      // } else {
                      //   setState(() {
                      //     index--;
                      //   });
                      // }
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
                height: index == 2 ? 350.h : 320.h,
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
                    left: 10.w,
                    right: 10.w,
                    bottom: index == 3 ? 15.h : 30.h, //0.h,
                    top: index == 3
                        ? 15.h
                        : index == 2
                            ? 10.h
                            : 25.h),
                child: GetwhiteButton(
                  50.sp,
                  () async {
                    if (index == 1) {
                      if (textFieldController[0].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter first name");
                        return;
                      } else if (textFieldController[1].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter last name");
                        return;
                      } else if (textFieldController[2].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter company name");
                        return;
                      }
                      // else if (textFieldController[3].text.isEmpty) {
                      //   Functions.showSnackBar(
                      //       context, "please enter position or job");
                      //   return;
                      // }
                      else {
                        setState(() {
                          index = index + 1;
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }
                    } else if (index == 2) {
                      if (textFieldController[4].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter phone number");
                        return;
                      } else if (textFieldController[5].text.isEmpty ||
                          !(EmailValidator.validate(
                              textFieldController[5].text))) {
                        Functions.showSnackBar(
                            context, "please enter valid email");
                      } else if (textFieldController[7].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter location");
                        return;
                      } else if (textFieldController[9].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter your reference");
                        return;
                      } else {
                        setState(() {
                          index = index + 1;
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }
                    }
                    if (index == 3) {
                      if (textFieldController[10].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter user name");
                        return;
                      } else if (textFieldController[11].text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please enter password");
                        return;
                      } else if (textFieldController[12].text.isEmpty ||
                          (textFieldController[11].text !=
                              textFieldController[12].text)) {
                        Functions.showSnackBar(context,
                            "password and confirm password should be same");
                        return;
                      } else {
                        context.read<AuthController>().signup(context,
                            firstName: textFieldController[0].text,
                            lastName: textFieldController[1].text,
                            companyName: textFieldController[2].text,
                            website: textFieldController[3].text,
                            phone: textFieldController[4].text,
                            email: textFieldController[5].text,
                            position: textFieldController[6].text,
                            location: textFieldController[7].text,
                            password: textFieldController[8].text,
                            hobbies: textFieldController[9].text,
                            userName: textFieldController[10].text
                        );
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: widget,
                            type: PageTransitionType.leftToRight,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: BottomNavigationScreen(
                              selectedIndex: 0,
                            ),
                          ),
                        );
                      }
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
              index == 3
                  ? Center(
                      child: SizedBox(
                        width: 250.w,
                        child: Column(
                          children: [
                            Text(
                              'By click Save you are agree with ',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp)),
                            ),
                            CustomSizeBox(5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'our ',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp)),
                                ),
                                Text(
                                  'Terms and Condition ',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: const Color(0xFFF63636),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.sp)),
                                )
                              ],
                            ),
                            CustomSizeBox(20.h),
                          ],
                        ),
                        // child: Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: 'By click Save you are agree with \nour',
                        // style: AppTextStyles.josefin(
                        //     style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 10.sp)),
                        //       ),
                        //       TextSpan(
                        //           text: ' Terms and Condition',

                        //           style: AppTextStyles.josefin(
                        // style: TextStyle(
                        //     color: const Color(0xFFF63636),
                        //     fontWeight: FontWeight.w700,
                        //     fontSize: 10.sp))),
                        //     ],
                        //   ),
                        // ),
                      ),
                    )
                  : const SizedBox(),
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          textField(
              'First Name', 'Jon', 0, textFieldController[0], false, false),
          textField(
              'Last Name', 'Methon', 1, textFieldController[1], false, false),
          textField('Company', 'Enter Company name', 2, textFieldController[2],
              false, false),
          textField(
            'Position/Job',
            'Select here',
            3,
            textFieldController[3],
            true,
            false,
          ),
          CustomSizeBox(20.h)
        ],
      ),
    );
  }

  Widget process2() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          textField('Cell Phone', '+1 356 786 7865', 4, textFieldController[4],
              false, false,
              inputType: TextInputType.number),
          textField('Email', 'abc@gmail.com', 5, textFieldController[5], false,
              false),
          textField('Website (Optional)', 'Enter Website name', 6,
              textFieldController[6], false, false),
          textField(
            'Location',
            'Click here to enter',
            7,
            textFieldController[7],
            false,
            false,
          ),
          textField('Hobbies/Interests (Optional)', 'Click here to enter', 8,
              textFieldController[8], false, false),
          textField('What brings you here?', 'Connecting people?', 9,
              textFieldController[9], false, false),
          CustomSizeBox(20.h)
        ],
      ),
    );
    // return Column(
    //   children: [
    //     CustomSizeBox(10.h),
    //     Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(15.sp),
    //         color: Colors.white,
    //       ),
    //       child: Column(
    //         children: [
    //           AuthTextFieldClass(
    //             controller: textFieldController[4],
    //             hintText: 'Cellphone',
    //             last: 0,
    //             maxLines: 1,
    //           ),
    //           AuthTextFieldClass(
    //             controller: textFieldController[5],
    //             hintText: 'Email',
    //             last: 0,
    //             maxLines: 1,
    //           ),
    //           AuthTextFieldClass(
    //             controller: textFieldController[6],
    //             hintText: 'Location',
    //             last: 0,
    //             maxLines: 1,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               top: 13.h,
    //               left: 15.w,
    //               bottom: 3.h,
    //               right: 15.w,
    //             ),
    //             child: Column(
    //               children: [
    //                 Text(
    //                   'Describe what you look for in Networking events:',
    //                   style: AppTextStyles.josefin(
    //                     style: TextStyle(
    //                       color: const Color(0xFF1F314A).withOpacity(0.40),
    //                       fontSize: 11.sp,
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   height: 80.h,
    //                   decoration: BoxDecoration(
    //                     color: const Color(0xFFD9D9D9).withOpacity(0.35),
    //                     borderRadius: BorderRadius.circular(10.sp),
    //                   ),
    //                   child: AuthTextFieldClass(
    //                     controller: textFieldController[7],
    //                     hintText: ' ',
    //                     last: 0,
    //                     maxLines: 4,
    //                   ),
    //                 ),
    //                 CustomSizeBox(10.h)
    //               ],
    //             ),
    //           ),
    //           AuthTextFieldClass(
    //             controller: textFieldController[8],
    //             hintText: 'Hobbies/ Interests',
    //             last: 0,
    //             maxLines: 1,
    //           ),
    //           CustomSizeBox(20.h)
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }

  Widget process3() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          textField('Username', 'Enter username', 10, textFieldController[10],
              false, false),
          textField('Password', 'xxxxxxxxx', 11, textFieldController[11], false,
              hidePassword),
          textField('Confirm Password', 'xxxxxxxxx', 12,
              textFieldController[12], false, hideConfirmPassword),
          CustomSizeBox(20.h)
        ],
      ),
    );
    // return Column(
    //   children: [
    //     CustomSizeBox(10.h),
    //     Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(15.sp),
    //         color: Colors.white,
    //       ),
    //       child: Column(
    //         children: [
    //           AuthTextFieldClass(
    //             controller: textFieldController[9],
    //             hintText: 'Username',
    //             last: 0,
    //             maxLines: 1,
    //           ),
    //           AuthTextFieldClass(
    //             controller: textFieldController[10],
    //             hintText: 'Password',
    //             last: 0,
    //             maxLines: 1,
    //           ),
    //           AuthTextFieldClass(
    //             controller: textFieldController[11],
    //             hintText: 'Confirm Password',
    //             last: 0,
    //             maxLines: 1,
    //           ),
    //           CustomSizeBox(20.h),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }

  Widget textField(String identityText, String hintText, int index,
      TextEditingController controller, bool readOnly, bool obsecureTerxt,
      {TextInputType? inputType}) {
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
            keyboardType: inputType,
            obscureText: obsecureTerxt,
            readOnly: readOnly,
            controller: controller,
            style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400),
            ),
            decoration: InputDecoration(
              suffixIcon: index == 3
                  ? GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(14.sp),
                        child: Image(
                            width: 10.sp,
                            height: 10.sp,
                            image: const AssetImage(
                                'assets/images/arrow_down_signup.png')),
                      ))
                  : index == 11
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: hidePassword
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.grey,
                                ))
                      : index == 12
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              child: hideConfirmPassword
                                  ? const Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    ))
                          : null,
              contentPadding: EdgeInsets.only(
                  left: 10.w,
                  top: index == 3 || index == 12 || index == 11 ? 12.h : 0.h,
                  right: index == 3 ? 10.w : 5.w),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                  color: const Color(0xFF1F314A).withOpacity(0.31),
                  fontSize: 14.sp,
                ),
              ),
            ),
            textInputAction: index == 2 || index == 9 || index == 12
                ? TextInputAction.done
                : TextInputAction.next,
          ),
        ),
        CustomSizeBox(22.h)
      ],
    );
  }
}
