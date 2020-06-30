import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/bloc/theme_bloc.dart';
import 'package:komikcast/ui/download_setting.dart';
import 'package:komikcast/ui/main_pages.dart';
import 'package:komikcast/ui/main_setting.dart';
import 'package:komikcast/ui/search_page.dart';
import 'package:komikcast/ui/splash_screen.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
        Bind((_) => ThemeBloc()),
      ];

  // Provide all the routes for your module
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
          transition: TransitionType.rightToLeftWithFade
        ),
        Router('/downset', child: (_, args) => DownloadSetting()),
        Router('/setting', child: (_, args) => MainSettingPage()),
      ];

  // Provide the root widget associated with your module
  // In this case, it's the widget you created in the first step
  @override
  Widget get bootstrap => AppWidget();
}
