import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';

class EventScanQrScreen extends StatefulWidget {
  const EventScanQrScreen({super.key});

  @override
  State<EventScanQrScreen> createState() => _EventScanQrScreenState();
}

class _EventScanQrScreenState extends State<EventScanQrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSizeBox(65.h),
            Center(
              child: Image(
                height: 80.sp,
                width: 80.sp,
                image: const AssetImage('assets/images/primary_icon.png'),
              ),
            ),
            CustomSizeBox(40.h),
            Image(
              height: 275.sp,
              width: 272.sp,
              image: const AssetImage('assets/images/qr_event_qr_screen.png'),
            ),
            CustomSizeBox(20.h),
            Text(
              "Scan Here",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800)),
            )
          ],
        ),
      ),
    );
  }
}
