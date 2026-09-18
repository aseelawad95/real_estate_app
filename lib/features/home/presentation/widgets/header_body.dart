import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/notification/presentation/widgets/notification_bell_icon.dart';

class HeaderBody extends StatelessWidget {
  const HeaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(CupertinoIcons.list_bullet,color: Colors.black,),
                CustomText(text: "EstateGold",color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 26,),
                NotificationBellIcon()
              ],
            );
  }
}