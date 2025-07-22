// lib/core/src/components/vertical_card.dart
import 'dart:io'; // File классы үчүн
import 'package:flutter/material.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart'; // MomentModel импорту
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';
import 'package:intl/intl.dart'; // AppTextStyles импорту

class VerticalCard extends StatelessWidget {
  final MomentModel moment; // MomentModel объектисин кабыл алабыз
  final VoidCallback? onTap; // Карточканы басканда иштөөчү callback

  const VerticalCard({
    super.key,
    required this.moment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Сүрөттү MomentModel'ден алуу логикасы
    Widget imageWidget;
    if (moment.imageFile != null) {
      imageWidget = Image.file(
        moment.imageFile!,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 90,
            height: 90,
            color: AppColors.grey2,
            child: Center(
              child: Icon(Icons.broken_image, color: AppColors.primary),
            ),
          );
        },
      );
    } else if (moment.imageAssetPath != null) {
      imageWidget = Image.asset(
        moment.imageAssetPath!,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 90,
            height: 90,
            color: AppColors.grey2,
            child: Center(
              child: Icon(Icons.broken_image, color: AppColors.primary),
            ),
          );
        },
      );
    } else {
      imageWidget = Container(
        width: 90,
        height: 90,
        color: AppColors.grey2,
        child: Center(
          child: Icon(Icons.no_photography, color: AppColors.primary),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap, // Карточканы басканда callback'ти чакырабыз
      child: Container(
        width: double.infinity, // Туурасын толук алат
        height: 120, // Бийиктигин белгилейбиз
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Горизонталдык жана вертикалдык аралык
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.backLevel1, // Фондун түсү backLevel2 болсун
          borderRadius: BorderRadius.circular(12.0), // Жалпы карточканын бурчтарын тегеректөө
        ),
        child: Row(
          children: [
            // Сол жактагы сүрөт
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0), // Сүрөт бурчтарын тегеректөө
              child: imageWidget,
            ),
            const SizedBox(width: 16.0), // Сүрөт менен тексттин ортосундагы боштук
            // Оң жактагы текст маалыматы
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Мазмунду вертикалдуу жайылтат
                children: [
                  Text(
                    moment.name, // MomentModel'ден title
                    style: AppTextStyles.body.copyWith(color: AppColors.primary), // AppTextStyles колдонуу
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd.MM.yyyy').format(moment.date), // MomentModel'ден date
                        style: AppTextStyles.footnote.copyWith(color: AppColors.grey2), // AppTextStyles колдонуу
                      ),
                      // Тег виджети
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: AppColors.backLevel3, // Тегдин фону backLevel2ге жакын болсун
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          moment.tag, // MomentModel'ден tag
                          style: AppTextStyles.caption.copyWith(color: AppColors.primary), // AppTextStyles колдонуу
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}