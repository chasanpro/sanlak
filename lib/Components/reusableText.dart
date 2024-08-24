import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;

  const MyText(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: .3,
        fontSize: fontSize ?? 16,
      ),
    );
  }
}
