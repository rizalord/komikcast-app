import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/components/custom/search_bar/app_bar_controller.dart';
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
  bool _isLoading = false, _isGettingData = true;
  int _count = 10;
  TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(text: widget.query);
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
        if (this.mounted)
          setState(() {
            _count += 10;
            _isLoading = false;
          });
      });
    });
  }

  void getData() {
    Future.delayed(Duration(seconds: 3), () {
      if (this.mounted)
        setState(() {
          _isGettingData = false;
        });
    });
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
            onSubmitted: (val) {},
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
