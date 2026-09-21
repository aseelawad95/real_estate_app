import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.hintText = "Search...",
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grayColor),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grayColor),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grayColor),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(CupertinoIcons.search),
      ),
    );
  }
}