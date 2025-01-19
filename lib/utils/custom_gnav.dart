import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:orocomputer_system/utils/colors.dart';

class CustomGnav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomGnav({
    super.key,
    required this.onTabChange,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 35, 41, 41),
          boxShadow: [],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 500, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: AppColors.secondary,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: AppColors.primary,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.computer,
                  text: 'Add items',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: onTabChange,
            ),
          ),
        ),
      ),
    );
  }
}
