import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/bloc/chapter_readed_bloc.dart';

class ChapterReadedData {
  static saveChapter({String chapterId}) {
    // Open DB
    // ============================
    var db = Hive.box('komikcast');

    // Get Values
    // ============================
    List listChapterReaded =
        db.get('chapterReaded') != null ? db.get('chapterReaded') : [];
    listChapterReaded = listChapterReaded.cast<String>();

    // Store Chapter Readed to DB
    // ============================

    if (listChapterReaded.indexOf(chapterId) >= 0) {
      listChapterReaded.removeAt(listChapterReaded.indexOf(chapterId));
    }

    listChapterReaded.add(chapterId);
    db.put('chapterReaded', listChapterReaded);

    // Store Chapter to Bloc
    // ================================
    Modular.get<ChapterReadedBloc>().add(listChapterReaded);
  }
}
