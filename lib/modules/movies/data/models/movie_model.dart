import 'package:watch/modules/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.id,
      required super.title,
      super.backdropPath,
      required super.genreIds,
      required super.overview,
      required super.voteAverage,
      required super.releaseDate});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final backdropPath =
        json['backdrop_path'] ?? '/xGl7uzt0JX8u2WCIKK4e9Sk5Rat.jpg';
    final ids = ((json['genre_ids']) as List<dynamic>).cast<int>();
    final genreIds = ids;
    final overview = json['overview'];
    final voteAverage = getDouble(json['vote_average']);
    final releaseDate = json['release_date'];
    return MovieModel(
        id: id,
        title: title,
        backdropPath: backdropPath,
        genreIds: genreIds,
        overview: overview,
        voteAverage: voteAverage,
        releaseDate: releaseDate);
  }
}

double getDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is int) {
    return value.toDouble();
  } else {
    return value;
  }
}
