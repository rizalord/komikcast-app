import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:komikcast/components/card/comictype.dart';
import 'package:komikcast/components/text/sub_header_text.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

// MAIN HOME PAGE
class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ComicSlider(width: width),
            SubHeader(text: 'update project komikcast', width: width),
            ComicUpdateProject(width: width),
            SubHeader(text: 'chapter terbaru', width: width),
            ComicLatestChapter(width: width),
          ],
        ),
      ),
    );
  }
}

// LATEST CHAPTER [SECTION 3]
class ComicLatestChapter extends StatelessWidget {
  ComicLatestChapter({this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ItemLatest(width: width),
            ItemLatest(width: width),
            ItemLatest(width: width),
            ItemLatest(width: width),
            ItemLatest(width: width),
          ],
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
    this.isHot = true,
  }) : super(key: key);

  final double width;
  final bool isHot;

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
                    onTap: () {},
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: width * .225,
                            height: (width * .35) + 10,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://komikcast.com/wp-content/uploads/2017/07/177617-4-211x300.jpg',
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
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Youkoso Jitsuryoku Shijou Shugi no Kyoushitsu e',
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
                                      children: [
                                        SingleChapterLink(),
                                        SingleChapterLink(),
                                        SingleChapterLink(),
                                      ],
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
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
                'Chapter 29',
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
            '26 mins ago',
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
  ComicUpdateProject({this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: (width * .7),
      // alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: SingleProject(
              width: width,
              image:
                  'https://komikcast.com/wp-content/uploads/2020/03/killthero-e1585211534116.png',
              title: 'Metropolitan Supremacy System',
              chapterNum: '19',
            ),
          ),
          SingleProject(
            width: width,
            image:
                'https://komikcast.com/wp-content/uploads/2018/06/ride-king.jpg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
          ),
          SingleProject(
            width: width,
            image:
                'https://komikcast.com/wp-content/uploads/2020/06/oopartsd-e1591053498578.jpg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
          ),
          SingleProject(
            width: width,
            image:
                'https://komikcast.com/wp-content/uploads/2019/12/mwrtrpsystem.jpg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
          ),
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: SingleProject(
              width: width,
              image:
                  'https://komikcast.com/wp-content/uploads/2019/05/jr290rjkasgmn-e1566741890856.jpg',
              title: 'Metropolitan Supremacy System',
              chapterNum: '19',
            ),
          ),
        ],
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
  }) : super(key: key);

  final double width;
  final String image, title, chapterNum, type;
  final bool isHot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              'Chapter $chapterNum',
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
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: (width * .83),
      // alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: SingleSlider(
              width: width,
              image:
                  'https://komikcast.com/wp-content/uploads/2019/08/394643123213da-e1565782699221.jpg',
              title: 'Metropolitan Supremacy System',
              chapterNum: '19',
              type: 'Manhua',
            ),
          ),
          SingleSlider(
            width: width,
            image: 'https://komikcast.com/wp-content/uploads/2017/08/180-1.jpg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
            type: 'Manga',
          ),
          SingleSlider(
            width: width,
            image:
                'https://komikcast.com/wp-content/uploads/2020/02/adlasofalnoe.jpg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
            type: 'Manhwa',
          ),
          SingleSlider(
            width: width,
            image:
                'https://komikcast.com/wp-content/uploads/2020/06/IMG_20200624_174041-e1592995348216.jpg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
            type: 'Manhwa',
          ),
          SingleSlider(
            width: width,
            image:
                'https://komikcast.com/wp-content/uploads/2020/06/22fsg1sa5w3rt1agv15-e1591782065864.jpeg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
            type: 'Manga',
          ),
          SingleSlider(
            width: width,
            image:
                'https://komikcast.com/wp-content/uploads/2020/06/4fd2saf2725wtv1-e1592991232714.jpg',
            title: 'Metropolitan Supremacy System',
            chapterNum: '19',
            type: 'Manga',
          ),
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: SingleSlider(
              width: width,
              image:
                  'https://komikcast.com/wp-content/uploads/2019/01/binetsu.jpg',
              title: 'Metropolitan Supremacy System',
              chapterNum: '19',
              type: 'Manga',
            ),
          ),
        ],
      ),
    );
  }
}

// ITEM FOR SLIDER
class SingleSlider extends StatelessWidget {
  const SingleSlider(
      {Key key,
      @required this.width,
      this.chapterNum,
      this.image,
      this.title,
      this.type})
      : super(key: key);

  final double width;
  final String image, title, chapterNum, type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/detailmanga', arguments: image),
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
                    '8.00',
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
