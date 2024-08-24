import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  textTheme: TextTheme(
      displaySmall: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        letterSpacing: .3,
        fontSize: 16,
      ),
      displayMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        letterSpacing: .3,
        fontSize: 16,
      ),
      labelSmall: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        letterSpacing: .3,
        fontSize: 16,
      )),
  scaffoldBackgroundColor: Colors.grey.shade300,
  primaryColor: Colors.grey.shade200,
  // backgroundColor: Colors.grey.shade300,
  colorScheme: ColorScheme.light(
      primary: const Color.fromARGB(255, 0, 0, 0),
      secondary: Colors.white,
      surface: Colors.grey.shade200,
      onPrimary: Colors.grey.shade700,
      onSecondary: Colors.grey.shade700,
      onSurface: Colors.grey.shade700,
      onError: Colors.redAccent),
);
