import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeMode, ThemeMode> {
  @override
  ThemeMode get initialState => ThemeMode.system;

  @override
  Stream<ThemeMode> mapEventToState(ThemeMode event) async* {
    yield event;
  }
}
