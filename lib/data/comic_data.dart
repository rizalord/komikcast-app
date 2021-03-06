import 'dart:convert';

import 'package:komikcast/env.dart';
import 'package:http/http.dart' as http;
import 'package:komikcast/models/comic_v1.dart';
import 'package:komikcast/models/comic_v2.dart';
import 'package:komikcast/models/comic_v3.dart';
import 'package:komikcast/models/detail_chapter.dart';
import 'package:komikcast/models/detail_comic.dart';
import 'package:komikcast/models/other_comic.dart';
import 'package:komikcast/models/search_result.dart';

class ComicData {
  // USED TO GET DATA FROM HOMEPAGE
  static getHomeData() async {
    final response = await http.get(Env.apiUrl);
    List<ComicV1> hotComic = json
        .decode(response.body)['hot_comic']
        .map<ComicV1>((e) => ComicV1.fromJson(e))
        .toList();
    List<ComicV2> projectComic = json
        .decode(response.body)['project_comic']
        .map<ComicV2>((e) => ComicV2.fromJson(e))
        .toList();
    List<ComicV3> latestChapter = json
        .decode(response.body)['latest_chapter']
        .map<ComicV3>((e) => ComicV3.fromJson(e))
        .toList();

    return {
      "hotComic": hotComic,
      "projectComic": projectComic,
      "latestChapter": latestChapter,
    };
  }

  // USED TO GET DETAIL KOMIK BY ID PARAMS
  static Future<DetailComic> getDetailKomik({id}) async {
    final response =
        json.decode((await http.get('${Env.apiUrl}komik?id=$id')).body)['data'];
    return DetailComic.fromJson(response);
  }

  // USED TO GET IMAGES BY ID CHAPTER
  static Future<DetailChapter> getChapterKomik({id}) async {
    final response = json
        .decode((await http.get('${Env.apiUrl}chapter?id=$id')).body)['data'];
    return DetailChapter.fromJson(response);
  }

  // USED TO GET ALL COMIC
  static getAllKomik({int page}) async {
    final List response = json.decode(
        (await http.get('${Env.apiUrl}daftar-komik?page=$page'))
            .body)['daftar_komik'];

    return response.map<SearchResult>((e) => SearchResult.fromJson(e)).toList();
  }

  // USED TO GET SPECIFIC COMIC
  static getSpecificComic({String keyword, int page}) async {
    List response = [];
    try {
      response = json.decode(
          (await http.get('${Env.apiUrl}search?keyword=$keyword&page=$page'))
              .body)['results'];
    } catch (e) {}

    return response.map<SearchResult>((e) => SearchResult.fromJson(e)).toList();
  }

  // Get Others
  static getChapterTerbaru({int page}) async {
    final List response = json.decode(
        (await http.get('${Env.apiUrl}daftar-komik?page=$page&order=update'))
            .body)['daftar_komik'];

    return response.map<OtherComic>((e) => OtherComic.fromJson(e)).toList();
  }

  static getProjectTerbaru({int page}) async {
    final List response = json.decode(
        (await http.get('${Env.apiUrl}project-list?page=$page'))
            .body)['daftar_komik'];

    return response.map<OtherComic>((e) => OtherComic.fromJson(e)).toList();
  }
}
