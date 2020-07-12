import 'dart:convert';

import 'package:komikcast/env.dart';
import 'package:http/http.dart' as http;
import 'package:komikcast/models/comic_v1.dart';
import 'package:komikcast/models/comic_v2.dart';
import 'package:komikcast/models/comic_v3.dart';
import 'package:komikcast/models/detail_comic.dart';

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
  static getDetailKomik({id}) async {
    final response =
        json.decode((await http.get('${Env.apiUrl}komik?id=$id')).body)['data'];
    return DetailComic.fromJson(response);
  }
}
