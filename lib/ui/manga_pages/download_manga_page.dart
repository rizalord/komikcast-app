import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadMangaPage extends StatefulWidget {
  DownloadMangaPage({this.image});

  final String image;

  @override
  _DownloadMangaPageState createState() => _DownloadMangaPageState();
}

class _DownloadMangaPageState extends State<DownloadMangaPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('0 dipilih'),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Pilih semua',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 5,
            itemBuilder: (context, idx) => InkWell(
              onTap: () {},
              child: CheckboxListTile(
                title: Text(
                  'Chapter $idx',
                  style: GoogleFonts.heebo(),
                ),
                onChanged: (bool value) {},
                value: idx == 0 ? true : false,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: width * .21,
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      fit: BoxFit.cover,
                      width: width * .145,
                      height: width * .145,
                    ),
                  ),
                ),
                title: Text(
                  'Unduh 0 Chapter dari',
                  style: GoogleFonts.heebo(
                    color: Colors.grey[300],
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    'The Savior\'s book cafe in another world',
                    style: GoogleFonts.heebo(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 7.0),
                        child: Text(
                          'Unduh',
                          style: GoogleFonts.heebo(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
