import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

// ignore: must_be_immutable
class CustomSnackBar extends StatelessWidget {
  bool okOperation = true;

  CustomSnackBar(this.okOperation, {super.key});

  void showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // ignore: non_constant_identifier_names
    var CustomSnackBar = SnackBar(
        backgroundColor: okOperation == true
            ? AppColors.kPrimaryColor
            : const Color.fromRGBO(255, 3, 3, 0.8),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: shortestSide > 600
                    ? MediaQuery.of(context).size.width - 48
                    : 300,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                    fontSize: shortestSide > 600 ? 10.sp : 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
                  textScaleFactor: 1,
                )),
          ],
        ));
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
