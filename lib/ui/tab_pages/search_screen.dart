import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/components/card/comictype.dart';
import 'dart:math' as math;

class SearchTabPage extends StatefulWidget {
  @override
  _SearchTabPageState createState() => _SearchTabPageState();
}

class _SearchTabPageState extends State<SearchTabPage> {
  ScrollController _controller = ScrollController();
  bool _isLoading = false;
  int _count = 10;

  @override
  void initState() {
    listenScroll();
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key key,
      @required this.width,
      this.image,
      this.chapter,
      this.rating,
      this.type,
      this.isCompleted = false,
      this.title})
      : super(key: key);

  final double width;
  final String title, image, chapter, rating, type;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(6),
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 1,
              //         color: Colors.black.withOpacity(.02),
              //         offset: Offset(0, 1),
              //         spreadRadius: 1,
              //       )
              //     ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        width: width * .22,
                        height: width * .3,
                      ),
                      Positioned(
                        bottom: 6.0,
                        left: 6.0,
                        child: ComicTypeCard(text: type, mini: true),
                      ),
                      isCompleted
                          ? Positioned(
                              top: 14,
                              left: -18.5,
                              child: Transform.rotate(
                                angle: -math.pi / 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.2),
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                        spreadRadius: 1,
                                      )
                                    ],
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    'COMPLETED',
                                    style: GoogleFonts.heebo(
                                      fontSize: 6,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.heebo(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Ch.$chapter',
                            style: GoogleFonts.heebo(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 2,
                                color: Theme.of(context)
                                    .textSelectionHandleColor
                                    .withOpacity(.75)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[500],
                                  size: 18,
                                ),
                                Text(
                                  rating,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context)
                                        .textSelectionHandleColor
                                        .withOpacity(.5),
                                    fontSize: 12,
                                    height: 2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
