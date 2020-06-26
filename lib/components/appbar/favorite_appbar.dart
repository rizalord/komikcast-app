import 'package:flutter/material.dart';

class FavoriteAppBar extends StatefulWidget implements PreferredSizeWidget {
  FavoriteAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _FavoriteAppBarState createState() => _FavoriteAppBarState();
}

class _FavoriteAppBarState extends State<FavoriteAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Favorite"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        PopupMenuButton(
          icon: Icon(Icons.sort),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(child: Text('Asc')),
            PopupMenuItem(child: Text('Desc')),
          ],
        )
      ],
    );
  }
}
