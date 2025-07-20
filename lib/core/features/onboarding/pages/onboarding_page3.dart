import 'package:flutter/material.dart';
import 'package:happy_app/core/theme/app_colors.dart';
import 'package:happy_app/core/theme/app_theme.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Reflect and Grow", style: AppTextStyles.onbordingTitle),
              Image.asset(
                'assets/images/onboarding3.png',
                width: double.infinity,
                height: 500,
                fit: BoxFit.contain,
              ),
              Text(
                "Look back at your collection anytime to revisit happy memories and appreciate the beauty in your life’s journey",
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(256, 54),
                  backgroundColor: AppColors.accentPrymary,
                ),
                child: Text('Start', style: AppTextStyles.titleBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
