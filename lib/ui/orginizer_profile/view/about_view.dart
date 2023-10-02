import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

class OrgnaizerAbout extends StatefulWidget {
  const OrgnaizerAbout({super.key});

  @override
  State<OrgnaizerAbout> createState() => _OrgnaizerAboutState();
}

class _OrgnaizerAboutState extends State<OrgnaizerAbout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      child: Text(
        'Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.',
        style: AppTextStyles.josefin(
            style: TextStyle(fontSize: 13.sp, height: 1.5.h)),
      ),
    );
  }
}
