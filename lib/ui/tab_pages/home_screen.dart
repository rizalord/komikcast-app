import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:komikcast/components/card/comictype.dart';
import 'package:komikcast/components/text/sub_header_text.dart';
import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/models/comic_v1.dart';
import 'package:komikcast/models/comic_v2.dart';
import 'package:komikcast/models/comic_v3.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  var _isLoaded = false;
  List<ComicV1> _listV1 = [];
  List<ComicV2> _listV2 = [];
  List<ComicV3> _listV3 = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Get Data on Start Screen
  void getData() async {
    final resData = await ComicData.getHomeData();
    _listV1 = resData['hotComic'];
    _listV2 = resData['projectComic'];
    _listV3 = resData['latestChapter'];
    setState(() {
      _isLoaded = true;
    });
  }

  // Pull To Refresh Feature
  Future<void> onRefresh() async => getData();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoaded
          ? RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ComicSlider(width: width, data: _listV1),
                    SubHeader(
                      text: 'update project komikcast',
                      width: width,
                      onPressed: () => Modular.to.pushNamed(
                        '/homeother',
                        arguments: {'title': 'Update Project'},
                      ),
                    ),
                    ComicUpdateProject(width: width, data: _listV2),
                    SubHeader(
                      text: 'chapter terbaru',
                      width: width,
                      onPressed: () => Modular.to.pushNamed(
                        '/homeother',
                        arguments: {'title': 'Chapter Terbaru'},
                      ),
                    ),
                    ComicLatestChapter(width: width, data: _listV3),
                  ],
                ),
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

// LATEST CHAPTER [SECTION 3]
class ComicLatestChapter extends StatelessWidget {
  ComicLatestChapter({
    this.width,
    this.data,
  });

