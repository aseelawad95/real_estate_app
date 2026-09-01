import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/button/button_cubit.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/common/widgets/custom_textfield.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/responsiveExtension.dart';
import 'package:real_estate/features/auth/data/models/verify_code_model.dart';
import 'package:real_estate/features/auth/domain/usecase/verify_code.dart';
import 'package:real_estate/service_locator.dart';

// ⚠️ Wire these up once the usecase exists.
// import 'package:real_estate/features/auth/data/models/reset_password_model.dart';
// import 'package:real_estate/features/auth/domain/usecase/reset_password.dart';
// import 'package:real_estate/features/auth/presentation/pages/login_page.dart';
// import 'package:real_estate/service_locator.dart';

class NewPasswordBody extends StatefulWidget {
  final String? email;
  final String? code;

  const NewPasswordBody({super.key, this.email, this.code});

  @override
  State<NewPasswordBody> createState() => _NewPasswordBodyState();
}

class _NewPasswordBodyState extends State<NewPasswordBody> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword(BuildContext context) {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar(context, 'Please fill in both fields');
      return;
    }

    if (newPassword.length < 8) {
      _showSnackBar(context, 'Password must be at least 8 characters');
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackBar(context, 'Passwords do not match');
      return;
    }

    context.read<ButtonCubit>().excute(
      usecase: sl<VerifyCodeUseCase>(),
      params: VerifyCodeModel(
        email: widget.email ?? '',
        code: widget.code ?? '',
        newPassword: newPassword,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (_) => const LoginPage()),
            //   (route) => false,
            // );
          }
          if (state is ButtonFailureState) {
            _showSnackBar(context, state.errorMessage);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.h(60)),
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.primaryColor,
                    ),
                    child: const Icon(
                      CupertinoIcons.lock_rotation,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(height: context.h(16)),
                  CustomText(
                    text: "Create New Password",
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  SizedBox(height: context.h(8)),
                  CustomText(
                    text: "Your new password must be different from previously used passwords.",
                    color: AppColors.textColor,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.h(25)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "NEW PASSWORD",
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      CustomTextField(
                        height: 49,
                        width: 350,
                        isPassword: true,
                        controller: newPasswordController,
                        icon: CupertinoIcons.lock,
                      ),
                    ],
                  ),
                  SizedBox(height: context.h(18)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "CONFIRM PASSWORD",
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      CustomTextField(
                        height: 49,
                        width: 350,
                        isPassword: true,
                        controller: confirmPasswordController,
                        icon: CupertinoIcons.lock,
                      ),
                    ],
                  ),
                  SizedBox(height: context.h(25)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BasicAppButton(
                      width: 340,
                      height: 49,
                      title: 'Reset Password',
                      onPressed: () => _handleResetPassword(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}