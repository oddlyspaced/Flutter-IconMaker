import 'package:flutter/material.dart';

class ThemeConstants {
  static final String primaryFontFamily = "Helvetica";

  static final Color textPrimaryColor = Colors.white;
  static final Color iconBackground = Colors.black;

  static final TextStyle heading = TextStyle(
    fontSize: 36,
    color: ThemeConstants.textPrimaryColor,
    fontWeight: FontWeight.bold,
  );

  static final ThemeData appTheme = ThemeData(
    fontFamily: primaryFontFamily,
  );
}