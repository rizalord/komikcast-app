import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/components/custom/search_bar/app_bar_controller.dart';
import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/models/search_result.dart';
import 'package:komikcast/ui/tab_pages/favorite_screen.dart';
import 'package:komikcast/ui/tab_pages/search_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final AppBarController appBarController = AppBarController();
  ScrollController _controller = ScrollController();
  bool _isLoading = false, _isGettingData = true, _firstLoaded = false;
  int page = 1;
  TextEditingController _textController = TextEditingController();
  List<SearchResult> results = [];
  String currentSearchKeyword = '';

  @override
  void initState() {
    listenScroll();
    super.initState();
    Future.delayed(Duration.zero, hideKeyboard);
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void listenScroll() {
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        loadMore();
      }
    });
  }

  void loadMore() {
    setState(() {
      _isLoading = true;
      page++;
      Future.delayed(Duration.zero, () async {
        results.addAll(await ComicData.getSpecificComic(
            keyword: currentSearchKeyword, page: page));
        if (this.mounted)
          setState(() {
            _isLoading = false;
          });
      });
    });
  }

  void getData() async {
    results = await ComicData.getSpecificComic(
        keyword: currentSearchKeyword, page: page);
    if (this.mounted)
      setState(() {
        currentSearchKeyword = currentSearchKeyword;
        _isGettingData = false;
        _firstLoaded = true;
      });
  }

  void getDataAgain(String keyword) async {
    if (this.mounted) {
      setState(() {
        page = 1;
        _firstLoaded = true;
        _isGettingData = true;
        currentSearchKeyword = keyword;
        Future.delayed(Duration.zero, () async {
          results =
              await ComicData.getSpecificComic(keyword: keyword, page: page);
          setState(() {
            _isGettingData = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onTap: () {
            Modular.to.pop();
          },
        ),
        title: Container(
          child: TextField(
            controller: _textController,
            autofocus: true,
            onSubmitted: getDataAgain,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Cari komik...',
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white.withAlpha(100),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white.withAlpha(100),
              ),
            ),
          ),
        ),
      ),
      body: _firstLoaded == false
          ? Center(
              child: Image.asset('assets/images/web-search.png'),
            )
          : _isGettingData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : results.length != 0
                  ? SingleChildScrollView(
                      controller: _controller,
                      child: Column(
                        children: [
                          SizedBox(height: 12.0),
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Wrap(
                              spacing: 8.0,
                              alignment: WrapAlignment.start,
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
                                  margin:
                                      EdgeInsets.only(top: 5.0, bottom: 20.0),
                                  child: CircularProgressIndicator(),
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Center(
                      child: Text('Comic Not Found'),
                    ),
    );
  }
}
