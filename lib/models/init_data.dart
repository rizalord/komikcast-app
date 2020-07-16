import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/bloc/theme_bloc.dart';
import 'package:komikcast/bloc/history_bloc.dart';

class KomikcastSystem {
  // This method called when app has not been initialized
  Future<void> initData(context) async {
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

    // OPEN DB
    // ===============================
    var db = Hive.box('komikcast');

    // Initialize State
    this.themeInit(db: db);
    this.historyInit(db: db);

    // END CHECK
    Modular.to.pushReplacementNamed('/main');
  }

  void themeInit({Box db}) {
    var theme = db.get('theme') == null ? 'light' : db.get('theme');
    db.put('theme', theme);
    Modular.get<ThemeBloc>()
        .add(theme == 'light' ? ThemeMode.light : ThemeMode.dark);
  }

  void historyInit({Box db}) {
    var historyList = db.get('history') == null ? [] : db.get('history');
    Modular.get<HistoryBloc>().add(historyList);
  }
}
