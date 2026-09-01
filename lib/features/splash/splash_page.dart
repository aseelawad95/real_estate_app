// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:real_estate/features/home/presentation/pages/root.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:real_estate/features/auth/presentation/pages/signup_page.dart';
import 'package:real_estate/features/splash/widget/splash_body.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    excutNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashPageBody());
  }

  Future<void> excutNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final isLoggedIn = token != null && token.isNotEmpty;

    if (isLoggedIn) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Root()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignUpPage()),
      );
    }
  }
}