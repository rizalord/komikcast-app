import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/bloc/blur_bloc.dart';
import 'package:komikcast/bloc/chapter_readed_bloc.dart';
import 'package:komikcast/bloc/download_bloc.dart';
import 'package:komikcast/bloc/favorite_bloc.dart';
import 'package:komikcast/bloc/reverse_chapter_bloc.dart';
import 'package:komikcast/bloc/scroll_bloc.dart';
import 'package:komikcast/bloc/sliver_bloc.dart';
import 'package:komikcast/bloc/theme_bloc.dart';
import 'package:komikcast/bloc/history_bloc.dart';
import 'package:komikcast/ui/main_pages.dart';
import 'package:komikcast/ui/main_setting.dart';
import 'package:komikcast/ui/manga_pages/detail_manga_page.dart';
import 'package:komikcast/ui/manga_pages/download_manga_page.dart';
import 'package:komikcast/ui/manga_pages/read_manga_page.dart';
import 'package:komikcast/ui/other_pages/download_setting.dart';
import 'package:komikcast/ui/other_pages/last_readed_page.dart';
import 'package:komikcast/ui/other_pages/qna_page.dart';
import 'package:komikcast/ui/other_pages/search_page.dart';
import 'package:komikcast/ui/pro_screen.dart';
import 'package:komikcast/ui/splash_screen.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((_) => ThemeBloc()),
        Bind((_) => SliverBloc()),
        Bind((_) => BlurBloc()),
        Bind((_) => ScrollBloc()),
        Bind((_) => ReverseChapterBloc()),
        Bind((_) => HistoryBloc()),
        Bind((_) => FavoriteBloc()),
        Bind((_) => ChapterReadedBloc()),
        Bind((_) => DownloadBloc()),
      ];

  @override
  List<Router> get routers => [
        Router(
          '/',
          child: (_, args) => SplashScreen(),
        ),
        Router(
          '/main',
          child: (_, args) => MainPage(),
          transition: TransitionType.rightToLeftWithFade,
        ),
        Router(
          '/search/:query',
          child: (_, args) => SearchPage(query: args.params['query']),
          transition: TransitionType.rightToLeftWithFade,
        ),
        Router(
          '/downset',
          child: (_, args) => DownloadSetting(),
        ),
        Router(
          '/setting',
          child: (_, args) => MainSettingPage(),
        ),
        Router(
          '/qna',
          child: (_, args) => QnAPage(),
        ),
        Router(
          '/detailmanga',
          child: (_, args) => DetailManga(
            image: args.data['image'],
            title: args.data['title'],
            linkId: args.data['linkId'],
          ),
        ),
        Router(
          '/downloadmanga',
          child: (_, args) => DownloadMangaPage(
            detail: args.data['detail'],
          ),
        ),
        Router(
          '/readmanga',
          child: (_, args) => ReadMangaPage(
            mangaId: args.data['mangaId'],
            currentId: args.data['currentId'],
          ),
          transition: TransitionType.rightToLeft,
        ),
        Router(
          '/pro',
          child: (_, args) => ProScreen(),
          transition: TransitionType.rightToLeft,
        ),
        Router(
          '/lastreaded',
          child: (_, args) => LastReadedPage(),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
