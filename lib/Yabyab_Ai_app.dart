import 'package:flutter/material.dart';
import 'package:yab_yab_ai/features/screens/splash_screen/splash_screen.dart';

class YabYabAiApp extends StatelessWidget {
  const YabYabAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
