import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/button/button_cubit.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/common/widgets/custom_textfield.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/responsiveExtension.dart';
import 'package:real_estate/features/auth/data/models/send_sode_model.dart';
import 'package:real_estate/features/auth/domain/usecase/sendCode.dart';
import 'package:real_estate/features/auth/presentation/pages/otp_password_page.dart';
import 'package:real_estate/service_locator.dart';

class SendCodeBody extends StatefulWidget {
  const SendCodeBody({super.key});

  @override
  State<SendCodeBody> createState() => _SendCodeBodyState();
}

class _SendCodeBodyState extends State<SendCodeBody> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonCubit(),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  OTPPasswordPage(email: emailController.text,)),
            );
          }
          if (state is ButtonFailureState) {
            var snackBar = SnackBar(content: Text(state.errorMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
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
                  child: Image.asset(
                    "assets/splash/splashHome.png",
                    color: Colors.white,
                    width: 30,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: context.h(16)),
                CustomText(
                  text: "Forgot Password",
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                SizedBox(height: context.h(8)),
                CustomText(
                  text: "Enter your email address to receive a reset link.",
                  color: AppColors.textColor,
                ),
                SizedBox(height: context.h(25)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "EMAIL ADDRESS",
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    CustomTextField(
                      height: 49,
                      width: 350,
                      isPassword: false,
                      controller: emailController,
                      icon: CupertinoIcons.mail,
                    ),
                  ],
                ),
                SizedBox(height: context.h(25)),
                _forgotButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BasicAppButton(
            width: 340,
            height: 49,
            title: 'Send Rest Link',
            onPressed: () {
              context.read<ButtonCubit>().excute(
                usecase: sl<SendCodeUseCase>(),
                params: SendCodeModel(
                  email: emailController.text,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
