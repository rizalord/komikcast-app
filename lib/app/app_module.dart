import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/bloc/blur_bloc.dart';
import 'package:komikcast/bloc/scroll_bloc.dart';
import 'package:komikcast/bloc/sliver_bloc.dart';
import 'package:komikcast/bloc/theme_bloc.dart';
import 'package:komikcast/ui/main_pages.dart';
import 'package:komikcast/ui/main_setting.dart';
import 'package:komikcast/ui/manga_pages/detail_manga_page.dart';
import 'package:komikcast/ui/other_pages/download_setting.dart';
import 'package:komikcast/ui/other_pages/qna_page.dart';
import 'package:komikcast/ui/other_pages/search_page.dart';
import 'package:komikcast/ui/splash_screen.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((_) => ThemeBloc()),
        Bind((_) => SliverBloc()),
        Bind((_) => BlurBloc()),
        Bind((_) => ScrollBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SplashScreen()),
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
        Router('/downset', child: (_, args) => DownloadSetting()),
        Router('/setting', child: (_, args) => MainSettingPage()),
        Router('/qna', child: (_, args) => QnAPage()),
        Router(
          '/detailmanga',
          child: (_, args) => DetailManga(tag: args.data),
          transition: TransitionType.downToUp,
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
