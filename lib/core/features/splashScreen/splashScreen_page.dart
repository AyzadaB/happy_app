import 'package:flutter/material.dart';
import 'package:happy_app/core/features/onboarding/pages/onboarding_page1.dart';
import 'package:happy_app/core/features/onboarding/pages/onboarding_screen.dart';
import 'package:happy_app/core/theme/app_colors.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      body: Stack(
        children: [
          Positioned(
            top: 420,
            left: 180,
            child: Image.asset('assets/images/sms.png', fit: BoxFit.cover),
          ),
          Positioned(
            top: 128,
            left: -233,
            child: Image.asset(
              'assets/images/sms.png',
              width: 435,
              height: 391,
              alignment: Alignment.centerLeft,
              fit: BoxFit.cover,
            ),
          ),

          // Звезда в правом верхнем углу
          Positioned(
            top: 169,
            right: 140,
            child: Image.asset(
              'assets/images/star.png',
              width: 173,
              height: 173,
            ),
          ),
        ],
      ),
    );
  }
}
