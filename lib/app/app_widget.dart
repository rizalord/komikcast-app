import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:komikcast/app/app_theme.dart';
import 'package:komikcast/bloc/blur_bloc.dart';
import 'package:komikcast/bloc/sliver_bloc.dart';
import 'package:komikcast/bloc/theme_bloc.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => Modular.get<ThemeBloc>()),
        BlocProvider<SliverBloc>(create: (context) => Modular.get<SliverBloc>()),
        BlocProvider<BlurBloc>(create: (context) => Modular.get<BlurBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, currentTheme) => MaterialApp(
          initialRoute: "/",
          onGenerateRoute: Modular.generateRoute,
          navigatorKey: Modular.navigatorKey,
          themeMode: currentTheme,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
        ),
      ),
    );
  }
}
