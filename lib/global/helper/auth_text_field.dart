import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_text_styles.dart';

// ignore: must_be_immutable
class AuthTextFieldClass extends StatefulWidget {
   AuthTextFieldClass({ required this.hintText, required this.controller, required this.maxLines, required this.last ,  super.key});
  String hintText;
  TextEditingController controller;
  int maxLines;
  int last;

  @override
  State<AuthTextFieldClass> createState() => _AuthTextFieldClassState();
}

class _AuthTextFieldClassState extends State<AuthTextFieldClass> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
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
        widget.last == 0
            ? Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[200],
              )
            : const SizedBox(),
      ],
    );
  }
}
