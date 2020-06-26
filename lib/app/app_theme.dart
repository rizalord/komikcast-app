import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        // splashColor: Colors.black,
      textSelectionHandleColor: Colors.black,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        // splashColor: Colors.white,
        textSelectionHandleColor: Colors.white,
      );
}
