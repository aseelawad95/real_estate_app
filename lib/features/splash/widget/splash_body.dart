import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashPageBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/splash/splash3.jpeg",
          fit: BoxFit.cover,
        ),

        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),  
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                 
                    const SizedBox(height: 16),
                      CustomText(text: "TerraStone",
                       fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                         letterSpacing: 1.5,
                          textAlign: TextAlign.center,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black45,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                     const SizedBox(height: 10),
                      CustomText(text: "FIND YOUR PLACE IN THE WORLD",
                       fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                         letterSpacing: 1,
                          textAlign: TextAlign.center,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black45,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}