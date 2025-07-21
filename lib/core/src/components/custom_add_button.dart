// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:happy_app/core/src/src.dart';

class CustomAddButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const CustomAddButton({
    super.key,
    required this.title, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentPrymary,
        foregroundColor: AppColors.primary,
        minimumSize: Size(260, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.titleBold,
      ),
    );
  }
}
