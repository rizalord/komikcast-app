import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/bloc/chapter_readed_bloc.dart';
import 'package:komikcast/bloc/reverse_chapter_bloc.dart';
import 'package:komikcast/bloc/scroll_bloc.dart';
import 'package:komikcast/data/chapter_readed_data.dart';
import 'package:komikcast/models/detail_comic.dart';

class TabChapters extends StatefulWidget {
  final DetailComic detail;
  final String mangaId;

  TabChapters({
    this.detail,
    this.mangaId,
  });

  @override
  _TabChaptersState createState() => _TabChaptersState();
}

class _TabChaptersState extends State<TabChapters> {
  var controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels == 0.0) {
        Future.delayed(Duration(seconds: 0), () {
          Modular.get<ScrollBloc>().add(false);
        });
      }

      if (controller.position.atEdge && controller.position.pixels != 0.0) {
        Future.delayed(Duration(seconds: 0), () {
          Modular.get<ScrollBloc>().add(false);
        });
      }
    });
  }

  bool onScroll(t) {
    if (t is ScrollEndNotification) {
      Future.delayed(Duration(seconds: 0), () {
        Modular.get<ScrollBloc>().add(false);
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ScrollBloc, ScrollPhysics>(
      builder: (context, state) {
        return NotificationListener(
          onNotification: onScroll,
          child: SingleChildScrollView(
            controller: controller,
            physics: state,
            child: BlocBuilder<ReverseChapterBloc, bool>(
              builder: (ctx, reverse) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: width,
                    height: kToolbarHeight - 10,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context)
                              .textSelectionHandleColor
                              .withOpacity(.2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            '${widget.detail.listChapters.length} Chapters',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.6),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.swap_vert,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.6),
                            ),
                            onPressed: () =>
                                Modular.get<ReverseChapterBloc>().add(!reverse),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: BlocBuilder<ChapterReadedBloc, List<String>>(
                        builder: (context, state) => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: reverse,
                          itemCount: widget.detail.listChapters.length,
                          itemBuilder: (context, idx) {
                            var isReaded = state.indexOf(
                                    widget.detail.listChapters[idx].linkId) >=
                                0;

                            return InkWell(
                              onTap: () => Modular.to.pushNamed(
                                '/readmanga',
                                arguments: {
                                  'mangaId': widget.mangaId,
                                  'currentId':
                                      widget.detail.listChapters[idx].linkId,
                                },
                              ),
                              child: Container(
                                width: width,
                                height: kToolbarHeight + 10,
                                decoration: BoxDecoration(
                                  color: isReaded
                                      ? Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Theme.of(context)
                                              .textSelectionHandleColor
                                              .withOpacity(.03)
                                          : Theme.of(context).textSelectionColor.withOpacity(.2)
                                      : Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Theme.of(context).textSelectionColor
                                          : Colors.transparent,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor
                                          .withOpacity(.1),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'Chapter ' +
                                            widget.detail.listChapters[idx]
                                                .chapter
                                                .toString(),
                                        style:
                                            GoogleFonts.poppins(fontSize: 14.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 20.0),
                                      child: Text(
                                        widget.detail.listChapters[idx]
                                            .timeRelease
                                            .toString(),
                                        style:
                                            GoogleFonts.poppins(fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
