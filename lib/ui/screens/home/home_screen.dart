import 'package:flutter/material.dart';
import 'package:todo/ui/utilites/app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const roueName = "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
    );
  }
}
