import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class QuoteCard extends StatelessWidget {
  final String quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0), // Контейнердин айланасына боштук
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0), // Ички боштук
      decoration: BoxDecoration(
        color: AppColors.backLevel3, // Текст талаасынын ички фону), // Фондун кара түсү
        borderRadius: BorderRadius.circular(24.0),
        
      ),
      child: Stack(
        clipBehavior: Clip.none, // Тышкы тырмакчалардын контейнерден чыгып кетишине уруксат берет
        children: [
          // Жогорку сол жактагы тырмакча
          Positioned(
            top: 3, // Контейнерден сыртка бир аз чыгып турушу үчүн
            left: -10, // Контейнерден сыртка бир аз чыгып турушу үчүн
            child: Text(
              '“',
              style: TextStyle(
                fontFamily: 'Georgia', // Тырмакчалар үчүн башка шрифт колдонулушу мүмкүн
                fontSize: 70, // Чоңураак размер
                color: Color(0xFFF24E1E), // Ачык кызгылт сары түс
                height: 0.8, // Саптардын ортосундагы боштукту азайтуу
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0), // Тексттин ички боштугу
            child: Text(
              quote,
              style: AppTextStyles.footnote.copyWith(color: AppColors.primary),
              textAlign: TextAlign.start,
            ),
          ),
          // Төмөнкү оң жактагы тырмакча
          Positioned(
            bottom: -40, // Контейнерден сыртка бир аз чыгып турушу үчүн
            right: 8, // Контейнерден сыртка бир аз чыгып турушу үчүн
            child: Text(
              '”',
              style: TextStyle(
                fontFamily: 'Georgia', // Тырмакчалар үчүн башка шрифт колдонулушу мүмкүн
                fontSize: 70, // Чоңураак размер
                color: Color(0xFFF24E1E), // Ачык кызгылт сары түс
                height: 0.8, // Саптардын ортосундагы боштукту азайтуу
              ),
            ),
          ),
        ],
      ),
    );
  }
}