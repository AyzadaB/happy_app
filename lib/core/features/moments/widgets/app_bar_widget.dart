import 'package:flutter/material.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? customLeading; // Эми AppBar'дын 'leading' пропертиси катары берилет
  const AppBarWidget({
    super.key,
    required this.title,
    this.customLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backLevel1,
      leading: customLeading,
      title: Text(title, style: AppTextStyles.titleBold),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}