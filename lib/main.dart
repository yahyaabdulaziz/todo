import 'package:flutter/material.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/screens/splash/splash_screen.dart';
import 'package:todo/ui/utilites/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: {
        SplashScreen.roueName: (_) => SplashScreen(),
        HomeScreen.roueName: (_) => HomeScreen(),
      },
      initialRoute: SplashScreen.roueName,
    );
  }
}
