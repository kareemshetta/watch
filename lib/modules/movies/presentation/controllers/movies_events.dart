import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
  @override
  List<Object> get props {
    return [];
  }
}

class GetNowPlayingMoviesEvent extends MoviesEvent {}

class GetTopRatedMoviesEvent extends MoviesEvent {}

class GetClearSearchedListEvent extends MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent {}

class GetSearchForMovieMoviesEvent extends MoviesEvent {
  final String movieName;
  const GetSearchForMovieMoviesEvent(this.movieName);
}
