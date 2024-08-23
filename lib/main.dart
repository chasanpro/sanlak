import 'package:flutter/material.dart';
import 'package:sanlak/Screens/intro_screen.dart';
import 'package:sanlak/Screens/shop_page.dart';
import 'package:sanlak/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SanLak',
        theme: lightTheme,
        routes: {
          '/introScreen': (context) => const IntroScreen(),
          '/home': (context) => const HomeScreen(),
        },
        home: const IntroScreen());
  }
}
