import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_text_styles.dart';
import 'custom_sized_box.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.index,
      required this.hintText,
      required this.obsecureTerxt,
      required this.identityText,
      required this.readOnly,
      this.inputType});

  String identityText;
  String hintText;
  int index;
  TextEditingController controller;
  bool readOnly;
  bool obsecureTerxt;
  TextInputType? inputType;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
            keyboardType: widget.inputType,
            obscureText: widget.obsecureTerxt,
            readOnly: widget.readOnly,
            controller: widget.controller,
            style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400),
            ),
            decoration: InputDecoration(
              suffixIcon: widget.index == 3
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
                  : widget.index == 11
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              // hidePassword = !hidePassword;
                            });
                          },
                          child: const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ))
                      : widget.index == 12
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  // hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              child: const Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ))
                          : null,
              contentPadding: EdgeInsets.only(
                  left: 10.w,
                  top: widget.index == 3 ||
                          widget.index == 12 ||
                          widget.index == 11
                      ? 12.h
                      : 0.h,
                  right: widget.index == 3 ? 10.w : 5.w),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                  color: const Color(0xFF1F314A).withOpacity(0.31),
                  fontSize: 14.sp,
                ),
              ),
            ),
            textInputAction:
                widget.index == 2 || widget.index == 9 || widget.index == 12
                    ? TextInputAction.done
                    : TextInputAction.next,
          ),
        ),
        CustomSizeBox(22.h)
      ],
    );
  }
}
