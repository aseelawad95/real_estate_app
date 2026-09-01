import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:real_estate/common/button/button_cubit.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/responsiveExtension.dart';
import 'package:real_estate/features/auth/presentation/pages/new_password_page.dart';

// ⚠️ Wire these up once the usecase exists.
// import 'package:real_estate/features/auth/data/models/verify_code_model.dart';
// import 'package:real_estate/features/auth/domain/usecase/verify_code.dart';
// import 'package:real_estate/service_locator.dart';

class OTPasswordBody extends StatefulWidget {
  final String? email;
  const OTPasswordBody({super.key, this.email = '',});

  @override
  State<OTPasswordBody> createState() => _OTPasswordBodyState();
}

class _OTPasswordBodyState extends State<OTPasswordBody> {
  static const int _otpLength = 4;
  final String code = '';
  late String _enteredCode;

  @override
  void initState() {
    super.initState();
    _enteredCode = '';
  }

  void _handleVerify(BuildContext context) {
    if (_enteredCode.length < _otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full code')),
      );
      return;
    }
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NewPasswordPage(code: code, email: widget.email!)));

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>  NewPasswordPage(code: _enteredCode,email: widget.email!,)),
            );
          }
          if (state is ButtonFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: Column(
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
                    child: const Icon(CupertinoIcons.lock_shield,
                        color: Colors.white, size: 28),
                  ),
                  SizedBox(height: context.h(16)),
                  CustomText(
                    text: 'OTP Verification',
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  SizedBox(height: context.h(8)),
                  CustomText(
                    text: widget.email!.isNotEmpty
                        ? 'Enter the code we sent to ${widget.email}'
                        : 'Enter the code we sent to your email.',
                    color: AppColors.textColor,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.h(30)),
                  Pinput(
                    length: _otpLength,
                    onChanged: (value) => _enteredCode = value,
                    onCompleted: (value) => _enteredCode = value,
                    defaultPinTheme: PinTheme(
                      width: 55,
                      height: 60,
                      textStyle: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: AppColors.textFieldColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.textColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 55,
                      height: 60,
                      textStyle: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: AppColors.textFieldColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: context.h(20)),
                  _ResendCountdown(
                    onResend: () {
                      // TODO: call the resend-code usecase here.
                    },
                  ),
                  SizedBox(height: context.h(25)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BasicAppButton(
                      width: 340,
                      height: 49,
                      title: 'Verify Code',
                      onPressed: () => _handleVerify(context),
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

class _ResendCountdown extends StatefulWidget {
  const _ResendCountdown({required this.onResend});
  final VoidCallback onResend;

  @override
  State<_ResendCountdown> createState() => _ResendCountdownState();
}

class _ResendCountdownState extends State<_ResendCountdown> {
  int _seconds = 60;

  @override
  void initState() {
    super.initState();
    _tick();
  }

  void _tick() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      if (_seconds > 0) {
        setState(() => _seconds--);
        _tick();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final canResend = _seconds == 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(text: "Didn't receive the code? ", color: AppColors.textColor, fontSize: 13),
        GestureDetector(
          onTap: canResend
              ? () {
                  widget.onResend();
                  setState(() => _seconds = 60);
                  _tick();
                }
              : null,
          child: CustomText(
            text: canResend ? 'Resend' : 'Resend in ${_seconds}s',
            color: canResend ? AppColors.primaryColor : AppColors.textColor.withOpacity(0.5),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}