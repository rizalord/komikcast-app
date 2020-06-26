import 'package:flutter/material.dart';
import 'package:komikcast/components/custom/search_bar/app_bar_controller.dart';
import 'package:komikcast/components/custom/search_bar/search_app_bar.dart';
import 'package:komikcast/ui/tab_pages/search_screen.dart';

class SearchPage extends StatefulWidget {
  final String query;

  SearchPage({
    @required this.query,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final AppBarController appBarController = AppBarController();
  ScrollController _controller = ScrollController();
  bool _isLoading = false,_isGettingData = true;
  int _count = 10;

  @override
  void initState() {
    listenScroll();
    getData();
    super.initState();
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
      _controller.jumpTo(_controller.position.maxScrollExtent);
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _count += 10;
          _isLoading = false;
        });
      });
    });
  }

  void getData() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isGettingData = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: SearchAppBar(
        primary: Theme.of(context).primaryColor,
        appBarController: appBarController,
        autoSelected: true,
        searchHint: "Cari komik...",
        mainTextColor: Colors.white,
        initialQuery: widget.query,
        onChange: (String value) {},
      ),
      body: _isGettingData
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    itemCount: _count,
                    itemBuilder: (context, index) => ItemCard(
                      width: width,
                      chapter: '04',
                      type: 'manga',
                      rating: '7.00',
                      image:
                          'https://komikcast.com/wp-content/uploads/2020/05/presicau2.jpg',
                      isCompleted: false,
                      title:
                          'It’s too precious and hard to read !!” 4P Short Stories',
                    ),
                  ),
                  _isLoading
                      ? Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 20.0),
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
            ),
    );
  }
}
