import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.onTap,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.shadows,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Function()? onTap;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final List<Shadow>? shadows;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.clip,
        textScaler: TextScaler.linear(1.0),
        textAlign: textAlign,
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          shadows: shadows,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}