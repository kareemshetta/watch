part of 'movie_detail_bloc.dart';

// class MovieDetailState extends Equatable {
//   final MovieDetailed? movieDetailed;
//   final String movieDetailMessage;
//   final RequestState movieDetailState;
//   final List<Movie> recommendation;
//   final RequestState recommendedMoviesState;
//   final String recommendedMovieMessage;
//   const MovieDetailState(
//       {this.movieDetailed,
//       this.movieDetailMessage = '',
//       this.movieDetailState = RequestState.loading,
//       this.recommendation = const [],
//       this.recommendedMovieMessage = '',
//       this.recommendedMoviesState = RequestState.loading});
//
//   MovieDetailState copyWith({
//     MovieDetailed? movieDetailed,
//     String? movieDetailMessage,
//     RequestState? movieDetailState,
//     List<Movie>? recommendation,
//     RequestState? recommendedMoviesState,
//     String? recommendedMovieMessage,
//   }) {
//     return MovieDetailState(
//         movieDetailState: movieDetailState ?? this.movieDetailState,
//         movieDetailed: movieDetailed ?? this.movieDetailed,
//         movieDetailMessage: movieDetailMessage ?? this.movieDetailMessage,
//         recommendation: recommendation ?? this.recommendation,
//         recommendedMovieMessage:
//             recommendedMovieMessage ?? this.recommendedMovieMessage,
//         recommendedMoviesState:
//             recommendedMoviesState ?? this.recommendedMoviesState);
//   }
//
//   @override
//   // TODO: implement props
//   List<Object?> get props =>
//       [movieDetailed, movieDetailMessage, movieDetailState];
// }

abstract class MovieDetailState extends Equatable {}

class InitialMovieDetailState extends MovieDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingGetMovieDetailState extends MovieDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetMovieDetailSuccessState extends MovieDetailState {
  final MovieDetailed movieDetailed;
  GetMovieDetailSuccessState(this.movieDetailed);
  @override
  // TODO: implement props
  List<Object?> get props => [movieDetailed];
}

class GetMovieDetailErrorState extends MovieDetailState {
  final String errorMessage;
  GetMovieDetailErrorState(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class LoadingGetRecommendationState extends MovieDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetRecommendationSuccessState extends MovieDetailState {
  final List<Movie> recommendationsList;
  GetRecommendationSuccessState(this.recommendationsList);
  @override
  // TODO: implement props
  List<Object?> get props => [recommendationsList];
}

class GetRecommendationErrorState extends MovieDetailState {
  final String errorMessage;
  GetRecommendationErrorState(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
