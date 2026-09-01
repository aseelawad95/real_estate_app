import 'package:flutter/material.dart';

import 'package:real_estate/features/auth/presentation/widgets/signup_body.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SignupBody()
      ),
    );
  }
}