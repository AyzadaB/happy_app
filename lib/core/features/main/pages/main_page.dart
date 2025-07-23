import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/features/analytics/pages/analytics_page.dart';
import 'package:happy_app/core/features/moments/pages/home_page.dart';
import 'package:happy_app/core/features/settings/pages/settings_page.dart';
import 'package:happy_app/core/features/tasks/pages/tasks_page.dart';
import 'package:happy_app/core/src/src.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        children: [HomePage(), TasksPage(), AnalyticsPage(), SettingsPage()],
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
        backgroundColor: AppColors.backLevel1,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? AppColors.accentPrymary : AppColors.grey2,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Tasks',
            icon: SvgPicture.asset(
              'assets/icons/task.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? AppColors.accentPrymary : AppColors.grey2,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Analytics',
            icon: SvgPicture.asset(
              'assets/icons/analytics.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? AppColors.accentPrymary : AppColors.grey2,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? AppColors.accentPrymary : AppColors.grey2,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
