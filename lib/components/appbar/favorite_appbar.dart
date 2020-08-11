import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/bloc/favorite_sort_bloc.dart';

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
        BlocBuilder<FavoriteSortBloc, String>(
          builder: (ctx, state) => PopupMenuButton(
            icon: Icon(Icons.sort),
            initialValue: state,
            onSelected: (val) {
              Modular.get<FavoriteSortBloc>().add(val);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(child: Text('Asc'), value: 'asc'),
              PopupMenuItem(child: Text('Desc'), value: 'desc'),
            ],
          ),
        )
      ],
    );
  }
}
