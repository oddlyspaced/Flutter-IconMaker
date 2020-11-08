import 'package:flutter/material.dart';

class ThemeConstants {
  static final String primaryFontFamily = "Gelion";

  static final Color textPrimaryColor = Colors.white;
  static final Color iconBackground = Colors.black;

  static final TextStyle heading = TextStyle(
    fontSize: 36,
    color: ThemeConstants.textPrimaryColor,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle title = TextStyle(
    fontSize: 24,
    color: ThemeConstants.textPrimaryColor,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle subheading = TextStyle(
    fontSize: 18,
    color: ThemeConstants.textPrimaryColor,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle snackbar = TextStyle(
    fontSize: 18,
    fontFamily: primaryFontFamily,
    color: ThemeConstants.textPrimaryColor,
    fontWeight: FontWeight.normal,
  );

  static final ThemeData appTheme = ThemeData(
    fontFamily: primaryFontFamily,
  );
}