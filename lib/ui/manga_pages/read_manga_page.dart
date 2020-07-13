import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/models/detail_chapter.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ReadMangaPage extends StatefulWidget {
  final String mangaId, currentId;

  ReadMangaPage({this.mangaId, this.currentId});

  @override
  _ReadMangaPageState createState() => _ReadMangaPageState();
}

class _ReadMangaPageState extends State<ReadMangaPage> {
  var showMenu = false;
  var mangaId, currentId;
  var isLoaded = false;
  String nextId, prevId, currentChapter;
  List<SelectChapter> listChapter = [];
  List<ImageChapter> listImage = [];

  @override
  void initState() {
    super.initState();
    mangaId = widget.mangaId;
    currentId = widget.currentId;

    getListData();
  }

  void getListData() async {
    final res = await ComicData.getChapterKomik(id: currentId);
    listChapter = res.selectChapter;
    listImage = res.images;

    prevId = res.prevLinkId;
    nextId = res.nextLinkId;
    currentChapter = res.chapter;

    if (this.mounted)
      setState(() {
        isLoaded = true;
      });
  }

  void changeChapter({id}) {
    if (this.mounted) {
      setState(() {
        currentId = id;
        isLoaded = false;

        getListData();
      });
    }
  }

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
            isLoaded
                ? Content(
                    setShowMenu: setShowMenu,
                    showMenu: showMenu,
                    images: listImage,
                  )
                : Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            HeaderMenu(
              width: width,
              showMenu: showMenu,
              currentChapter: currentChapter,
            ),
            BottomMenu(
              width: width,
              showMenu: showMenu,
              nextId: nextId,
              prevId: prevId,
              changeChapter: changeChapter,
              isLoaded: isLoaded,
            ),
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
    this.images,
  }) : super(key: key);

  final Function setShowMenu;
  final bool showMenu;
  final List<ImageChapter> images;

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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Positioned.fill(
      child: Zoom(
        width: width + (width * .6),
        height: height + (height * .6),
        backgroundColor: Theme.of(context).primaryColor,
        opacityScrollBars: 0.9,
        scrollWeight: 10.0,
        centerOnScale: false,
        enableScroll: false,
        doubleTapZoom: false,
        zoomSensibility: 1.3,
        initZoom: 0.0,
        onPositionUpdate: (position) {},
        onScaleUpdate: (scale, zoom) {},
        child: Container(
          height: height,
          child: SingleChildScrollView(
            controller: _controller,
            child: GestureDetector(
              onTap: () {
                widget.setShowMenu(!widget.showMenu);
              },
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.images.length,
                itemBuilder: (ctx, idx) => CachedNetworkImage(
                  imageUrl: widget.images[idx].link,
                ),
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
    this.nextId,
    this.prevId,
    this.changeChapter,
    this.isLoaded,
  }) : super(key: key);

  final double width;
  final bool showMenu, isLoaded;
  final String prevId, nextId;
  final Function changeChapter;

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
          color: Theme.of(context).primaryColor.withOpacity(.85),
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
                  color: prevId != null
                      ? Colors.white
                      : Colors.white.withOpacity(.5),
                ),
                onPressed: () {
                  if (prevId != null && isLoaded) changeChapter(id: prevId);
                },
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
                  color: nextId != null
                      ? Colors.white
                      : Colors.white.withOpacity(.5),
                ),
                onPressed: () {
                  if (nextId != null && isLoaded) changeChapter(id: nextId);
                },
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
    this.currentChapter,
  }) : super(key: key);

  final double width;
  final bool showMenu;
  final String currentChapter;

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
          color: Theme.of(context).primaryColor.withOpacity(.85),
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
                    'Chapter $currentChapter',
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
