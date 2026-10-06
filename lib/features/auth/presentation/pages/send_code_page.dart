import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/features/auth/presentation/pages/login_page.dart';
import 'package:real_estate/features/auth/presentation/widgets/send_code_body.dart';

class SendCodePage extends StatelessWidget {
  const SendCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
        }, icon: Icon(CupertinoIcons.arrow_left)),
      ),
      body: SafeArea(child: SendCodeBody()),
    );

  }
}