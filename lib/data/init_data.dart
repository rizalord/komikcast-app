import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:komikcast/bloc/chapter_readed_bloc.dart';
import 'package:komikcast/bloc/download_setting_bloc.dart';
import 'package:komikcast/bloc/downloaded_bloc.dart';
import 'package:komikcast/bloc/downloaded_chapter_bloc.dart';
import 'package:komikcast/bloc/favorite_bloc.dart';
import 'package:komikcast/bloc/pro_bloc.dart';
import 'package:komikcast/bloc/theme_bloc.dart';
import 'package:komikcast/bloc/history_bloc.dart';
import 'package:path_provider/path_provider.dart';

class KomikcastSystem {
  // This method called when app has not been initialized
  Future<void> initData(context) async {
    // showDialog(
    //   context: context,
    //   builder: (_) => AlertDialog(
    //     content: ListTile(
    //       title: Text('Getting data...'),
    //       leading: SizedBox(
    //         height: 30,
    //         width: 30,
    //         child: CircularProgressIndicator(),
    //       ),
    //     ),
    //   ),
    // );

    // OPEN DB
    // ===============================
    var db = Hive.box('komikcast');

    // Initialize State
    var isPro = this.proInit(db: db);

    this.themeInit(db: db, isPro: isPro);
    this.historyInit(db: db);
    this.favoriteInit(db: db);
    this.chapterReadedInit(db: db);
    this.downloadPermInit(db: db, isPro: isPro);
    this.downloadsInit();

    // END CHECK
    Modular.to.pushReplacementNamed('/main');
  }

  // ignore: slash_for_doc_comments
  /**
   * METHODS TO INITIALIZE DATA
   * =============================================
   * =============================================
   */

  void themeInit({Box db, bool isPro = false}) {
    if (isPro == false) db.put('theme', 'light');
    var theme = db.get('theme') == null ? 'light' : db.get('theme');
    db.put('theme', theme);
    Modular.get<ThemeBloc>()
        .add(theme == 'light' ? ThemeMode.light : ThemeMode.dark);
  }

  void historyInit({Box db}) {
    List historyList = db.get('history') == null ? [] : db.get('history');
    Modular.get<HistoryBloc>().add(historyList.cast<Map>());
  }

  void chapterReadedInit({Box db}) {
    List chapterReadedList =
        db.get('chapterReaded') == null ? [] : db.get('chapterReaded');
    Modular.get<ChapterReadedBloc>().add(chapterReadedList.cast<String>());
  }

  void favoriteInit({Box db}) {
    List favoriteList = db.get('favorite') == null ? [] : db.get('favorite');
    Modular.get<FavoriteBloc>().add(favoriteList.cast<Map>());
  }

  void downloadsInit() async {
    final directory = (await getExternalStorageDirectory()).path;
    List<Map> tempAll = [];
    List<Map> allChapter = [];

    // Get All Comic
    Directory(directory).listSync().forEach((element) {
      var tempComicFolder = {};

      tempComicFolder['title'] = element.path
          .replaceAll('$directory/', '')
          .split('-')
          .map((e) => e[0].toUpperCase() + e.substring(1))
          .join(' ');

      tempComicFolder['mangaId'] = element.path.replaceAll('$directory/', '');
      tempComicFolder['folderPath'] = element.path;

      var chapterFolder = Directory(element.path).listSync();
      chapterFolder = chapterFolder
          .where((element) =>
              element.path.contains('cover.jpg') == false &&
              element.path.contains('cover.jpeg') == false &&
              element.path.contains('cover.png') == false &&
              element.path.contains('detail.txt') == false)
          .toList();

      // Get All Chapter
      for (var i = 0; i < chapterFolder.length; i++) {
        var tempChapter = {};
        tempChapter['chapterId'] =
            chapterFolder[i].path.replaceAll(element.path, '');
        tempChapter['chapterIdPath'] = chapterFolder[i].path;
        tempChapter['images'] = Directory(chapterFolder[i].path)
            .listSync()
            .map((e) => e.path)
            .toList()
            .cast<String>();

        allChapter.add(tempChapter);
      }

      var detailFolder = Directory(element.path).listSync();
      detailFolder = detailFolder
          .where((element) =>
              element.path.contains('cover.jpg') ||
              element.path.contains('cover.jpeg') ||
              element.path.contains('cover.png') ||
              element.path.contains('detail.txt'))
          .toList();

      // Get Image Thumbnail
      var imageThumbnail = detailFolder[0].path;

      // Read detail.txt
      var detailTxtPath = detailFolder.last.path;

      String author;

      try {
        final File file = File(detailTxtPath);
        author = file.readAsStringSync();
      } catch (e) {}

      tempComicFolder['imagePath'] = imageThumbnail;
      tempComicFolder['author'] = author;
      tempComicFolder['dateModified'] = DateFormat('d MMMM yyyy')
          .format(Directory(element.path).listSync().last.statSync().modified);
      tempAll.add(tempComicFolder);
    });

    // Save to BLOC
    Modular.get<DownloadedBloc>().add(tempAll);
    Modular.get<DownloadedChapterBloc>().add(allChapter);
  }

  bool proInit({Box db}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int expiredTime = db.get('pro_expired_date', defaultValue: currentTime);
    // Modular.get<ProBloc>().add(expiredTime > currentTime);
    Modular.get<ProBloc>().add(true);
    // return expiredTime > currentTime;
    return true;
  }

  void downloadPermInit({Box db, bool isPro = false}) {
    if (isPro == false) db.put('is_download_permanent', false);
    Modular.get<DownloadSettingBloc>()
        .add(db.get('is_download_permanent', defaultValue: false));
  }
}
