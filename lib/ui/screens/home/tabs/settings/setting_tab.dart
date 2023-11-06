import 'package:flutter/material.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class SettingTab extends StatefulWidget {
  static const List<String> langDropdownValues = [
    "English",
    "Arabic",
  ];
  static const List<String> modeDropdownValues = [
    "Dark",
    "Light",
  ];

  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: AppColors.primary,
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text('Enter'),
                items: SettingTab.langDropdownValues
                    .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                    .toList(),
                onChanged: (_) {},
                isExpanded: true,
                value: 'English',
              ),
            ),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: AppColors.primary,
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text('Enter'),
                items: SettingTab.modeDropdownValues
                    .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                    .toList(),
                onChanged: (_) {},
                isExpanded: true,
                value: 'Dark',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
