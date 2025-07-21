import 'package:flutter/material.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/theme/theme.dart';

class ActiveCards extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final void Function(TaskModel task) onPressed;
  final TaskModel task;

  const ActiveCards({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 346,
      height: 200,
      child: Card(
        color: AppColors.backLevel2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imagePath,
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.bodyBold),
                        const SizedBox(height: 8),
                        Text(description, style: AppTextStyles.footnote),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => onPressed(task),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(319, 48),
                  backgroundColor: AppColors.accentPrymary,
                ),
                child: Text('Done', style: AppTextStyles.titleBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
