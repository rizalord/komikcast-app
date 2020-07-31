import 'dart:io';

import 'package:flutter/material.dart';

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
            !element.path.contains('detail.txt'))
        .toList()
        .map((e) {
      var detailChapter = {};
      detailChapter['folderPath'] = e.path;
      detailChapter['title'] =
          e.path.split('chapter-').last.split('-bahasa-indonesia').first.trim();
      return detailChapter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: rootPath
            .map((e) => Material(
                  child: InkWell(
                    child: ListTile(
                      title: Text('Chapter ' + e['title']),
                      contentPadding: EdgeInsets.only(
                        bottom: 10,
                        left: 16.0,
                        right: 16.0,
                      ),
                      trailing: Icon(Icons.check_circle, color: Colors.green),
                    ),
                    onTap: () {},
                  ),
                ))
            .toList(),
      ),
    );
  }
}
