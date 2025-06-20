import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Lottie.asset(
            isDarkMode
                ? "assets/animations/booklub_splash_dark.json"
                : "assets/animations/booklub_splash_bright.json",
            fit: BoxFit.cover,
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
