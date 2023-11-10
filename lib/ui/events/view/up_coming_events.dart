import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';

class UpComingEvents extends StatefulWidget {
  const UpComingEvents({super.key});

  @override
  State<UpComingEvents> createState() => _UpComingEventsState();
}

class _UpComingEventsState extends State<UpComingEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSizeBox(70.h),
        Image(
          image: const AssetImage('assets/images/no_upcoming_ecents.png'),
          height: 250.sp,
          width: 250.sp,
        ),
      ],
    );
  }
}
