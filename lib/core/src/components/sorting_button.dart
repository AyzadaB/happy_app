import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class SortingButton extends StatelessWidget {
  final String title;
  final SvgPicture icon;
  final VoidCallback onTap; // Баскыч басылганда чакырыла турган функция

  const SortingButton({
    super.key,
    required this.onTap, required this.title, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // onTap ичинде берилген onPressed функциясын чакырабыз
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Ички боштук
        decoration: BoxDecoration(
          color: AppColors.backLevel2, // Фондун кара түсү
          borderRadius: BorderRadius.circular(40.0), // Абдан тегеректелген бурчтар
      
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Мазмунуна жараша орун алат
          children: [
            icon,
            const SizedBox(width: 8.0), // Икона менен тексттин ортосундагы боштук
             Text(
              title,
              style:AppTextStyles.footnote.copyWith(color: AppColors.primary),
              // Эгер AppTextStyles колдонсоңуз: style: AppTextStyles.bodyLarge.copyWith(color: AppColors.white)
            ),
          ],
        ),
      ),
    );
  }
}