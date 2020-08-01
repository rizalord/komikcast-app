import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/components/custom/search_bar/app_bar_controller.dart';
import 'package:komikcast/components/custom/search_bar/search_app_bar.dart';

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
      autoSelected: false,
      searchHint: "Cari komik...",
      mainTextColor: Colors.white,
      onSubmitted: (String query) {
        FocusScope.of(context).unfocus();
        Modular.to.pushNamed('/search/$query');
        FocusScope.of(context).unfocus();
      },
      onChange: (String text) {},
      //Will show when SEARCH MODE wasn't active
      mainAppBar: AppBar(
        title: Text("Search"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Modular.to.pushNamed('/search');
            },
          )
        ],
      ),
    );
  }
}
