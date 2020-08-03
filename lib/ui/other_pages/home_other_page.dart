import 'package:flutter/material.dart';
import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/models/other_comic.dart';
import 'package:komikcast/ui/tab_pages/favorite_screen.dart';

class HomeOtherScreen extends StatefulWidget {
  final String appBarTitle;

  HomeOtherScreen({this.appBarTitle});

  @override
  _HomeOtherScreenState createState() => _HomeOtherScreenState();
}

class _HomeOtherScreenState extends State<HomeOtherScreen> {
  ScrollController _controller = ScrollController();
  bool _firstLoaded = false, _isLoading = false;
  int page = 1;
  List<OtherComic> results = [];

  @override
  void initState() {
    super.initState();
    listenScroll();
    widget.appBarTitle == 'Chapter Terbaru'
        ? getChapterTerbaru()
        : getProject();
  }

  void listenScroll() {
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        onBottomReached();
      }
    });
  }

  void onBottomReached() {
    setState(() {
      _isLoading = true;
      page++;
      Future.delayed(Duration(seconds: 0), () async {
        results.addAll(
          widget.appBarTitle == 'Chapter Terbaru'
              ? await ComicData.getChapterTerbaru(page: page)
              : await ComicData.getProjectTerbaru(page: page),
        );
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  void getChapterTerbaru() async {
    results = await ComicData.getChapterTerbaru(page: page);
    setState(() {
      _firstLoaded = true;
    });
  }

  void getProject() async {
    results = await ComicData.getProjectTerbaru(page: page);
    setState(() {
      _firstLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
      ),
      body: _firstLoaded
          ? SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: results
                          .map(
                            (e) => ListItemGrid(
                              width: width,
                              image: e.image,
                              title: e.title,
                              mangaId: e.linkId,
                              type: e.type,
                              chapter: e.chapter,
                              rating: e.rating ?? null,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  _isLoading
                      ? Container(
                          margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
