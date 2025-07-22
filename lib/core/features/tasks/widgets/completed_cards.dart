import 'package:flutter/material.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/theme/theme.dart';
import 'package:intl/intl.dart';

class CompletedCards extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final int? completedAt;
  final TaskModel task;
  const CompletedCards({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.completedAt,
    required this.task,
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
                        task.completedAt != null
                            ? ' ${DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(task.completedAt!))}'
                            : 'You have not completed any tasks yet.',
                        style: AppTextStyles.footnote.copyWith(
                          color: Color(0xff7CDC33),
                        ),
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
