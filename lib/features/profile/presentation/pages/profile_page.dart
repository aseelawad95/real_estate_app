import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/TokenHelper.dart';
import 'package:real_estate/features/profile/data/models/user_model.dart';
import 'package:real_estate/features/profile/presentation/bloc/editUser/edit_user_cubit.dart';
import 'package:real_estate/features/profile/presentation/bloc/get_userby_id/get_userby_id_cubit.dart';
import 'package:real_estate/features/profile/presentation/widgets/account_status_card.dart';
import 'package:real_estate/features/profile/presentation/widgets/edit_profile_card.dart';
import 'package:real_estate/features/profile/presentation/widgets/get_user_bloc_builder.dart';
import 'package:real_estate/features/profile/presentation/widgets/logout_button.dart';
import 'package:real_estate/features/profile/presentation/widgets/menu_card.dart';
import 'package:real_estate/service_locator.dart';

class Spacing {
  Spacing._();

  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
}

class RadiusOption {
  RadiusOption._();

  static const card = 20.0;
  static const field = 14.0;
  static const button = 30.0;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userId;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool isLoading = true;
  bool _isAccountActive = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await TokenHelper.getUserId();
    debugPrint("id :$id");
    setState(() {
      userId = id;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onLogout() {
    // TODO: hook up to your auth/session logic.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.thirdColor,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => sl<GetUserbyIdCubit>()..getUserById(userId!),
                  ),
                  BlocProvider(create: (_) => sl<EditUserCubit>()),
                ],
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<GetUserbyIdCubit, GetUserbyIdState>(
                      listener: (context, state) {
                        if (state is GetUserByIdLoaded) {
                          _nameController.text = state.user.userName;
                          _emailController.text = state.user.email;
                        }
                      },
                    ),
                    BlocListener<EditUserCubit, EditUserState>(
                      listener: (context, state) {
                        if (state is EditUserSuccess) {
                          context.read<GetUserbyIdCubit>().updateLocalUser(state.user.toEntity());

                        }
                      },
                    ),
                  ],
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.md,
                      vertical: Spacing.lg,
                    ),
                    children: [
                      const GetUserBlocBuilderBody(),
                      const SizedBox(height: Spacing.lg),
                      Builder(
                        builder: (context) {
                          return EditProfileCard(
                            userId: userId!,
                            nameController: _nameController,
                            emailController: _emailController,
                            onUpdate: () {
                              context.read<EditUserCubit>().editUser(
                                userId!,
                                UserModel(
                                  id: userId!,
                                  userName: _nameController.text,
                                  email: _emailController.text,
                                  phoneNumber: "",
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: Spacing.md),
                      AccountStatusCard(
                        isActive: _isAccountActive,
                        onChanged: (value) =>
                            setState(() => _isAccountActive = value),
                      ),
                      const SizedBox(height: Spacing.md),
                      const MenuCard(
                        icon: Icons.location_on_outlined,
                        label: 'Saved Addresses',
                      ),
                      const SizedBox(height: Spacing.md),
                      const MenuCard(
                        icon: Icons.credit_card_outlined,
                        label: 'Payment Methods',
                      ),
                      const SizedBox(height: Spacing.md),
                      const MenuCard(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                      ),
                      const SizedBox(height: Spacing.md),
                      LogoutButton(onTap: _onLogout),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}