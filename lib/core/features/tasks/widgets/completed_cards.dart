import 'package:flutter/material.dart';
import 'package:happy_app/core/theme/theme.dart';
import 'package:intl/intl.dart';

class CompletedCards extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final int? completedAt;
  const CompletedCards({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.completedAt,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 346,
      height: 162,
      child: Card(
        color: AppColors.backLevel2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imagePath,
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        completedAt != null
                            ? DateFormat.yMMMd().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  completedAt!,
                                ),
                              )
                            : 'Not completed',
                        style: AppTextStyles.footnote,
                      ),
                      Text(title, style: AppTextStyles.bodyBold),
                      SizedBox(height: 10),
                      Text(description, style: AppTextStyles.footnote),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
