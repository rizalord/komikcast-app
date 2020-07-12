import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/bloc/scroll_bloc.dart';
import 'package:komikcast/models/detail_comic.dart';

class TabOverview extends StatefulWidget {
  final DetailComic detail;

  TabOverview({this.detail});

  @override
  _TabOverviewState createState() => _TabOverviewState();
}

class _TabOverviewState extends State<TabOverview> {
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
    return BlocBuilder<ScrollBloc, ScrollPhysics>(
      builder: (context, state) {
        return NotificationListener(
          onNotification: onScroll,
          child: SingleChildScrollView(
            controller: controller,
            physics: state,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Genre',
                    style: GoogleFonts.heebo(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.detail.genres.join(', '),
                    style: GoogleFonts.heebo(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context)
                          .textSelectionHandleColor
                          .withOpacity(.5),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Sinopsis',
                    style: GoogleFonts.heebo(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.detail.sinopsis,
                    style: GoogleFonts.heebo(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).textSelectionHandleColor,
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    'Latest Chapter: Chapter 665',
                    style: GoogleFonts.heebo(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Divider(),
                  SizedBox(height: 4.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Updated on',
                              style: GoogleFonts.heebo(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.detail.updatedOn,
                              style: GoogleFonts.heebo(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300,
                                color:
                                    Theme.of(context).textSelectionHandleColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Released',
                              style: GoogleFonts.heebo(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.detail.released,
                              style: GoogleFonts.heebo(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300,
                                color:
                                    Theme.of(context).textSelectionHandleColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
