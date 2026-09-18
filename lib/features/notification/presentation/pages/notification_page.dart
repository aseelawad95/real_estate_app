import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/home/presentation/pages/root.dart';
import 'package:real_estate/features/notification/presentation/bloc/get_notification/get_notification_cubit.dart';
import 'package:real_estate/features/notification/presentation/widgets/error_view.dart';
import 'package:real_estate/features/notification/presentation/widgets/notification_card.dart';
import 'package:real_estate/features/notification/presentation/widgets/notification_empty_state.dart';
import 'package:real_estate/service_locator.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetNotificationCubit>()..getAllNotification(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Root()));
          }, icon: Icon(CupertinoIcons.arrow_left)),
                  backgroundColor: Colors.white,
          elevation: 0,
          title: CustomText(
            text: 'Notifications',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        body: BlocBuilder<GetNotificationCubit, GetNotificationState>(
          builder: (context, state) {
            if (state is GetNotificationLoading || state is GetNotificationInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetNotificationError) {
              return ErrorView(
                message: state.message,
                onRetry: () => context.read<GetNotificationCubit>().getAllNotification(),
              );
            }

            if (state is GetNotificationLoaded) {
              if (state.notification.isEmpty) {
                return const NotificationEmptyState();
              }

              return RefreshIndicator(
                onRefresh: () => context.read<GetNotificationCubit>().getAllNotification(),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: state.notification.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return NotificationCard(notification: state.notification[index]);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

