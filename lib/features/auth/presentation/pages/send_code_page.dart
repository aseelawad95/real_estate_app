import 'package:flutter/material.dart';
import 'package:real_estate/features/auth/presentation/widgets/send_code_body.dart';

class SendCodePage extends StatelessWidget {
  const SendCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SendCodeBody()),
    );

  }
}