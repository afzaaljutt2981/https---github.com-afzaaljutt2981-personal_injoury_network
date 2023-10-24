import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';

class Functions{
  static showSnackBar(BuildContext context, String message, {Color? color}) {
    color ??= Colors.white;
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(
          color: AppColors.kPrimaryColor ,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static showLoaderDialog(BuildContext context, {String text = 'Loading'}) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [CircularProgressIndicator()],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}