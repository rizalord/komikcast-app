import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeBloc extends Bloc<ThemeMode, ThemeMode> {
  @override
  ThemeMode get initialState => ThemeMode.system;

  @override
  Stream<ThemeMode> mapEventToState(ThemeMode event) async* {
    // Save to database
    var db = await Hive.openBox('komikcast');
    db.put('theme', event == ThemeMode.light ? 'light' : 'dark');

    yield event;
  }
}
