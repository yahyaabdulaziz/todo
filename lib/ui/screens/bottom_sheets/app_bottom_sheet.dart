import 'package:flutter/material.dart';
import 'package:todo/ui/screens/widget/my_text_field.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class AppBotomSheet extends StatelessWidget {
  const AppBotomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      height: MediaQuery.of(context).size.height * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
          const SizedBox(
            height: 18,
          ),
          MyTextField(hintText: "Enter task title"),
          const SizedBox(
            height: 10,
          ),
          MyTextField(hintText: "Enter task description"),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Select date",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            "11/11/2023",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle
                .copyWith(fontWeight: FontWeight.normal, color: Colors.grey),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.primary),
              ),
              child: const Text(
                "add",
                style: AppTheme.appBarTextStyle,
              ))
        ],
      ),
    );
  }
}
