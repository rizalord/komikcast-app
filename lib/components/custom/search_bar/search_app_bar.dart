import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_bar_controller.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color statusBarColor;
  final Color primary;
  final bool autoSelected;
  final AppBar mainAppBar;
  final Color mainTextColor;
  final String initialQuery;
  final String searchHint;
  final AppBarController appBarController;
  final Function(String search) onChange;
  final double searchFontSize;
  final Function onSubmitted;

  SearchAppBar({
    @required this.primary,
    this.mainTextColor = Colors.white,
    this.statusBarColor,
    this.initialQuery,
    this.autoSelected = false,
    this.searchHint = "Search here...",
    this.mainAppBar,
    @required this.appBarController,
    @required this.onChange,
    this.searchFontSize = 20,
    this.onSubmitted,
  });

  @override
  Size get preferredSize {
    return Size.fromHeight(60.0);
  }

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController queryController = TextEditingController();

  Widget build(BuildContext context) {
    if (widget.initialQuery != null) {
      queryController.text = widget.initialQuery;
      widget.onChange(widget.initialQuery);
    }

    return StreamBuilder(
      stream: widget.appBarController.stream.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snap) {
        bool _show = widget.autoSelected;

        if (snap.hasData) {
          _show = snap.data;
        }

        if (_show || widget.mainAppBar == null) {
          return searchAppBar(
            context: context,
          );
        } else {
          return showMainAppBar();
        }
      },
    );
  }

  Widget showMainAppBar() {
    return widget.mainAppBar;
  }

  Widget searchAppBar({@required BuildContext context}) {
    return AppBar(
      leading: InkWell(
        child: Icon(
          Icons.close,
          color: widget.mainTextColor,
        ),
        onTap: () {
          if (widget.mainAppBar == null) {
            Modular.to.pop();
          } else {
            widget.appBarController.stream.add(false);
            widget.onChange('');
          }
        },
      ),
      backgroundColor: widget.primary,
      title: Container(
        child: TextField(
          controller: queryController,
          autofocus: true,
          onChanged: (String value) {
            widget.onChange(value);
          },
          onSubmitted: widget.onSubmitted,
          style: TextStyle(
            fontSize: widget.searchFontSize,
            color: widget.mainTextColor,
          ),
          cursorColor: widget.mainTextColor,
          decoration: InputDecoration(
            hintText: widget.searchHint,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: widget.mainTextColor.withAlpha(100),
            ),
            suffixIcon: Icon(
              Icons.search,
              color: widget.mainTextColor.withAlpha(100),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }
}
