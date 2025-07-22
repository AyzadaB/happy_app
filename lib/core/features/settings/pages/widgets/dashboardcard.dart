import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class DashboardCard extends StatelessWidget {
  final String label;
  final String image;

  const DashboardCard({required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.backLevel2,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // color: AppColors.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: AppTextStyles.body.copyWith(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                image,
                width: 61,
                height: 79,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