  final double width;
  final List<ComicV3> data;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: data.map((e) {
            return ItemLatest(
              width: width,
              isHot: e.isHot,
              title: e.title,
              image: e.image,
              listChapter: e.chapters,
              linkId: e.linkId,
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ITEM FOR LATEST SECTION
class ItemLatest extends StatelessWidget {
  const ItemLatest({
    Key key,
    @required this.width,
    this.isHot = false,
    this.title,
    this.image,
    this.linkId,
    this.listChapter,
  }) : super(key: key);

  final double width;
  final bool isHot;
  final String title, image, linkId;
  final List<SingleChapter> listChapter;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: width,
            height: (width * .35) + 10,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context)
                      .textSelectionHandleColor
                      .withOpacity(.04),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: InkWell(
                    onTap: () =>
                        Modular.to.pushNamed('/detailmanga', arguments: {
                      'image': image,
                      'title': title,
                      'linkId': linkId,
                    }),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: width * .225,
                            height: (width * .35) + 10,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: image,
                                  fit: BoxFit.cover,
                                  width: width * .32,
                                  height: width * .44,
                                ),
                                isHot
                                    ? Positioned(
                                        top: 6,
                                        left: -12.5,
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
                                                  color: Colors.black
                                                      .withOpacity(.2),
                                                  blurRadius: 1,
                                                  offset: Offset(0, 1),
                                                  spreadRadius: 1,
                                                )
                                              ],
                                              color: Colors.red,
                                            ),
                                            child: Text(
                                              'HOT',
                                              style: GoogleFonts.heebo(
                                                fontSize: 8,
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
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      title,
                                      style: GoogleFonts.heebo(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: listChapter
                                          .map(
                                            (e) => SingleChapterLink(
                                              title: e.title,
                                              time: e.timeUploaded,
                                              mangaId: linkId,
                                              currentId: e.linkId,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

// SINGLE CHAPTER OF LATEST ITEM
class SingleChapterLink extends StatelessWidget {
  const SingleChapterLink({
    Key key,
    this.title,
    this.time,
    this.mangaId,
    this.currentId,
  }) : super(key: key);

  final String title, time, mangaId, currentId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Modular.to.pushNamed(
              '/readmanga',
              arguments: {
                'mangaId': mangaId,
                'currentId': currentId,
              },
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).textSelectionHandleColor.withOpacity(.07),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                title,
                style: GoogleFonts.heebo(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context)
                      .textSelectionHandleColor
                      .withOpacity(.65),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Text(
            time,
            style: GoogleFonts.heebo(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).textSelectionHandleColor.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}

// UPDATE PROJECT [SECTION 2]
class ComicUpdateProject extends StatelessWidget {
  ComicUpdateProject({
    this.width,
    this.data,
  });

  final double width;
  final List<ComicV2> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: (width * .7),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: data.map((e) {
          if (data.indexOf(e) == 0) {
            return Container(
              margin: EdgeInsets.only(left: 5.0),
              child: SingleProject(
                width: width,
                image: e.image,
                title: e.title,
                chapterNum: e.chapter.toString(),
                isHot: e.isHot,
                linkId: e.linkId,
              ),
            );
          } else if (data.indexOf(e) == data.length - 1) {
            return Container(
              margin: EdgeInsets.only(right: 5.0),
              child: SingleProject(
                width: width,
                image: e.image,
                title: e.title,
                chapterNum: e.chapter.toString(),
                isHot: e.isHot,
                linkId: e.linkId,
              ),
            );
          } else {
            return SingleProject(
              width: width,
              image: e.image,
              title: e.title,
              chapterNum: e.chapter.toString(),
              isHot: e.isHot,
              linkId: e.linkId,
            );
          }
        }).toList(),
      ),
    );
  }
}

// SINGLE ITEM FOR UPDATE PROJECT SECTION
class SingleProject extends StatelessWidget {
  const SingleProject({
    Key key,
    @required this.width,
    this.chapterNum,
    this.image,
    this.title,
    this.type,
    this.isHot = true,
    this.linkId,
  }) : super(key: key);

  final double width;
  final String image, title, chapterNum, type, linkId;
  final bool isHot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/detailmanga', arguments: {
        'image': image,
        'title': title,
        'linkId': linkId,
      }),
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        width: width * .32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: width * .32,
                  height: width * .44,
                ),
                isHot
                    ? Positioned(
                        top: 7,
                        left: -13,
                        child: Transform.rotate(
                          angle: -math.pi / 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 1,
                            ),
                            decoration:
                                BoxDecoration(color: Colors.red, boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.2),
                                blurRadius: 1,
                                offset: Offset(0, 1),
                                spreadRadius: 1,
                              )
                            ]),
                            child: Text(
                              'HOT',
                              style: GoogleFonts.heebo(
                                fontSize: 9,
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
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 6),
              child: Text(
                title,
                style: GoogleFonts.heebo(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '$chapterNum',
              style: GoogleFonts.heebo(
                fontSize: 15,
                height: 1.5,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// COMIC SLIDER [SECTION 1]
class ComicSlider extends StatelessWidget {
  const ComicSlider({
    Key key,
    @required this.width,
    this.data,
  }) : super(key: key);

  final double width;
  final List<ComicV1> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: (width * .83),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: data.map((e) {
          if (data.indexOf(e) == 0) {
            return Container(
              margin: EdgeInsets.only(left: 5.0),
              child: SingleSlider(
                width: width,
                image: e.image,
                title: e.title,
                chapterNum: e.chapter.toString(),
                type: e.type,
                linkId: e.linkId,
                rating: e.rating,
              ),
            );
          } else if (data.indexOf(e) == data.length - 1) {
            return Container(
              margin: EdgeInsets.only(right: 5.0),
              child: SingleSlider(
                width: width,
                image: e.image,
                title: e.title,
                chapterNum: e.chapter.toString(),
                type: e.type,
                linkId: e.linkId,
                rating: e.rating,
              ),
            );
          } else {
            return SingleSlider(
              width: width,
              image: e.image,
              title: e.title,
              chapterNum: e.chapter.toString(),
              type: e.type,
              linkId: e.linkId,
              rating: e.rating,
            );
          }
        }).toList(),
      ),
    );
  }
}

// ITEM FOR SLIDER
class SingleSlider extends StatelessWidget {
  const SingleSlider({
    Key key,
    @required this.width,
    this.chapterNum,
    this.image,
    this.title,
    this.type,
    this.linkId,
    this.rating,
  }) : super(key: key);

  final double width;
  final String image, title, chapterNum, type, linkId, rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/detailmanga', arguments: {
        'image': image,
        'title': title,
        'linkId': linkId,
      }),
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        width: width * .4,
        // height: width * .55,
        // color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: image,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: width * .4,
                    height: width * .55,
                  ),
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: ComicTypeCard(text: type),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: GoogleFonts.heebo(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'Ch. $chapterNum',
              style: GoogleFonts.heebo(
                fontSize: 13,
                height: 1.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                      ],
                    ),
                  ),
                  Text(
                    rating != null ? rating : '-',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context)
                          .textSelectionHandleColor
                          .withOpacity(.5),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
