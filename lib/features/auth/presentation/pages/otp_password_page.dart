import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/features/auth/presentation/pages/send_code_page.dart';
import 'package:real_estate/features/auth/presentation/widgets/OTP_password_body.dart';

class OTPPasswordPage extends StatelessWidget {
  const OTPPasswordPage({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SendCodePage()));
        }, icon: Icon(CupertinoIcons.arrow_left)),
      ),
      body: OTPasswordBody(),
    );
  }
}