part of 'movie_detail_bloc.dart';

// abstract class for
abstract class MovieDetailState extends Equatable {}

class InitialMovieDetailState extends MovieDetailState {
  @override
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
