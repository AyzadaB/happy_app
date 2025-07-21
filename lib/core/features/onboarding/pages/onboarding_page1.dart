import 'package:flutter/material.dart';
import 'package:happy_app/core/features/onboarding/widgets/rating_widget.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';


class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_dialogShown) {
      _dialogShown = true;

      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            barrierLabel: '',
            backgroundColor: Colors.transparent,
            isDismissible: true,
            enableDrag: true,

            builder: (context) => Dialog(
              backgroundColor: Color.fromARGB(255, 197, 185, 185),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 270,
                height: 273,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ratingIcon.png',
                        width: 64,
                        height: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Rate the app',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Tap a star to rate. You can also leave a comment',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Divider(
                        endIndent: 0,
                        indent: 0,
                        thickness: 0.1,
                        color: Color(0xff3C3C43),
                      ),
                      RatingWidget(),
                      Divider(
                        endIndent: 0,
                        indent: 0,
                        thickness: 0.1,
                        color: Color(0xff3C3C43),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: AppTextStyles.ratingButton,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Submit',
                              style: AppTextStyles.ratingButton,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      });
    }
  }

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
              Text("Capture Your Joy", style: AppTextStyles.onbordingTitle),
              Image.asset(
                'assets/images/onboarding1.png',
                width: double.infinity,
                height: 500,
                fit: BoxFit.contain,
              ),
              Text(
                'Start a year-long journey to photograph 100 moments that bring you happiness. Relive the little things that make life bright',
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
                child: Text('Continue', style: AppTextStyles.titleBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
