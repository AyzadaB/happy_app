import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

// Жаңы: Дата киргизүү үчүн өзүнчө виджет
class CustomTextFieldIcon extends StatefulWidget {
  final String labelText;
  final Function(DateTime)? onDateSelected;

  const CustomTextFieldIcon({
    super.key,
    required this.labelText,
    this.onDateSelected,
  });

  @override
  State<CustomTextFieldIcon> createState() => _CustomTextFieldIconState();
}

class _CustomTextFieldIconState extends State<CustomTextFieldIcon> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Виджет инициализацияланганда callback аркылуу бүгүнкү датаны жөнөтүү
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateSelected?.call(_selectedDate);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990), // Бүгүнкү күндөн баштап тандоого уруксат
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary:
                  Colors.black, // Мисалы, дата тандоочунун негизги түсү
              onPrimary: Colors.white,
              surface: AppColors.primary, // Фондук түс
              onSurface: Colors.black, // Тексттин түсү
            ),
            dialogBackgroundColor: AppColors.primary, // Диалогдун фону
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.blue, // Баскычтардын түсү (OK, CANCEL)
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
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
                  '${_selectedDate.day.toString().padLeft(2, '0')}.${_selectedDate.month.toString().padLeft(2, '0')}.${_selectedDate.year}',
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
