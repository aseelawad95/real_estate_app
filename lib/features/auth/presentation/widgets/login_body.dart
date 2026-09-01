import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/button/button_cubit.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/common/widgets/custom_textfield.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/responsiveExtension.dart';
import 'package:real_estate/features/auth/data/models/login_model.dart';
import 'package:real_estate/features/auth/domain/usecase/login.dart';
import 'package:real_estate/features/auth/presentation/pages/send_code_page.dart';
import 'package:real_estate/features/auth/presentation/pages/signup_page.dart';
import 'package:real_estate/features/auth/presentation/widgets/custom_toggle_tab.dart';
import 'package:real_estate/features/home/presentation/pages/root.dart';
import 'package:real_estate/service_locator.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SignUpPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonCubit(),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Root()),
            );
          }
          if (state is ButtonFailureState) {
            var snackBar = SnackBar(content: Text(state.errorMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor,
                  ),
                  child: Image.asset(
                    "assets/splash/splashHome.png",
                    color: AppColors.secondaryColor,
                    width: 30,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: context.h(16)),
                CustomText(
                  text: "Welcome to Excellence",
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                SizedBox(height: context.h(8)),
                CustomText(
                  text: "Manage your global real estate portfolio",
                  color: AppColors.textColor,
                ),
                SizedBox(height: context.h(25)),
                CustomToggleTabs(
                  onChanged: _onTabChanged,
                  initialIndex: 0,
                  firstText: "LOGIN",
                  secondText: "CREATE ACCOUNT",
                ),
                SizedBox(height: context.h(40)),
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
                SizedBox(height: context.h(16)),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SendCodePage()));
                            },
                            child: CustomText(
                              text: "PASSWORD",
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SendCodePage()));
                            },
                            child: CustomText(
                              text: "Forgot?",
                              color: AppColors.textAmber,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextField(
                      height: 49,
                      width: 350,
                      isPassword: true,
                      controller: passController,
                      icon: CupertinoIcons.lock,
                    ),
                  ],
                ),
                SizedBox(height: context.h(20)),
                _loginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: BasicAppButton(
            width: 340,
            height: 49,
            title: 'Login',
            onPressed: () {
              context.read<ButtonCubit>().excute(
                usecase: sl<LoginUseCase>(),
                params: LoginModel(
                  email: emailController.text,
                  password: passController.text,
                ),
              );
            },
          ),
        );
      },
    );
  }
}