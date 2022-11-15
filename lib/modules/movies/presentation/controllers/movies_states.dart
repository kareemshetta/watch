import 'package:equatable/equatable.dart';
import 'package:watch/core/utils/enums.dart';

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
  GetNowPlayingMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetNowPlayingErrorState extends MoviesState {
  final String errorMessage;
  GetNowPlayingErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class LoadingGetTopRatedMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class GetTopRatedMoviesSuccessState extends MoviesState {
  final List<Movie> movies;
  GetTopRatedMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetTopRatedErrorState extends MoviesState {
  final String errorMessage;
  GetTopRatedErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class LoadingGetPopularMoviesState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class GetPopularMoviesSuccessState extends MoviesState {
  final List<Movie> movies;
  GetPopularMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetPopularErrorState extends MoviesState {
  final String errorMessage;
  GetPopularErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// class MoviesState extends Equatable {
//   final List<Movie> nowPlayingMovies;
//   final RequestState nowPlayingState;
//   final String nowPlayingMessage;
//
//   final List<Movie> topRatedMovies;
//   final RequestState topRatedState;
//   final String topRatedMessage;
//
//   final List<Movie> popularMovies;
//   final RequestState popularState;
//   final String popularMessage;
//
//   const MoviesState(
//       {this.nowPlayingMovies = const [],
//       this.nowPlayingState = RequestState.loading,
//       this.nowPlayingMessage = '',
//       this.topRatedMovies = const [],
//       this.topRatedState = RequestState.loading,
//       this.topRatedMessage = '',
//       this.popularMovies = const [],
//       this.popularState = RequestState.loading,
//       this.popularMessage = ''});
//
//   @override
//   List<Object?> get props => [
//         nowPlayingMovies,
//         nowPlayingState,
//         nowPlayingMessage,
//         topRatedMovies,
//         topRatedState,
//         topRatedMessage,
//         popularMovies,
//         popularState,
//         popularMessage
//       ];
//
//   MoviesState copyWith({
//     List<Movie>? nowPlayingMovies,
//     RequestState? nowPlayingState,
//     String? nowPlayingMessage,
//     List<Movie>? topRatedMovies,
//     RequestState? topRatedState,
//     String? topRatedMessage,
//     List<Movie>? popularMovies,
//     RequestState? popularState,
//     String? popularMessage,
//   }) {
//     return MoviesState(
//         nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
//         nowPlayingState: nowPlayingState ?? this.nowPlayingState,
//         nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
//         topRatedMovies: topRatedMovies ?? this.topRatedMovies,
//         topRatedState: topRatedState ?? this.topRatedState,
//         topRatedMessage: topRatedMessage ?? this.topRatedMessage,
//         popularMovies: popularMovies ?? this.popularMovies,
//         popularState: popularState ?? this.popularState,
//         popularMessage: popularMessage ?? this.popularMessage);
//   }
// }
