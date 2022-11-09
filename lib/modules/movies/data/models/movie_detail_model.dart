import 'package:watch/modules/movies/data/models/genre_model.dart';
import 'package:watch/modules/movies/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetailed {
  const MovieDetailModel(
      {required super.releaseDate,
      required super.runTime,
      required super.backdropPath,
      required super.title,
      required super.overview,
      required super.voteAverage,
      required super.genre,
      required super.id});

  factory MovieDetailModel.fromJson(dynamic json) {
    final releaseDate = json['release_date'];
    final runTime = json['runtime'];
    final title = json['title'];
    final backdropPath = json['backdrop_path'];
    // final genre =
    //     (json['genres'] as List).map((e) => GenreModel.fromJson(e)).toList();
    final genre =
        List.from(json['genres']).map((e) => GenreModel.fromJson(e)).toList();
    print('genres$genre');
    final overview = json['overview'];
    final id = json['id'];
    final voteAverage = json['vote_average'];
    return MovieDetailModel(
        releaseDate: releaseDate,
        runTime: runTime,
        backdropPath: backdropPath,
        title: title,
        overview: overview,
        voteAverage: voteAverage,
        genre: genre,
        id: id);
  }
}
