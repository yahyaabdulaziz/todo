import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/screens/splash/splash_screen.dart';
import 'package:todo/ui/utilities/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.roueName: (_) => SplashScreen(),
        HomeScreen.roueName: (_) => HomeScreen(),
      },
      initialRoute: HomeScreen.roueName,
    );
  }
}
