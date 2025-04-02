import 'package:ar_flutter/modules/home/pages/home_page.dart';
import 'package:ar_flutter/modules/settings/pages/settings_page.dart';
import 'package:ar_flutter/themes/app_colors.dart';
import 'package:ar_flutter/utils/numeral.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainNavigatePage extends StatefulWidget {
  const MainNavigatePage({super.key});

  @override
  State<MainNavigatePage> createState() => _MainNavigatePageState();
}

class _MainNavigatePageState extends State<MainNavigatePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(_currentIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        unselectedItemColor: AppColors.lightGrey,
        curve: Curves.ease,
        items: [
          // Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: Text('home'.tr),
            selectedColor: AppColors.primaryBlue,
          ),
          // Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: Text('settings'.tr),
            selectedColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget getBody(int selectedIndex) {
    if (selectedIndex == Numeral.SCREEN_HOME) {
      return const HomePage();
    } else if (selectedIndex == Numeral.SCREEN_SETTINGS) {
      return const SettingsPage();
    } else {
      return const HomePage();
    }
  }
}
