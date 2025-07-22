import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/src/src.dart';

enum ViewMode { grid, list }

class IconToggleButton extends StatelessWidget {
  final ViewMode currentViewMode; // Учурдагы режимди сырттан алат
  final Function(ViewMode mode) onChanged; // Режим өзгөргөндө чакырыла турган callback

  const IconToggleButton({
    Key? key,
    required this.currentViewMode, // Талап кылынган параметр
    required this.onChanged,       // Талап кылынган параметр
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backLevel2,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            icon: SvgPicture.asset(
              'assets/icons/squares.svg',
              colorFilter: ColorFilter.mode(
                AppColors.primary,  // Тандалганда AppColors.primary, тандалбаганда AppColors.secondaryText (мисалы)
                BlendMode.srcIn,
              ),
              width: 30,
              height: 30,
            ),
            mode: ViewMode.grid,
            isSelected: currentViewMode == ViewMode.grid,
          ),
          _buildToggleButton(
            icon: SvgPicture.asset(
              'assets/icons/list.svg',
              colorFilter: ColorFilter.mode(
               AppColors.primary, // Тандалганда AppColors.primary, тандалбаганда AppColors.secondaryText (мисалы)
                BlendMode.srcIn,
              ),
              width: 30,
              height: 30,
            ),
            mode: ViewMode.list,
            isSelected: currentViewMode == ViewMode.list,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required Widget icon,
    required ViewMode mode,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        // Callback'ти чакырабыз, ата-энеге режим өзгөргөнүн билдиребиз
        onChanged(mode);
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentPrymary : AppColors.backLevel2,
          borderRadius: BorderRadius.circular(40.0), // Сүрөттө 40.0 окшойт
        ),
        child: icon,
      ),
    );
  }
}