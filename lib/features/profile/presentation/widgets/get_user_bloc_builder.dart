import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/features/profile/presentation/bloc/get_userby_id/get_userby_id_cubit.dart';
import 'package:real_estate/features/profile/presentation/widgets/profile_header.dart';


class GetUserBlocBuilderBody extends StatelessWidget {
  const GetUserBlocBuilderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserbyIdCubit, GetUserbyIdState>(
      builder: (context, state) {
        if (state is GetUserByIdLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetUserByIdError) {
          debugPrint('Error loading user data: ${state.message}');
          return SizedBox(
            height: 200,
            child: Center(
              child: CustomText(text: state.message, color: Colors.red),
            ),
          );
        }
        if (state is GetUserByIdLoaded) {
          final user = state.user;
          debugPrint('User data loaded: ${user.userName}, ${user.email}');
          return ProfileHeader(
            name: user.userName,
            email: user.email,
            // avatarUrl: 'https://i.pravatar.cc/150?img=47',
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
