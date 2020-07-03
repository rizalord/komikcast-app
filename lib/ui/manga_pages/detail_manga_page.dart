import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/bloc/blur_bloc.dart';
import 'package:komikcast/bloc/scroll_bloc.dart';
import 'package:komikcast/bloc/sliver_bloc.dart';
import 'package:komikcast/ui/manga_pages/tab_chapters.dart';
import 'package:komikcast/ui/manga_pages/tab_overview.dart';

class DetailManga extends StatefulWidget {
  DetailManga({this.tag});

  final String tag;

  @override
  _DetailMangaState createState() => _DetailMangaState();
}

class _DetailMangaState extends State<DetailManga> {
  var top = 0.0;
  var blur = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final sliverBloc = Modular.get<SliverBloc>();
    final blurBloc = Modular.get<BlurBloc>();

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: width,
                  backgroundColor: Theme.of(context).textSelectionColor,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      top = constraints.biggest.height;
                      blur = ((width / constraints.biggest.height) - 1) * 4;

                      // BLOC DISPATCH
                      blurBloc.add(blur);
                      sliverBloc.add(
                        top ==
                                MediaQuery.of(context).padding.top +
                                    kToolbarHeight
                            ? true
                            : false,
                      );

                      return FlexibleSpaceBar(
                        title: Container(),
                        background: PageHeader(widget: widget, width: width),
                      );
                    },
                  ),
                  leading: Container(),
                  actions: [Container()],
                ),
                SliverContent(width: width, setState: this.setState),
              ],
            ),
            CustomAppBar(
                sliverBloc: sliverBloc, width: width, image: widget.tag),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.sliverBloc,
    @required this.width,
    this.image,
  }) : super(key: key);

  final SliverBloc sliverBloc;
  final double width;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: BlocBuilder<SliverBloc, bool>(
        builder: (context, state) => Container(
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      BlocBuilder<SliverBloc, bool>(
                        bloc: sliverBloc,
                        builder: (context, state) => IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).brightness ==
                                        Brightness.dark &&
                                    state == true
                                ? Colors.white
                                : Theme.of(context).brightness ==
                                            Brightness.dark &&
                                        state == false
                                    ? Colors.white
                                    : Theme.of(context).brightness ==
                                                Brightness.light &&
                                            state == true
                                        ? Colors.black
                                        : Colors.white,
                          ),
                          onPressed: () => Modular.to.pop(),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      state
                          ? Text(
                              'My Beautiful Fiance',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          : Container(),
                    ],
                  ),
                ),
                BlocBuilder<SliverBloc, bool>(
                  builder: (context, state) => IconButton(
                    icon: Icon(
                      Icons.cloud_download,
                      color: Theme.of(context).brightness == Brightness.dark &&
                              state == true
                          ? Colors.white
                          : Theme.of(context).brightness == Brightness.dark &&
                                  state == false
                              ? Colors.white
                              : Theme.of(context).brightness ==
                                          Brightness.light &&
                                      state == true
                                  ? Colors.black
                                  : Colors.white,
                    ),
                    onPressed: () => Modular.to.pushNamed(
                      '/downloadmanga',
                      arguments: {
                        "image": image,
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          width: width,
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: 8.0,
          ),
          decoration: BoxDecoration(
            color: state
                ? Theme.of(context).textSelectionColor
                : Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: state ? Colors.grey : Colors.transparent,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverContent extends StatelessWidget {
  const SliverContent({
    Key key,
    @required this.width,
    this.setState,
  }) : super(key: key);

  final Function setState;

  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: TabContainer(width: width, setState: setState),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ContentManga(width: width),
          childCount: 1,
        ),
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key key,
    @required this.widget,
    @required this.width,
  }) : super(key: key);

  final DetailManga widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  widget.tag,
                ),
              ),
            ),
            child: BlocBuilder<BlurBloc, double>(
              builder: (context, state) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: state, sigmaY: state),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(.4),
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: 20.0,
          right: 20.0,
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                StatusManga(text: 'Tamat'),
                TitleManga(text: 'Kukuh Nolep'),
                AuthorManga(text: 'Wibu Nolep'),
                RatingManga(value: '4.7'),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ContentManga extends StatelessWidget {
  ContentManga({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;
  var index = 0;
  var widgetList = [
    TabOverview(),
    TabChapters(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, state) {
        index = DefaultTabController.of(context).index;
        Modular.get<ScrollBloc>()
            .add(state.biggest.height >= MediaQuery.of(context).size.height);
        return widgetList[index];
      },
    );
  }
}

class TabContainer extends StatelessWidget {
  const TabContainer({
    Key key,
    @required this.width,
    this.setState,
  }) : super(key: key);

  final double width;
  final Function setState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 56.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).textSelectionHandleColor.withOpacity(.2),
          ),
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).primaryColor
            : Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabBar(
            onTap: (state) {
              setState(() {});
            },
            isScrollable: true,
            indicatorColor: Theme.of(context).textSelectionHandleColor,
            labelPadding: EdgeInsets.only(
              bottom: 10,
              left: 20,
              right: 20,
              top: 10,
            ),
            tabs: [
              Tab(
                child: Text(
                  'Overview',
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).textSelectionHandleColor,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Chapters',
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).textSelectionHandleColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width),
              child: Material(
                child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingManga extends StatelessWidget {
  const RatingManga({
    Key key,
    this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 15,
          ),
          SizedBox(width: 4.0),
          Text(
            value,
            style: GoogleFonts.heebo(
              fontSize: 13.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorManga extends StatelessWidget {
  const AuthorManga({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      'By $text',
      style: GoogleFonts.heebo(
        fontSize: 14.0,
        color: Colors.white60,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class TitleManga extends StatelessWidget {
  const TitleManga({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.heebo(
        fontSize: 24.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class StatusManga extends StatelessWidget {
  const StatusManga({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: text.toLowerCase() != 'ongoing' ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(5.6),
      ),
      child: Text(
        text,
        style: GoogleFonts.heebo(fontSize: 13.0, color: Colors.white),
      ),
    );
  }
}
