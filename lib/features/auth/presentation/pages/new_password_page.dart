import 'package:flutter/material.dart';
import 'package:real_estate/features/auth/presentation/widgets/new_password_body.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key, required this.code, required this.email});
  final String code;
  final String email;
  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: NewPasswordBody()),
    );
  }
}