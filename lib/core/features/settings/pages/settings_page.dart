import 'package:flutter/material.dart';
import 'package:happy_app/core/features/settings/pages/widgets/dashboardcard.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Map<String, dynamic>> items = [
    {'image': 'assets/images/privacyPolicy.png', 'label': 'Privacy Policy'},
    {'image': 'assets/images/support.png', 'label': 'Support'},
    {'image': 'assets/images/share.png', 'label': 'Share'},
    {'image': 'assets/images/terms.png', 'label': 'Terms of use'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      appBar: AppBar(
        backgroundColor: AppColors.backLevel1,
        title: Text('Settings', style: AppTextStyles.titleBold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(), // фиксированная высота
          shrinkWrap: true,
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // две карточки в ряд
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return DashboardCard(label: item['label'], image: item['image']);
          },
        ),
      ),
    );
  }
}
