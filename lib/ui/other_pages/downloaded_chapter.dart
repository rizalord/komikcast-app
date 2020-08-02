import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

class DownloadedChapterScreen extends StatelessWidget {
  DownloadedChapterScreen({
    this.title,
    this.folderPath,
  });

  final String title;
  final String folderPath;

  @override
  Widget build(BuildContext context) {
    final rootPath = Directory(folderPath)
        .listSync()
        .where((element) =>
            !element.path.contains('cover.jpg') &&
            !element.path.contains('cover.jpeg') &&
            !element.path.contains('cover.png') &&
            !element.path.contains('detail.txt'))
        .toList()
        .map((e) {
      var detailChapter = {};
      detailChapter['folderPath'] = e.path;
      detailChapter['title'] =
          e.path.split('chapter-').last.split('-bahasa-indonesia').first.trim();
      detailChapter['is_expired'] = Hive.box('komikcast')
                  .get('is_download_permanent', defaultValue: false) ==
              true
          ? false
          : e.statSync().modified.millisecondsSinceEpoch + 1296000000 <
              DateTime.now().millisecondsSinceEpoch;
      return detailChapter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: rootPath
            .map(
              (e) => e['is_expired'] == false
                  ? Material(
                      child: InkWell(
                        child: ListTile(
                          title: Text('Chapter ' + e['title']),
                          contentPadding: EdgeInsets.only(
                            bottom: 10,
                            left: 16.0,
                            right: 16.0,
                          ),
                          trailing:
                              Icon(Icons.check_circle, color: Colors.green),
                        ),
                        onTap: () {
                          Modular.to.pushNamed('/readmanga', arguments: {
                            'downloadData': {
                              'downloadPath': e['folderPath'],
                              'title':
                                  'Chapter ' + e['title'] + ' Bahasa Indonesia',
                            }
                          });
                        },
                      ),
                    )
                  : Stack(
                      children: [
                        ListTile(
                          title: Text(
                            'Chapter ' + e['title'],
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.2),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                            bottom: 10,
                            left: 16.0,
                            right: 16.0,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.6),
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionColor
                                      .withOpacity(.3),
                                  width: 1,
                                ),
                                top: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionColor
                                      .withOpacity(.3),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.lock_outline,
                                color: Theme.of(context).textSelectionColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            )
            .toList(),
      ),
    );
  }
}
