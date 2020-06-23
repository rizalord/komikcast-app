import 'package:flutter/material.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

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
  AppBarController appBarController = AppBarController();

  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
      primary: Theme.of(context).primaryColor,
      appBarController: appBarController,
      // You could load the bar with search already active
      autoSelected: false,
      searchHint: "Cari komik...",
      mainTextColor: Colors.white,
      onChange: (String value) {
        //Your function to filter list. It should interact with
        //the Stream that generate the final list
      },
      //Will show when SEARCH MODE wasn't active
      mainAppBar: AppBar(
        title: Text("Favorite"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              appBarController.stream.add(true);
            },
          )
        ],
      ),
    );
  }
}
