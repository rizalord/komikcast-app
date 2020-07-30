import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:komikcast/bloc/chapter_readed_bloc.dart';
import 'package:komikcast/bloc/downloaded_bloc.dart';
import 'package:komikcast/bloc/favorite_bloc.dart';
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
    this.themeInit(db: db);
    this.historyInit(db: db);
    this.favoriteInit(db: db);
    this.chapterReadedInit(db: db);
    this.downloadsInit();

    // END CHECK
    Modular.to.pushReplacementNamed('/main');
  }

  /**
   * METHODS TO INITIALIZE DATA
   * =============================================
   * =============================================
   */

  void themeInit({Box db}) {
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

      // Get Image Thumbnail
      var imageThumbnail = Directory(element.path)
          .listSync()[Directory(element.path).listSync().length - 2]
          .path;

      // Read detail.txt
      var detailTxtPath = Directory(element.path)
          .listSync()[Directory(element.path).listSync().length - 1]
          .path;
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
  }
}
