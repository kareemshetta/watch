import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watch/core/utils/enums.dart';
import 'package:watch/modules/movies/domain/entities/movie_detail.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecase/get_movie_detail_ussecase.dart';
import '../../domain/usecase/get_recommendation_use_case.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

//new changes
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  GetMovieDetailUseCase getMovieDetailUseCase;
  GetRecommendationUseCase getRecommendationUseCase;
  MovieDetailed? _movieDetailed;

  MovieDetailed? get movieDetailed {
    if (_movieDetailed == null) {
      return null;
    } else {
      return MovieDetailed(
        title: _movieDetailed!.title,
        runTime: _movieDetailed!.runTime,
        releaseDate: _movieDetailed!.releaseDate,
        backdropPath: _movieDetailed!.backdropPath,
        genre: _movieDetailed!.genre,
        id: _movieDetailed!.id,
        overview: _movieDetailed!.overview,
        voteAverage: _movieDetailed!.voteAverage,
      );
    }
  }

  List<Movie> _recommendationList = [];

  List<Movie> get recommendationList => [..._recommendationList];

  MovieDetailBloc(this.getMovieDetailUseCase, this.getRecommendationUseCase)
      : super(InitialMovieDetailState()) {
    on<GetMovieDetailEvent>(_getMovieDetail);
    on<GetRecommendationEvent>(_getRecommendations);
  }

  FutureOr<void> _getMovieDetail(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(LoadingGetMovieDetailState());
    final result =
        await getMovieDetailUseCase(MovieDetailParameter(id: event.id));
    result.fold((l) => emit(GetMovieDetailErrorState(l.message)), (r) {
      _movieDetailed = r;
      emit(GetMovieDetailSuccessState(r));
    });
  }

  FutureOr<void> _getRecommendations(
      GetRecommendationEvent event, Emitter<MovieDetailState> emit) async {
    emit(LoadingGetRecommendationState());
    final result =
        await getRecommendationUseCase(RecommendationParameter(event.id));
    result.fold((l) => emit(GetRecommendationErrorState(l.message)), (r) {
      _recommendationList = r;
      print('reighttttt$r');
      emit(GetRecommendationSuccessState(r));
    });
  }
}
