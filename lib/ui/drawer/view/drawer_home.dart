import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/allFriends/view/create_all_freinds_view.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/faq_screen/view/create_faq_screen.dart';
import 'package:personal_injury_networking/ui/find_users/view/create_find_users_view.dart';
import 'package:provider/provider.dart';

import '../../authentication/view/login_view.dart';
import '../../create_event/view/create_add_event_view.dart';
import '../../forgetPassword/view/create_forget_pass_controller.dart';
import '../../home/view/navigation_view.dart';
import '../../myProfile/controller/my_profile_controller.dart';

class MyDrawerHome extends StatefulWidget {
  const MyDrawerHome({super.key});

  @override
  State<MyDrawerHome> createState() => _MyDrawerHomeState();
}

class _MyDrawerHomeState extends State<MyDrawerHome> {
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    user = context.watch<MyProfileController>().user;
    return SafeArea(
      child: Scaffold(
        body: (user != null)
            ? Column(
                children: [
                  CustomSizeBox(50.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.sp),
                                bottomRight: Radius.circular(10.sp),
                              )),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 14.sp,
                                bottom: 14.sp,
                                left: 15.sp,
                                right: 35.sp),
                            child: Row(
                              children: [
                                if (user?.pImage == null) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    child: Image(
                                      height: 50.sp,
                                      width: 50.sp,
                                      image: const AssetImage(
                                          'assets/images/profile_pic.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ] else ...[
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      user?.pImage ?? "",
                                    ),
                                  ),
                                ],
                                SizedBox(
                                  width: 16.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user?.firstName ?? "",
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: AppColors.kBlackColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    CustomSizeBox(5.h),
                                    Text(
                                      user?.email ?? "",
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: const Color(0xFF27261E),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.normal)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35.w, right: 10.w),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image(
                            height: 30.sp,
                            width: 30.sp,
                            image: const AssetImage(
                                'assets/images/cancel_icon_drawer.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.w, top: 40.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        homeFeatures(
                                            'assets/images/home_icon_drawer.png',
                                            'Home', onTap: () {
                                          Navigator.pop(context);
                                        }),
                                        CustomSizeBox(28.h),
                                        user?.userType == 'user'
                                            ? homeFeatures(
                                                'assets/images/marketer_icon_drawer.png',
                                                'Become a Marketer',
                                                onTap: () async {
                                                String? res = await Functions()
                                                    .showConfirmDialogueBox(
                                                        context,
                                                        "You are going to become a marketer, Press continue to confirm");
                                                if (res != null) {
                                                  // ignore: use_build_context_synchronously
                                                  context
                                                      .read<
                                                          MyProfileController>()
                                                      .becomeMarketer();
                                                }
                                              })
                                            : homeFeatures(
                                                'assets/images/events_icon_drawer.png',
                                                'Create Event', onTap: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    childCurrent: widget,
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    alignment: Alignment.center,
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    reverseDuration:
                                                        const Duration(
                                                            milliseconds: 200),
                                                    child:
                                                        const CreateAddEventView(),
                                                  ),
                                                );
                                              }),
                                        CustomSizeBox(28.h),
                                        homeFeatures(
                                            'assets/images/events_icon_drawer.png',
                                            'Events', onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                childCurrent: widget,
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                alignment: Alignment.center,
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                reverseDuration: const Duration(
                                                    milliseconds: 200),
                                                child: BottomNavigationScreen(
                                                  selectedIndex: 3,
                                                )),
                                          );
                                        }),
                                        CustomSizeBox(28.h),
                                        homeFeatures(
                                            'assets/images/messages_icon_drawer.png',
                                            'Messages', onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                childCurrent: widget,
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                alignment: Alignment.center,
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                reverseDuration: const Duration(
                                                    milliseconds: 200),
                                                child: BottomNavigationScreen(
                                                  selectedIndex: 1,
                                                )),
                                          );
                                        }, showBatch: false),
                                        CustomSizeBox(28.h),
                                        homeFeatures(
                                            'assets/images/friends_icon_drawer.png',
                                            'Friends', onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              childCurrent: widget,
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              child: CreateAllFriendsView(
                                                user: user,
                                              ),
                                            ),
                                          );
                                        }),
                                        CustomSizeBox(28.h),
                                        homeFeatures(
                                            'assets/images/friends_icon_drawer.png',
                                            'Find People', onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              childCurrent: widget,
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              child: CreateFindUserView(
                                                user: user,
                                              ),
                                            ),
                                          );
                                        }),
                                        CustomSizeBox(28.h),
                                        homeFeatures(
                                            'assets/images/setting_icon_drawer.png',
                                            'Settings', onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              childCurrent: widget,
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              child: CreateForgetPasswordView(
                                                email: FirebaseAuth.instance
                                                        .currentUser?.email ??
                                                    "",
                                              ),
                                            ),
                                          );
                                        }),
                                        CustomSizeBox(28.h),
                                        homeFeatures(
                                            'assets/images/question_icon_drawer.png',
                                            'Helps & FAQs', onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              childCurrent: widget,
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              child: FaqScreenView(),
                                            ),
                                          );
                                        }),
                                        CustomSizeBox(28.h),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      Functions.showLoaderDialog(context);
                                      await FirebaseAuth.instance.signOut();
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const LoginView()),
                                          (route) => false);
                                    } catch (e) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 30.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFFFE613D)
                                                    .withOpacity(0.2),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 8.sp),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15.sp),
                                            color: const Color(0xFFD70E0E)
                                                .withOpacity(0.8)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 10.h),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.logout,
                                                color: Colors.white,
                                                size: 20.sp,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                "Logout",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 12.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, top: 10.h, bottom: 10.h),
                            child: const Image(
                                image: AssetImage(
                                    'assets/images/side_presentation_drawer.png')),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget homeFeatures(String image, String text,
      {required Function onTap, bool showBatch = false}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // showBatch
          //     ? badges.Badge(
          //         showBadge: ! (user?.showSimpleNotification ?? false),
          //         position: badges.BadgePosition.custom(
          //           end: 0,
          //         ),
          //         child: Image(
          //             height: 24.sp, width: 24.sp, image: AssetImage(image)))
          //     :
          Image(height: 24.sp, width: 24.sp, image: AssetImage(image)),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: AppTextStyles.josefin(
                style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            )),
          ),
        ],
      ),
    );
  }
}
