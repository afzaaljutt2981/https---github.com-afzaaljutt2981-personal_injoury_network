import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// ignore: must_be_immutable
class GetButton extends StatelessWidget {
  double height;
  final VoidCallback onTap;
  Widget? buttonText;
  GetButton(this.height, this.onTap, this.buttonText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
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
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF212E73), Color(0xFF3148C0)],
            )),
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
