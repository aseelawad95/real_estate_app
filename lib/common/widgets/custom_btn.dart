import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn( {
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.textColor,
    this.icon, 
    this.borderRadius,
    this.fontSize,
  });

  final String text;
  final Function()? onTap;
  final double? width;
  final Color? color;
  final Color? textColor;
  final IconData? icon; 
  final double? borderRadius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: color ?? Colors.blueAccent,
         borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.bold,
            ),
            if (icon != null) ...[
              const SizedBox(width: 6),
              Icon(icon, color: textColor ?? Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}