import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

//new changes
abstract class MoviesState extends Equatable {
  const MoviesState();
}

class InitialMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class LoadingGetNowPlayingMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class GetNowPlayingMoviesSuccessState extends MoviesState {
  final List<Movie> movies;
  const GetNowPlayingMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetNowPlayingErrorState extends MoviesState {
  final String errorMessage;
  const GetNowPlayingErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class LoadingGetTopRatedMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class GetTopRatedMoviesSuccessState extends MoviesState {
  final List<Movie> movies;
  const GetTopRatedMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetTopRatedErrorState extends MoviesState {
  final String errorMessage;
  const GetTopRatedErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FirstLoadingGetTopRatedMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class LoadingGetPopularMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class FirstLoadingGetPopularMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class GetPopularMoviesSuccessState extends MoviesState {
  final List<Movie> movies;
  const GetPopularMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetPopularErrorState extends MoviesState {
  final String errorMessage;
  GetPopularErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class LoadingSearchForMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class GetSearchForMoviesSuccessState extends MoviesState {
  final List<Movie> movies;
  const GetSearchForMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetSearchForErrorState extends MoviesState {
  final String errorMessage;
  const GetSearchForErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class GetClearSearchedListState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class FirstLoadingSearchForMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}
