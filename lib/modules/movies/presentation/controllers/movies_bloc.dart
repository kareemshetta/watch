import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/core/utils/enums.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';
import 'package:watch/modules/movies/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_events.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_states.dart';

import '../../domain/usecase/get_now_playing_use_case.dart';
import '../../domain/usecase/get_popular_movies_usecase.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  GetPopularMoviesUseCase getPopularMoviesUseCase;
  GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(const MoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getNowPlayingMoviesUseCase(NoParameter());
    result.fold((l) {
      //MoviesState(
      //             nowPlayingMessage: l.message, nowPlayingState: RequestState.error)
      emit(state.copyWith(
          nowPlayingMessage: l.message, nowPlayingState: RequestState.error));
    }, (r) {
      print(r);
      emit(state.copyWith(
          nowPlayingMovies: r, nowPlayingState: RequestState.loaded));
    });
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMoviesUseCase(NoParameter());
    result.fold((l) {
      //MoviesState(
      //             nowPlayingMessage: l.message, nowPlayingState: RequestState.error)
      emit(state.copyWith(
          topRatedMessage: l.message, topRatedState: RequestState.error));
    }, (r) {
      print(r);
      emit(state.copyWith(
          topRatedMovies: r, topRatedState: RequestState.loaded));
    });
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(NoParameter());
    result.fold((l) {
      //MoviesState(
      //             nowPlayingMessage: l.message, nowPlayingState: RequestState.error)
      emit(state.copyWith(
          popularMessage: l.message, popularState: RequestState.error));
    }, (r) {
      print(r);
      emit(state.copyWith(popularMovies: r, popularState: RequestState.loaded));
    });
  }
}
