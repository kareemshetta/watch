import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch/core/services/service_locator.dart';
import 'package:watch/core/utils/app_string.dart';
import 'package:watch/modules/movies/presentation/screens/movies_screen.dart';

import 'modules/movies/presentation/controllers/bloc_observer.dart';
import 'modules/movies/presentation/controllers/movies_bloc.dart';
import 'modules/movies/presentation/controllers/movies_events.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  ServiceLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
        create: (context) {
          return sl<MoviesBloc>()
            ..add(GetNowPlayingMoviesEvent())
            ..add(GetPopularMoviesEvent())
            ..add(GetTopRatedMoviesEvent());
        },
        child: MaterialApp(
          title: AppString.appTitle,
          theme: ThemeData.dark().copyWith(
              appBarTheme: AppBarTheme(
                color: Colors.black54,
                titleTextStyle: GoogleFonts.oleoScriptSwashCaps(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  letterSpacing: 1.5,
                ),
              ),
              colorScheme:
                  ColorScheme.fromSwatch(primaryColorDark: Colors.teal),
              progressIndicatorTheme: const ProgressIndicatorThemeData()
                  .copyWith(color: Colors.teal)),
          home: const MoviesScreen(),
        ));
  }
}
