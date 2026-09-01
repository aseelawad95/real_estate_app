import 'package:flutter/material.dart';
import 'package:real_estate/features/auth/presentation/widgets/OTP_password_body.dart';

class OTPPasswordPage extends StatelessWidget {
  const OTPPasswordPage({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OTPasswordBody(),
    );
  }
}