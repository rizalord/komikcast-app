import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/bloc/theme_bloc.dart';

class KomikcastSystem {
  // This method called when app has not been initialized
  static Future<void> initData(context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: ListTile(
          title: Text('Getting data...'),
          leading: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    // THEME INIT
    var db = await Hive.openBox('komikcast');
    var theme = db.get('theme') == null ? 'light' : db.get('theme');
    db.put('theme', theme);
    Modular.get<ThemeBloc>()
        .add(theme == 'light' ? ThemeMode.light : ThemeMode.dark);

    // END CHECK
    Modular.to.pushReplacementNamed('/main');
  }
}
