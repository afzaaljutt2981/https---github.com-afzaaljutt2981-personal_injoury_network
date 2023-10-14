import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizeBox(40.h),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kPrimaryColor,
                size: 18.sp,
              ),
            ),
            CustomSizeBox(25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Text(
                  'The Creative Coffee Talks Club',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 110.h,
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
                          reverseDuration: const Duration(milliseconds: 200),
                          child: const OtherUserProfileScreen(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 90.sp,
                          width: 90.sp,
                          decoration: BoxDecoration(
                              color: const Color(0xFF635FF6).withOpacity(0.02),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(12.sp),
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
                            'Afzaal Afzaal afzaaluy',
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
