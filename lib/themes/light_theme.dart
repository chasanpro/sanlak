import 'package:flutter/material.dart';

// ThemeData lightTheme = ThemeData(
//   scaffoldBackgroundColor: Colors.grey.shade300,
//   primaryColor: Colors.grey.shade300,

// );
class LigthMode {
  Color background = Colors.grey.shade300;
  Color primaryColor = Colors.grey.shade200;
  Color secondary = Colors.white;
  Color inverseColor = Colors.grey.shade700;
}

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade300,
  primaryColor: Colors.grey.shade200,
  // backgroundColor: Colors.grey.shade300,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade200,
    secondary: Colors.white,
    background: Colors.grey.shade300,
    surface: Colors.grey.shade200,
    onPrimary: Colors.grey.shade700,
    onSecondary: Colors.grey.shade700,
    onBackground: Colors.grey.shade700,
    onSurface: Colors.grey.shade700,
  ),
);
