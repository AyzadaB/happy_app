import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart'; // Сиздин AppColors импортуңуз

class CustomTextField extends StatefulWidget {
  final String labelText; 
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.maxLines = 1,
    
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Stack( // <-- TextField жана этикетканы үстү-үстүнө коюу үчүн Stack колдонобуз
      clipBehavior: Clip.none, // Балдарды Stack'тин чегинен чыгууга уруксат берет (этикетка үчүн)
      children: [
        SizedBox(
          width: double.infinity,
          child: TextField(
            controller: widget.controller,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
           maxLines: widget.maxLines, // <-- maxLines бул жерде колдонулат
            minLines: widget.maxLines == null ? 1 : null, // maxLines null болсо, minLines 1 болсун
            keyboardType: widget.maxLines == null ? TextInputType.multiline : TextInputType.text, // Көп сап болсо, клавиатураны өзгөртүү
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.body.copyWith(color: AppColors.grey2),
              filled: true,
              fillColor: AppColors.backLevel1, // Текст талаасынын ички фону
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              
              // Чек аралар сүрөттөгүгө окшош
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide(
                  color: AppColors.grey3, // Жука, ачык боз чек ара
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide(
                  color: AppColors.grey3,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide(
                  color: AppColors.grey3, // Фокусталганда да чек ара өзгөрбөйт
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),

        // "Name" этикеткасы, TextField'дин үстүнө жайгаштырылган
        Positioned(
          left: 14, // Сол жээктен бир аз аралык
          top: -12, // <-- Маанилүү: Жогорку чектен бир аз жогору чыгаруу
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0), // Padding'ди азайттым
            decoration: BoxDecoration(
              color: AppColors.backLevel1, // Же AppColors.black
              borderRadius: BorderRadius.circular(6.0), // Кичинекей тегеректелген бурчтар
            ),
            child: Text(
              widget.labelText,
              style: AppTextStyles.footnote.copyWith(color: AppColors.grey2),
            ),
          ),
        ),
      ],
    );
  }
}