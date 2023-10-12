import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_text_styles.dart';

// ignore: must_be_immutable
class TextFieldClass extends StatelessWidget {
  TextEditingController? fieldController;
  bool obsecureText;
  String? hinText;
  TextInputType? keyboardType;
  String? Function(String?)? validate;
  // String? label;
  bool? editAble;
  Icon? icon;
  TextFieldClass({
    Key? key,
    this.fieldController,
    this.obsecureText = false,
    this.hinText,
    this.validate,
    this.keyboardType,
    this.editAble,
    this.icon,
    // this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      validator: validate,
      readOnly: editAble!,
      controller: fieldController,
      style: AppTextStyles.josefin(
          style:
              TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 17.sp)),
      decoration: InputDecoration(
        //  label: Text(label!),
        labelStyle: AppTextStyles.josefin(
          style:
              TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 13.sp),
        ),
        contentPadding: EdgeInsets.only(left: 15.sp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.sp)),
        hintText: hinText,
        prefixIcon: icon,
        hintStyle: AppTextStyles.josefin(
            style: TextStyle(
          letterSpacing: -0.41,
          color: Colors.black.withOpacity(0.4),
          fontSize: 17.sp,
        )),
      ),
    );
  }
}
