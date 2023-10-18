import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// ignore: must_be_immutable
class GetwhiteButton extends StatelessWidget {
  double height;
  final VoidCallback onTap;
  Widget? buttonText;
  GetwhiteButton(this.height, this.onTap, this.buttonText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlackColor.withOpacity(0.2),
                offset: const Offset(0, 1.5),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
            color: Colors.white),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
             splashFactory: NoSplash.splashFactory,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: onTap,
          child: buttonText,
        ));
  }
}
