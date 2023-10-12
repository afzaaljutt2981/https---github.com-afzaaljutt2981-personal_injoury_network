import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_text_styles.dart';
import 'custom_sized_box.dart';

// ignore: must_be_immutable
class AuthenticationTextField extends StatefulWidget {
  AuthenticationTextField(
      {required this.hintText,
      required this.controller,
      required this.maxLines,
      required this.identityText,
      super.key});
  String identityText;
  String hintText;
  TextEditingController controller;
  int maxLines;
  @override
  State<AuthenticationTextField> createState() =>
      _AuthenticationTextFieldState();
}

class _AuthenticationTextFieldState extends State<AuthenticationTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.identityText,
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
            maxLines: widget.maxLines,
            controller: widget.controller,
            style: AppTextStyles.josefin(
              style: TextStyle(
                color: const Color(0xFF1F314A),
                fontSize: 15.sp,
              ),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.w),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                  color: const Color(0xFF1F314A).withOpacity(0.40),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
