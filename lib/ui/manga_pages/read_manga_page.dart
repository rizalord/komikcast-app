import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadMangaPage extends StatefulWidget {
  @override
  _ReadMangaPageState createState() => _ReadMangaPageState();
}

class _ReadMangaPageState extends State<ReadMangaPage> {
  var showMenu = false;

  void setShowMenu(bool state) {
    setState(() {
      showMenu = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Content(setShowMenu: setShowMenu, showMenu: showMenu),
            HeaderMenu(width: width, showMenu: showMenu),
            BottomMenu(width: width, showMenu: showMenu),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({
    Key key,
    this.setShowMenu,
    this.showMenu,
  }) : super(key: key);

  final Function setShowMenu;
  final bool showMenu;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    onScrollListen();
  }

  onScrollListen() {
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels == 0) {
        widget.setShowMenu(true);
      }

      if (_controller.position.pixels != 0 && widget.showMenu == true) {
        widget.setShowMenu(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        child: SingleChildScrollView(
          controller: _controller,
          child: GestureDetector(
            onTap: () {
              widget.setShowMenu(!widget.showMenu);
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (ctx, idx) => CachedNetworkImage(
                imageUrl:
                    'https://cdn.komikcast.com/wp-content/img/H/Haikyuu!!/399/00${idx + 1}.jpg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    Key key,
    @required this.width,
    this.showMenu,
  }) : super(key: key);

  final double width;
  final bool showMenu;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: showMenu ? 0 : -(kToolbarHeight),
      child: Container(
        width: width,
        height: kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.75),
          border: Border(
            top: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.white.withOpacity(.8),
              width: 2,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: IconButton(
                icon: Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderMenu extends StatelessWidget {
  const HeaderMenu({
    Key key,
    @required this.width,
    this.showMenu,
  }) : super(key: key);

  final double width;
  final bool showMenu;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: showMenu ? 0 : -(kToolbarHeight + 20),
      child: Container(
        width: width,
        padding: EdgeInsets.only(top: 20),
        height: kToolbarHeight + 20,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.75),
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.white.withOpacity(.8),
              width: 2,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(width),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Chapter 1',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: IconButton(
                icon: Icon(
                  Icons.format_list_bulleted,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
