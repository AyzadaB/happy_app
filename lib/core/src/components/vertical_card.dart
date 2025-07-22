import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';

class VerticalCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String tag;

  const VerticalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Туурасын толук алат
      height: 120, // Бийиктигин белгилейбиз
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.backLevel1,
      ),
      child: Row(
        children: [
          // Сол жактагы сүрөт
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0), // Сүрөт бурчтарын тегеректөө
            child: Image.asset( // Image.network колдоно аласыз эгер URL болсо
              imageUrl,
              width: 90, // Сүрөттүн туурасы
              height: 90, // Сүрөттүн бийиктиги
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0), // Сүрөт менен тексттин ортосундагы боштук
          // Оң жактагы текст маалыматы
          Expanded( // Калган орунду ээлейт
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Мазмунду вертикалдуу жайылтат
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2, // 2 саптан ашык болбошу үчүн
                  overflow: TextOverflow.ellipsis, // Ашып кетсе ... коет
                  // Эгер AppTextStyles колдонсоңуз: style: AppTextStyles.titleMedium.copyWith(color: AppColors.white)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Дата менен тегди эки тарапка жайгаштыруу
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[400], // Боз түс
                        fontSize: 14.0,
                      ),
                      // Эгер AppTextStyles колдонсоңуз: style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)
                    ),
                    // Тег виджети
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[800], // Тегдин фону
                        borderRadius: BorderRadius.circular(12.0), // Тегдин бурчтарын тегеректөө
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                        // Эгер AppTextStyles колдонсоңуз: style: AppTextStyles.tagStyle.copyWith(color: AppColors.white)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}