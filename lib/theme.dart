import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColors {
  static const lightestNavy = Color(0xFF2D446C);
  static const lightNavy = Color(0xFF233554);
  static const navy = Color(0xFF0A192F);
  static const neonCyan = Color(0xFF64FFDA);
  static const lightGrey = Color(0xFFEEEEEE);
  static const white = Color(0xFFE6F1FF);
}

class TextStyles {
  static final appTitle = GoogleFonts.staatliches(
    color: ThemeColors.white,
    fontSize: 40,
  );

  static final cardTitle = GoogleFonts.lato(
    color: ThemeColors.neonCyan,
    fontSize: 20,
  );

  static final cardSubtitle = GoogleFonts.lato(
    color: ThemeColors.lightGrey,
    fontSize: 16,
  );
}
