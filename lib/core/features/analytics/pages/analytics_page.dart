import 'package:flutter/material.dart';
import 'package:happy_app/core/features/analytics/widgets/moments_card.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      appBar: AppBar(
        backgroundColor: AppColors.backLevel1,
        title: Text('Analytics', style: AppTextStyles.titleBold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MomentsCard(),
            SizedBox(height: 24),
            Image.asset('assets/images/progressIcon.png'),
          ],
        ),
      ),
    );
  }
}
