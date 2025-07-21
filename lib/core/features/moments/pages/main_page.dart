import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/features/moments/pages/add_moment_page.dart';
import 'package:happy_app/core/features/moments/widgets/app_bar_widget.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/components/custom_add_button.dart';
import 'package:happy_app/core/src/components/quote_%D1%81ard.dart';
import 'package:happy_app/core/src/components/sorting_button.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B1B1B),
      appBar: AppBarWidget(title: 'My moments'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuoteCard(
              quote:
                  'The brightest moments are found in simple things: a smile, morning light, a warm cup of tea',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('Moments', style: AppTextStyles.titleBold),
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/camera.png', // Replace with your image path
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Take the Challenge',
                  style: AppTextStyles.titleBold,
                  textAlign: TextAlign.center,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 10,
                  ),
                  child: Text(
                    'Set a goal to take 100 photos of things/ moments that bring you joy, over the course of a year.',
                    style: AppTextStyles.footnote.copyWith(
                      color: AppColors.grey1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Center(
              child: CustomAddButton(
                title: 'Add the first moment',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMomentPage(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
      
          ],
        ),
      ),
    );
  }
}
