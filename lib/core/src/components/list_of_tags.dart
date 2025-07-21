// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class ListOfTags extends StatelessWidget {
  final Set<String> selectedTags; // Тандалган тегдердин тизмеси
  final ValueChanged<String> onTagSelected; // Тег басылганда чакырыла турган callback

  const ListOfTags({
    super.key,
    required this.selectedTags,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        _buildHashtagChip('#friends'),
        _buildHashtagChip('#family'),
        _buildHashtagChip('#nature'),
        _buildHashtagChip('#food'),
      ],
    );
  }

  Widget _buildHashtagChip(String text) {
    final isSelected = selectedTags.contains(text);

    return GestureDetector(
      onTap: () {
        onTagSelected(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentPrymary: AppColors.backLevel2, // Түстөр
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Text(
          text,
          style: AppTextStyles.footnote.copyWith(color: isSelected ? AppColors.primary : AppColors.primary),
        ),
      ),
    );
  }
}