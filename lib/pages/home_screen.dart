import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komikcast/bloc/theme_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final themeBloc = Modular.get<ThemeBloc>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Komikcast'),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.moon),
            onPressed: () {
              themeBloc.add(
                Theme.of(context).brightness == Brightness.light
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}
