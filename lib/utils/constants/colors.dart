import 'package:flutter/material.dart';

class TColors {
  TColors._();

  //app basic colours
  static const Color primary = Colors.red;
  static const Color secondary = Color(0xFFffe248);
  static const Color accent = Color(0xFFff4b68);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4b68ff), Color(0xFF6c7570)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text colours
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6c7570);
  static const Color textWhite = Colors.white;

  //Background Colors
  static const Color light = Color(0xFFf6f6f6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFf3f5ff);

  //Background Container Colors
  static const Color lightContainer = Color(0xFFf6f6f6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  //Button Colors
  static const Color buttonPrimary = Colors.red;
  static const Color buttonSecondary = Color(0xFF6C7570);
  static const Color buttonDisabled = Color(0xFFc4c4c4);

  //Border Colors
  static const Color borderPrimary = Color(0xFFd9d9d9);
  static const Color borderSecondary = Color(0xFFe6e6e6);

  //Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388e3c);
  static const Color warning = Color(0xFFf57c00);
  static const Color info = Color(0xFF1976d2);

  //Neutral shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4f4f4f);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFe0e0e0);
  static const Color softGrey = Color(0xFFf4f4f4);
  static const Color lightGrey = Color(0xFFf9f9f9);
  static const Color white = Color(0xFFffffff);
}
