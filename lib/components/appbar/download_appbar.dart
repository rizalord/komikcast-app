import 'package:flutter/material.dart';

class DownloadAppBar extends StatefulWidget implements PreferredSizeWidget {
  DownloadAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _DownloadAppBarState createState() => _DownloadAppBarState();
}

class _DownloadAppBarState extends State<DownloadAppBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Downloads"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
          },
        )
      ],
    );
  }
}
