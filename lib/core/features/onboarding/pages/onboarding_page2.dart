import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

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
              Text("Track Your Progress", style: AppTextStyles.onbordingTitle),
              Image.asset(
                'assets/images/onboarding2.png',
                width: double.infinity,
                height: 500,
                fit: BoxFit.contain,
              ),
              Text(
                "Stay motivated with tasks designed to help you find and capture joyful moments throughout your year-long challenge",
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
                child: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
