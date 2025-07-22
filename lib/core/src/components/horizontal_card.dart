
import 'package:flutter/material.dart';
import 'package:happy_app/core/src/src.dart';

class HorizontalCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String date;
  final String description;

  const HorizontalCard({
    super.key,
    required this.imageUrl,
    required this.tag,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Карточканын туурасын болжолдоп койдук
      decoration: BoxDecoration(
        color: AppColors.backLevel2, // Фондун кара түсү
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Мазмунга жараша бийиктикти алат
        crossAxisAlignment: CrossAxisAlignment.start, // Тексттер солго тегизделген
        children: [
          // Сүрөт жана жогорку иконалар үчүн Stack
          Stack(
            children: [
              ClipRRect( // Сүрөткө тегеректелген бурчтарды берүү үчүн
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                 
                ),
                child: Image.asset( // Image.network колдоно аласыз эгер URL болсо
                  imageUrl,
                  height: 300, // Сүрөттүн бийиктиги
                  width: double.infinity, // Туурасын толук алат
                  fit: BoxFit.cover, // Сүрөттү контейнерге толтурат
                ),
              ),
              // Жогорку сол жактагы 3 чекит иконасы
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Фондун жарым тунук кара түсү
                    shape: BoxShape.circle, // Тегерек форма
                  ),
                  child: const Icon(
                    Icons.more_horiz, // 3 чекит иконасы
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              // Жогорку оң жактагы X иконасы
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Фондун жарым тунук кара түсү
                    shape: BoxShape.circle, // Тегерек форма
                  ),
                  child: const Icon(
                    Icons.close, // X иконасы
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          // Төмөнкү текст маалыматы
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      // Эгер AppTextStyles колдонсоңуз: style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white)
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[400], // Сүрөттөгүгө окшош боз түс
                        fontSize: 14.0,
                      ),
                      // Эгер AppTextStyles колдонсоңуз: style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  // Эгер AppTextStyles колдонсоңуз: style: AppTextStyles.titleBold.copyWith(color: AppColors.white)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}