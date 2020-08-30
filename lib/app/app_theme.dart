import 'package:flutter/material.dart';
import 'package:komikcast/env.dart';

class CustomTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        textSelectionHandleColor: Colors.black,
        textSelectionColor: Colors.white,
        primaryColor: Env.primaryColor,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        textSelectionHandleColor: Colors.white,
        textSelectionColor: Colors.black,
      );
}
