import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/bloc/scroll_bloc.dart';

class TabChapters extends StatefulWidget {
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
            child: Column(
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
                          '22 Chapters',
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
                          onPressed: () {},
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
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, idx) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            width: width,
                            height: kToolbarHeight + 10,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionHandleColor
                                      .withOpacity(.1),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Chapter $idx',
                                    style: GoogleFonts.poppins(fontSize: 14.0),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    '3 hours ago',
                                    style: GoogleFonts.poppins(fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            // child: ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: 5,
            //   itemBuilder: (context, idx) {
            // return Container(
            //   width: width,
            //   height: width * .5,
            //   color: Colors.white,
            //   margin: EdgeInsets.only(bottom: 10),
            // );
            //   },
            // ),
          ),
        );
      },
    );
  }
}
