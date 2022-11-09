import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_bloc.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_events.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_states.dart';
import 'package:watch/modules/movies/presentation/screens/movies_screen.dart';

import '../../../../core/services/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(children: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MoviesScreen();
                }));
              },
              child: Icon(
                Icons.add,
                size: 100,
              ),
            ),
          ]),
        ));
  }
}
