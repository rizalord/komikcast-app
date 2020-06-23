import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
      );
}
