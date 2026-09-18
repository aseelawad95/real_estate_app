import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/notification/presentation/bloc/get_notification/get_notification_cubit.dart';
import 'package:real_estate/features/notification/presentation/pages/notification_page.dart';
import 'package:real_estate/service_locator.dart';

class NotificationBellIcon extends StatelessWidget {
  const NotificationBellIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetNotificationCubit>()..getAllNotification(),
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
            child: BlocBuilder<GetNotificationCubit, GetNotificationState>(
              builder: (context, state) {
                final unreadCount = state is GetNotificationLoaded
                    ? state.notification.where((n) => !n.isRead).length
                    : 0;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(CupertinoIcons.bell, color: Colors.black),
                    if (unreadCount > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          decoration: BoxDecoration(
                            color: AppColors.dangerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: CustomText(
                            text: unreadCount > 9 ? '9+' : '$unreadCount',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}