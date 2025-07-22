// happy_app/core/src/components/custom_add_button.dart
import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class CustomAddButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? activeColor;   // Активдүү кездеги фон түсү
  final Color? disabledColor; // Активдүү эмес кездеги фон түсү
  final Color? activeTextColor; // Активдүү кездеги текст түсү
  final Color? disabledTextColor; // Активдүү эмес кездеги текст түсү

  const CustomAddButton({
    super.key,
    required this.title,
    this.onPressed,
    this.activeColor,
    this.disabledColor,
    this.activeTextColor,
    this.disabledTextColor,
  });

  @override
  Widget build(BuildContext context) {
    // Берилген пропертилер же дефолттук маанилер
    final Color currentActiveColor = activeColor ?? AppColors.accentPrymary; // Дефолт кызыл
    final Color currentDisabledColor = disabledColor ?? AppColors.error; // Дефолт ак/боз
    final Color currentActiveTextColor = activeTextColor ?? Colors.white; // Дефолт ак текст
    final Color currentDisabledTextColor = disabledTextColor ?? AppColors.grey2; // Дефолт боз текст

    return SizedBox(
      width: 260,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed == null ? currentDisabledColor : currentActiveColor,
          foregroundColor: onPressed == null ? currentDisabledTextColor : currentActiveTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          // Буларды да пропертилерге байласак болот, бирок азыркы учурда түздөн-түз колдонобуз
          disabledBackgroundColor: currentDisabledColor,
          disabledForegroundColor: currentDisabledTextColor,
        ),
        child: Text(
          title,
          style: AppTextStyles.bodyBold.copyWith(
            color: onPressed == null ? currentDisabledTextColor : currentActiveTextColor,
          ),
        ),
      ),
    );
  }
}