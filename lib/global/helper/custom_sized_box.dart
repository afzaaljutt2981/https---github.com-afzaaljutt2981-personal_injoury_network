
import 'package:flutter/material.dart';

class CustomSizeBox extends StatefulWidget {
  final double height;
  const CustomSizeBox(this.height);

  @override
  _CustomSizeBoxState createState() => _CustomSizeBoxState();
}

class _CustomSizeBoxState extends State<CustomSizeBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
    );
  }
}