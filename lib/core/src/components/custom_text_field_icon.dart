import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';
import 'package:intl/intl.dart'; // Датаны форматтоо үчүн импорттоңуз

class CustomTextFieldIcon extends StatefulWidget {
  final String labelText;
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? selectedDate;

  const CustomTextFieldIcon({
    super.key,
    required this.labelText,
    this.onDateSelected,
    this.initialDate,
    this.selectedDate,
  });

  @override
  State<CustomTextFieldIcon> createState() => _CustomTextFieldIconState();
}

class _CustomTextFieldIconState extends State<CustomTextFieldIcon> {
  late DateTime _displayDate;

  @override
  void initState() {
    super.initState();
    _displayDate = widget.selectedDate ?? widget.initialDate ?? DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedDate == null) {
        widget.onDateSelected?.call(_displayDate);
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomTextFieldIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate && widget.selectedDate != null) {
      _displayDate = widget.selectedDate!;
    } else if (widget.selectedDate == null && oldWidget.selectedDate != null) {
      _displayDate = DateTime.now();
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _displayDate,
      firstDate: DateTime(1990), // Эң эрте тандалуучу дата (Мисалы, 1990-жыл)
      lastDate: DateTime.now(), // <-- Бул жерди өзгөрттүк! Бүгүнкү күнгө чейин гана активдүү
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.ratingColor,
              onPrimary: Colors.white,
              surface: AppColors.backLevel2,
              onSurface: AppColors.primary,
            ),
            dialogBackgroundColor: AppColors.backLevel2,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _displayDate) {
      setState(() {
        _displayDate = picked;
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.backLevel1,
              border: Border.all(color: AppColors.grey3, width: 1.0),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd.MM.yyyy').format(_displayDate),
                  style: AppTextStyles.body.copyWith(color: AppColors.primary),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 15.0,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 14,
          top: -12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
            decoration: BoxDecoration(
              color: AppColors.backLevel1,
              borderRadius: BorderRadius.circular(6.0),
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