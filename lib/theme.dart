import 'package:flutter/material.dart';

class ThemeColors {
  static const lightestNavy = Color(0xFF2D446C);
  static const lightNavy = Color(0xFF233554);
  static const navy = Color(0xFF0A192F);
  static const neonCyan = Color(0xFF64FFDA);
  static const lightGrey = Color(0xFFEEEEEE);
  static const white = Color(0xFFE6F1FF);
}

class TextStyles {
  static const appTitle = TextStyle(color: ThemeColors.white, fontSize: 30);
  static const cardTitle = TextStyle(color: ThemeColors.neonCyan, fontSize: 20);
  static const cardSubtitle =
      TextStyle(color: ThemeColors.lightGrey, fontSize: 15);
}
