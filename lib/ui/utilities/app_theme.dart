import 'package:flutter/material.dart';
import 'package:todo/ui/utilities/app_colors.dart';

abstract class AppTheme {
  static const TextStyle appBarTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.white);

  static const TextStyle textTitleTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.primary);

  static const TextStyle doneTitleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: AppColors.selectedColor);

  static const TextStyle taskDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 15, color: AppColors.lighBlack);

  static const TextStyle doneDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 15,
      color: AppColors.selectedColor);

  static const TextStyle bottomSheetTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);

  static const TextStyle slidableTextStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 18, color: Colors.white);

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
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
      backgroundColor: AppColors.primary,
    ),
    scaffoldBackgroundColor: AppColors.accent,
    dividerTheme:
        const DividerThemeData(thickness: 4, color: AppColors.primary),
  );
  static ThemeData darkTheme = ThemeData();
}
