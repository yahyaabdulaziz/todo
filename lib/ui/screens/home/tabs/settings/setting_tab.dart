import 'package:flutter/material.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      color: AppColors.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Language",
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
          const SizedBox(
            height: 16,
          ),
          DropdownButton<String>(
            items: <String>['English', 'Arabic'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            "Mode",
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
          const SizedBox(
            height: 16,
          ),
          DropdownButton<String>(
            items: <String>['Light', 'Dark'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          )
        ],
      ),
    );
  }
}
