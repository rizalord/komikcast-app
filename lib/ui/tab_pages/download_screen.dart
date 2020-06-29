import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadTabPage extends StatelessWidget {
  final int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return _itemCount != 0
        ? SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _itemCount,
                  itemBuilder: (context, index) => ListItem(width: width),
                ),
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/empty-download.png'),
                Padding(
                  padding: EdgeInsets.only(bottom: 22.0),
                  child: Text(
                    'Belum ada yang Didownload',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  'Kamu belum download apapun.',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5,
                  ),
                ),
                Text(
                  'Baca manga sekarang, dan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5,
                  ),
                ),
                Text(
                  'download manga yang menarik',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5,
                  ),
                ),
                Text(
                  'bagimu.',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        height: width * .22,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://komikcast.com/wp-content/uploads/2019/08/40dokuzura479-212x300.jpg',
              width: width * .22,
              height: width * .22,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).primaryColor.withOpacity(.1)
                          : Theme.of(context)
                              .textSelectionHandleColor
                              .withOpacity(.1),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dokuzakura',
                      style: GoogleFonts.heebo(
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'MITA, Yamamoto Yamii',
                      style: GoogleFonts.heebo(
                        fontSize: 13,
                        color: Theme.of(context)
                            .textSelectionHandleColor
                            .withOpacity(.75),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Diunduh tanggal 28 Juni 2020',
                      style: GoogleFonts.heebo(
                        fontSize: 13,
                        color: Theme.of(context)
                            .textSelectionHandleColor
                            .withOpacity(.75),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
