import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text('Komikcast'),
      actions: [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.crown,
            size: 20,
          ),
          onPressed: () {
            // Modular.get<ThemeBloc>().add(
            //   Theme.of(context).brightness == Brightness.light
            //       ? ThemeMode.dark
            //       : ThemeMode.light,
            // );
          },
        ),
      ],
    );
  }
}
