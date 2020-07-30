import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komikcast/data/download_data.dart';
import 'package:komikcast/models/detail_comic.dart';

class DownloadMangaPage extends StatefulWidget {
  DownloadMangaPage({this.detail});

  final DetailComic detail;

  @override
  _DownloadMangaPageState createState() => _DownloadMangaPageState();
}

class _DownloadMangaPageState extends State<DownloadMangaPage> {
  List<SingleChapterDetail> _checkedList = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void checkAll() {
    setState(() {
      if (_checkedList == widget.detail.listChapters) {
        _checkedList = [];
      } else {
        _checkedList = [];
        _checkedList = widget.detail.listChapters;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('0 dipilih'),
        actions: [
          InkWell(
            onTap: checkAll,
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
            itemCount: widget.detail.listChapters.length,
            padding: EdgeInsets.only(bottom: width * .21),
            itemBuilder: (context, idx) => InkWell(
              onTap: () {},
              child: CheckboxListTile(
                  title: Text(
                    'Chapter ${widget.detail.listChapters[idx].chapter}',
                    style: GoogleFonts.heebo(),
                  ),
                  onChanged: (bool value) {
                    setState(() {
                      _checkedList.indexOf(widget.detail.listChapters[idx]) >= 0
                          ? _checkedList.removeAt(_checkedList
                              .indexOf(widget.detail.listChapters[idx]))
                          : _checkedList.add(widget.detail.listChapters[idx]);
                    });
                  },
                  value:
                      _checkedList.indexOf(widget.detail.listChapters[idx]) >=
                          0),
            ),
          ),
          DownloadButton(
            width: width,
            detail: widget.detail,
            data: _checkedList,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.dispose();
  }
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key key,
    @required this.width,
    @required this.detail,
    this.data,
  }) : super(key: key);

  final double width;
  final DetailComic detail;
  final List<SingleChapterDetail> data;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              borderRadius: BorderRadius.circular(9),
              child: CachedNetworkImage(
                imageUrl: detail.image,
                fit: BoxFit.cover,
                width: width * .145,
                height: width * .145,
              ),
            ),
          ),
          title: Text(
            'Unduh ${data.length} Chapter dari',
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
              detail.title,
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
                onTap: () => DownloadData().downloadChapter(
                  context: context,
                  data: detail,
                  listData: data,
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                  child: Text(
                    'Unduh',
                    style: GoogleFonts.heebo(
                      color: Theme.of(context).brightness == Brightness.light
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
    );
  }
}
