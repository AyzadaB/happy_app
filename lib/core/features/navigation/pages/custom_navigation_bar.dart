import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/features/moments/pages/main_page.dart';
import 'package:happy_app/core/src/src.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          MainPage(),
        //   TaskPage(),
        //   AnalyticsPage(),
        //   SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset( 'assets/icons/home.svg',
              colorFilter: ColorFilter.mode(_currentIndex == 0 ? AppColors.accentPrymary : AppColors.grey2, BlendMode.srcIn),
            ),
          
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset( 'assets/icons/task.svg',
              colorFilter: ColorFilter.mode(_currentIndex == 1 ? AppColors.accentPrymary : AppColors.grey2, BlendMode.srcIn),
            )
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset( 'assets/icons/analytics.svg',
              colorFilter: ColorFilter.mode(_currentIndex == 2 ? AppColors.accentPrymary : AppColors.grey2, BlendMode.srcIn),
            )
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset( 'assets/icons/settings.svg',
              colorFilter: ColorFilter.mode(_currentIndex == 3 ? AppColors.accentPrymary : AppColors.grey2, BlendMode.srcIn),
            )
          ),
        ],
      ),
    );
  }
}
