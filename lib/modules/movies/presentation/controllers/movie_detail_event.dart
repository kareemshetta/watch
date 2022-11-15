part of 'movie_detail_bloc.dart';

// new changes
abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;
  const GetMovieDetailEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetRecommendationEvent extends MovieDetailEvent {
  final int id;
  const GetRecommendationEvent(this.id);

  @override
// TODO: implement props
  List<Object?> get props => [id];
}
