import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';

class PastEvents extends StatefulWidget {
  const PastEvents({super.key});

  @override
  State<PastEvents> createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomSizeBox(60.h),
        Image(
            height: 150.sp,
            width: 150.sp,
            image: const AssetImage(
                'assets/images/no_history_orgnaizer_event.png')),
        CustomSizeBox(20.h),
        Text(
          'No Events History',
          style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF120D26),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
