import 'package:flutter/material.dart';
import 'package:todo/ui/utilites/app_colors.dart';

abstract class AppTheme {
  static const TextStyle appBarTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white);

  static const TextStyle textTitleTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.primary);

  static const TextStyle taskDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 15, color: AppColors.lighBlack);

  static const TextStyle bottomSheetTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        titleTextStyle: appBarTextStyle),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 32),
        unselectedIconTheme: IconThemeData(size: 32),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey),
    scaffoldBackgroundColor: AppColors.accent,
  );
  static ThemeData darkTheme = ThemeData();
}
