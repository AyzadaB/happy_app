import 'package:flutter/material.dart';
import 'package:happy_app/core/src/src.dart';

class MomentsCard extends StatelessWidget {
  const MomentsCard({super.key});

  //// final double progress;
  // Значение от 0.0 до 1.0
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 130,
      child: Card(
        color: AppColors.backLevel2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            spacing: 8,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Moments: 0/100', style: AppTextStyles.title),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  //  value: progress,
                  minHeight: 12,
                  backgroundColor: AppColors.backLevel2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              Text(
                "There are no moments yet",
                style: AppTextStyles.bodyBold.copyWith(color: AppColors.grey1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
