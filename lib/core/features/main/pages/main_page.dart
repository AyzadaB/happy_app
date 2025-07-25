import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/features/analytics/pages/analytics_page.dart';
import 'package:happy_app/core/features/main/logic/cubit/main_nav_cubit.dart';
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainNavCubit, MainNavState>(
      listener: (context, state) {
        _pageController.jumpToPage(state.currentIndex);
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backLevel1,
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<MainNavCubit>().updateIndex(index);
            },
            children: [
              HomePage(),
              TasksPage(),
              AnalyticsPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: AppColors.backLevel2,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    context.read<MainNavCubit>().updateIndex(index);
                  },
                  backgroundColor: AppColors.backLevel2,
                  selectedItemColor: AppColors.accentPrymary,
                  unselectedItemColor: AppColors.grey2,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,

                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 0
                              ? AppColors.accentPrymary
                              : AppColors.grey2,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Tasks',
                      icon: SvgPicture.asset(
                        'assets/icons/task.svg',

                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 1
                              ? AppColors.accentPrymary
                              : AppColors.grey2,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Analytics',
                      icon: SvgPicture.asset(
                        'assets/icons/analytics.svg',
                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 2
                              ? AppColors.accentPrymary
                              : AppColors.grey2,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Settings',
                      icon: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 3
                              ? AppColors.accentPrymary
                              : AppColors.grey2,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
