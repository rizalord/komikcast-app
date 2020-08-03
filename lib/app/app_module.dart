import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/bloc/blur_bloc.dart';
import 'package:komikcast/bloc/chapter_readed_bloc.dart';
import 'package:komikcast/bloc/download_bloc.dart';
import 'package:komikcast/bloc/download_setting_bloc.dart';
import 'package:komikcast/bloc/downloaded_bloc.dart';
import 'package:komikcast/bloc/downloaded_chapter_bloc.dart';
import 'package:komikcast/bloc/favorite_bloc.dart';
import 'package:komikcast/bloc/pro_bloc.dart';
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
import 'package:komikcast/ui/other_pages/downloaded_chapter.dart';
import 'package:komikcast/ui/other_pages/home_other_page.dart';
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
        Bind((_) => DownloadedBloc()),
        Bind((_) => DownloadedChapterBloc()),
        Bind((_) => ProBloc()),
        Bind((_) => DownloadSettingBloc()),
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
          '/search',
          child: (_, args) => SearchPage(),
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
            downloadData: args.data['downloadData'],
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
        Router(
          '/downloadedchapter',
          child: (_, args) => DownloadedChapterScreen(
            title: args.data['title'],
            folderPath: args.data['folderPath'],
          ),
        ),
        Router(
          '/homeother',
          child: (_, args) => HomeOtherScreen(
            appBarTitle: args.data['title'],
          ),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
