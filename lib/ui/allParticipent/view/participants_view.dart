import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_type.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../otherUserProfile/view/other_user_view.dart';

class AllParticipantsView extends StatefulWidget {
  const AllParticipantsView({super.key});

  @override
  State<AllParticipantsView> createState() => _AllParticipantsViewState();
}

class _AllParticipantsViewState extends State<AllParticipantsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          userType == 'user' ? Colors.white : const Color(0xFFF5F4FF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizeBox(userType == 'user' ? 40.h : 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.kPrimaryColor,
                    size: 18.sp,
                  ),
                ),
                userType == 'user'
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                        ),
                        child: Text(
                          'Registered Users',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF120D26),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
              ],
            ),
            CustomSizeBox(25.h),
            userType == 'user'
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'The Creative Coffee Talks Club',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          CustomSizeBox(10.h),
                          Text(
                            'Guest List',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: const Color(0xFF857FB4),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomSizeBox(25.h),
                      Text(
                        'No 0f Registered Users : 100',
                        textAlign: TextAlign.end,
                        style: AppTextStyles.josefin(
                          style: TextStyle(
                              color: const Color(0xFF7A86C3),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  ),
            Expanded(
              child: userType == 'user'
                  ? GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 15,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 120.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                childCurrent: widget,
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 200),
                                reverseDuration:
                                    const Duration(milliseconds: 200),
                                child: const OtherUserProfileScreen(),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 100.sp,
                                width: 100.sp,
                                decoration: const BoxDecoration(
                                    // color: Colors.red,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/bc_all_participants_screen.png'),
                                        fit: BoxFit.contain),
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: EdgeInsets.all(17.sp),
                                  child: const Image(
                                    image: AssetImage(
                                      'assets/images/profile_pic.png',
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Afzaal Afzaal ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      color: const Color(0xFF1A1167),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 12.w, right: 12.w, bottom: 10.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 15.h),
                              child: Row(children: [
                                Image(
                                    width: 40.sp,
                                    height: 40.sp,
                                    image: const AssetImage(
                                        'assets/images/profile_pic.png')),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amanda Johnthen',
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.kPrimaryColor,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    CustomSizeBox(5.h),
                                    Text(
                                      'Marketing Expert',
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: const Color(0xFF857FB4),
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
