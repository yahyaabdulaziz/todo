import 'package:flutter/material.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/utilities/app_assets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, HomeScreen.roueName);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(AppAssets.splash,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center),
    );
  }
}
