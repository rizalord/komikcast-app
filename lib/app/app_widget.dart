import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/pages/splash_screen.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,

      themeMode: ThemeMode.system,
      // LIGHT MODE
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      // DARK MODE
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
    );
  }
}