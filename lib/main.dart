import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/auth/login/login_screen.dart';
import 'package:todo/ui/screens/auth/register/register_screen.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/screens/notification/notifi_service.dart';
import 'package:todo/ui/screens/splash/splash_screen.dart';
import 'package:todo/ui/utilities/app_theme.dart';

import 'ui/screens/edit/edit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  NotificationService().initNotification();

  /// to enable network with firestore
  //await FirebaseFirestore.instance.disableNetwork();

  runApp(ChangeNotifierProvider(
      create: (_) {
        return ListProvider();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeScreen.roueName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        EditScreen.routeName: (_) => EditScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
