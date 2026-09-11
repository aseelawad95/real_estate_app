import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(    
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
          // borderSide: BorderSide.none,
        ),
        hintText: "Search...",
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(CupertinoIcons.search),
      ),
    );
  }
}