import 'package:flutter/material.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

class SearchingAppBar extends StatefulWidget implements PreferredSizeWidget {
  SearchingAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SearchingAppBarState createState() => _SearchingAppBarState();
}

class _SearchingAppBarState extends State<SearchingAppBar> {
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
        title: Text("Search"),
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
