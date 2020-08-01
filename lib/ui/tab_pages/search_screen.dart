import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/components/card/comictype.dart';
import 'dart:math' as math;

import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/models/search_result.dart';
import 'package:komikcast/ui/tab_pages/favorite_screen.dart';

class SearchTabPage extends StatefulWidget {
  @override
  _SearchTabPageState createState() => _SearchTabPageState();
}

class _SearchTabPageState extends State<SearchTabPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller = ScrollController();
  bool _isLoading = false, _isLoaded = false;
  int page = 1;
  List<SearchResult> results = [];

  @override
  void initState() {
    listenScroll();
    getData();
    super.initState();
  }

  void getData() async {
    results = await ComicData.getAllKomik(page: page);
    setState(() {
      _isLoaded = true;
    });
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
        results.addAll(await ComicData.getAllKomik(page: page));
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoaded
          ? SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
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
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   padding:
                  //       EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  //   itemCount: results.length,
                  //   itemBuilder: (context, index) => ItemCard(
                  //     width: width,
                  //     chapter: results[index].chapter,
                  //     type: results[index].type,
                  //     rating: results[index].rating,
                  //     image: results[index].image,
                  //     isCompleted: results[index].isCompleted,
                  //     title: results[index].title,
                  //     linkId: results[index].linkId,
                  //   ),
                  // ),
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

  @override
  bool get wantKeepAlive => true;
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.width,
    this.image,
    this.chapter,
    this.rating,
    this.type,
    this.isCompleted = false,
    this.title,
    this.linkId,
  }) : super(key: key);

  final double width;
  final String title, image, chapter, rating, type, linkId;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => Modular.to.pushNamed('/detailmanga', arguments: {
              'image': image,
              'title': title,
              'linkId': linkId,
            }),
            child: Container(
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
