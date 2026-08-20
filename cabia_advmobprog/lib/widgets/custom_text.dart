import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
