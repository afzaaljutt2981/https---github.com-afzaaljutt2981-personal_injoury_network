import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetGradientButton extends StatelessWidget {
  double height;
  final VoidCallback onTap;
  Widget? buttonText;

  GetGradientButton(this.height, this.onTap, this.buttonText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth,
        height: height,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.98, -0.22),
            end: Alignment(-0.98, 0.22),
            colors: [Color(0xFF212E73), Color(0xFF3047C0)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x1A306D8A),
              blurRadius: 30,
              offset: Offset(0, 16),
              spreadRadius: 0,
            )
          ],
        ),
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
