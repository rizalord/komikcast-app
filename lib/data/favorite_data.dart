import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/bloc/favorite_bloc.dart';

class FavoriteData {
  static saveFavorite({
    String mangaId,
    String currentId,
    String detailChapter,
    String image,
    String title,
    String type,
  }) async {
    // Open DB
    // ============================
    var db = Hive.box('komikcast');

    // Get Values
    // ============================
    List listFavorite = db.get('favorite') != null ? db.get('favorite') : [];
    listFavorite = listFavorite.cast<Map>();

    // Store Favorite to DB
    // ============================
    var favorite = {
      'image': image,
      'title': title,
      'mangaId': mangaId,
      'chapterId': currentId,
      'chapterName': detailChapter,
      'type': type,
    };

    listFavorite.add(favorite);
    db.put('favorite', listFavorite);

    // Store Favorite to Bloc
    // ================================
    Modular.get<FavoriteBloc>().add(listFavorite);
  }

  static unsaveFavorite({
    String mangaId,
  }) async {
    // Open DB
    // ============================
    var db = Hive.box('komikcast');

    // Get Values
    // ============================
    List listFavorite = db.get('favorite') != null ? db.get('favorite') : [];
    listFavorite = listFavorite.cast<Map>();

    // Remove Saved Favorite
    listFavorite =
        listFavorite.where((element) => element['mangaId'] != mangaId).toList();
    listFavorite = listFavorite.cast<Map>();

    // Restore to DB
    db.put('favorite', listFavorite);

    // Store Favorite to Bloc
    // ================================
    Modular.get<FavoriteBloc>().add(listFavorite);
  }
}
