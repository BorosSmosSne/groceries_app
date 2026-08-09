import 'package:flutter/material.dart';
import 'package:groceries_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isExpanded = false;

  _init() async {
    await Future.delayed(Duration(seconds: 1));
    // setState(() {});
    await Future.delayed(Duration(milliseconds: 2500));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedScale(
              scale: _isExpanded ? 1.5 : 1,
              duration: Duration(milliseconds: 500),
              child: Image.asset('assets/images/splash screen.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(child: CircularProgressIndicator.adaptive()),
          ),
        ],
      ),
    );
  }
}
