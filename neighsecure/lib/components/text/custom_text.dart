import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String instruction;
  final double fontSize;
  //Color text
  final Color color;

  CustomText({super.key, required this.instruction, required this.fontSize, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      instruction,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}