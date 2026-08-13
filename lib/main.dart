import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/screens/home_screen.dart';
import 'package:groceries_app/screens/login_screen.dart';
import 'package:groceries_app/screens/splash_screen.dart';

void main() {
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MainApp(),
    // ),
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // HomeScreen(),
    );
  }
}
