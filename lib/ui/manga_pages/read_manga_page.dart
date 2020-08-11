import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/bloc/favorite_bloc.dart';
import 'package:komikcast/data/chapter_readed_data.dart';
import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/data/favorite_data.dart';
import 'package:komikcast/data/history_data.dart';
import 'package:komikcast/models/detail_chapter.dart';
import 'package:komikcast/models/detail_comic.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ReadMangaPage extends StatefulWidget {
  final String mangaId, currentId;
  final Map downloadData;

  ReadMangaPage({
    this.mangaId,
    this.currentId,
    this.downloadData,
  });

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
  DetailComic detail;
  Map downloadData;

  @override
  void initState() {
    super.initState();
    mangaId = widget.mangaId;
    currentId = widget.currentId;
    downloadData = widget.downloadData;

    if (downloadData == null)
      getListData(withDetail: true);
    else
      getDownloadedData(
        title: downloadData['title'],
        path: downloadData['downloadPath'],
      );
  }

  getDownloadedData({String path, String title}) {
    setState(() {
      downloadData['images'] =
          Directory(path).listSync().map((e) => e.path).toList().cast<String>();
      isLoaded = true;
    });
  }

  getListData({withDetail = false}) async {
    if (withDetail == true)
      detail = await ComicData.getDetailKomik(id: mangaId);

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

    // Save Chapter
    ChapterReadedData.saveChapter(chapterId: currentId);

    // Save history
    return HistoryData.saveHistory(
        mangaId: mangaId, currentId: currentId, detailChapter: res);
  }

  changeChapter({id}) {
    if (this.mounted) {
      setState(() {
        currentId = id;
        isLoaded = false;

        getListData();
      });
    }
  }

  setShowMenu(bool state) {
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
                    downloadedImages:
                        downloadData == null ? null : downloadData['images'],
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
              titleDownloaded:
                  downloadData == null ? null : downloadData['title'],
              rootContext: context,
              listChapter: listChapter,
              changeChapter: changeChapter,
            ),
            downloadData == null
                ? BottomMenu(
                    width: width,
                    showMenu: showMenu,
                    nextId: nextId,
                    prevId: prevId,
                    changeChapter: changeChapter,
                    isLoaded: isLoaded,
                    mangaId: mangaId,
                    detail: detail,
                  )
                : Container(),
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
    this.downloadedImages,
  }) : super(key: key);

  final Function setShowMenu;
  final bool showMenu;
  final List<ImageChapter> images;
  final List<String> downloadedImages;

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
                itemCount: widget.downloadedImages == null
                    ? widget.images.length
                    : widget.downloadedImages.length,
                itemBuilder: (ctx, idx) => widget.downloadedImages == null
                    ? CachedNetworkImage(
                        imageUrl: widget.images[idx].link,
                        fit: BoxFit.cover,
                        placeholder: (context, text) => Container(
                          color: Theme.of(context)
                              .textSelectionHandleColor
                              .withOpacity(.0),
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width / 2.5),
                          child: Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      )
                    : Image.file(
                        File(widget.downloadedImages[idx]),
                        fit: BoxFit.cover,
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
    this.mangaId,
    this.detail,
  }) : super(key: key);

  final double width;
  final bool showMenu, isLoaded;
  final String prevId, nextId, mangaId;
  final Function changeChapter;
  final DetailComic detail;

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
              child: BlocBuilder<FavoriteBloc, List<Map>>(
                builder: (ctx, state) {
                  var isFavorited = state
                          .where(
                            (element) =>
                                element['mangaId'] ==
                                (mangaId.substring(mangaId.length - 1) == '/'
                                    ? mangaId.replaceAll('/', '')
                                    : mangaId),
                          )
                          .toList()
                          .length >
                      0;

                  return IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.white,
                    ),
                    onPressed: () async {
                      if (detail != null) {
                        isFavorited
                            ? await FavoriteData.unsaveFavorite(
                                mangaId: mangaId,
                              )
                            : await FavoriteData.saveFavorite(
                                mangaId: mangaId,
                                currentId: detail.listChapters.first.linkId,
                                detailChapter:
                                    detail.listChapters.first.chapter,
                                image: detail.image,
                                title: detail.title,
                                type: detail.type,
                                context: context,
                              );
                      }
                    },
                  );
                },
              ),
            ),
            // Material(
            //   color: Colors.transparent,
            //   borderRadius: BorderRadius.circular(width),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.comment,
            //       color: Colors.white,
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
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
    this.titleDownloaded,
    this.rootContext,
    this.listChapter,
    this.changeChapter,
  }) : super(key: key);

  final double width;
  final bool showMenu;
  final String currentChapter, titleDownloaded;
  final BuildContext rootContext;
  final List<SelectChapter> listChapter;
  final Function changeChapter;

  void showListChapter() {
    showDialog(
      context: rootContext,
      builder: (ctx) => AlertDialog(
        title: Text('Select Chapter'),
        content: Container(
          child: ListView.builder(
            itemCount: listChapter.length,
            itemBuilder: (ctx, idx) => ListTile(
              title: Text(listChapter[idx].text),
              onTap: () {
                Modular.to.pop();
                changeChapter(id: listChapter[idx].linkId);
              },
            ),
          ),
        ),
      ),
    );
  }

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
                      onPressed: () => Modular.to.pop(context),
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Container(
                      child: Text(
                        titleDownloaded == null
                            ? 'Chapter $currentChapter'
                            : titleDownloaded,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            titleDownloaded == null
                ? Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(width),
                    child: IconButton(
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: Colors.white,
                      ),
                      onPressed: showListChapter,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
