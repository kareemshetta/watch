import 'package:equatable/equatable.dart';

import 'geners.dart';

class MovieDetailed extends Equatable {
  final String backdropPath;
  final String title;
  final List<Genre> genre;
  final int id;
  final int runTime;
  final String releaseDate;
  final String overview;
  final double voteAverage;

  const MovieDetailed({
    required this.releaseDate,
    required this.runTime,
    required this.backdropPath,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genre,
    required this.id,
  });

  @override
  List<Object?> get props => [
        releaseDate,
        runTime,
        backdropPath,
        title,
        overview,
        voteAverage,
        genre,
        id
      ];
}
