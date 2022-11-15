import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/core/services/service_locator.dart';
import 'package:watch/core/utils/app_string.dart';
import 'package:watch/modules/movies/domain/entities/movie.dart';
import 'package:watch/modules/movies/presentation/screens/home_screen.dart';
import 'package:watch/modules/movies/presentation/screens/movies_screen.dart';

import 'modules/movies/presentation/controllers/bloc_observer.dart';

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
    return MaterialApp(
      title: AppString.appTitle,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Colors.grey.shade900),
      home: const MoviesScreen(),
    );
  }
}
