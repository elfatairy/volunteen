import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      fontFamily: GoogleFonts.cairo().fontFamily,
    ),
  };
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
