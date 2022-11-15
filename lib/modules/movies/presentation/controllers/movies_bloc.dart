import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';
import 'package:watch/modules/movies/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_events.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_states.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecase/get_now_playing_use_case.dart';
import '../../domain/usecase/get_popular_movies_usecase.dart';

// new changes
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  GetPopularMoviesUseCase getPopularMoviesUseCase;
  GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _popularMovies = [];

  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(InitialMoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);
  }
  List<Movie> get topRatedMovies => [..._topRatedMovies];

  List<Movie> get popularMovies => [..._popularMovies];

  List<Movie> get nowPlayingMovies => [..._nowPlayingMovies];
  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(LoadingGetNowPlayingMoviesState());
    final result = await getNowPlayingMoviesUseCase(NoParameter());
    result.fold((l) {
      //MoviesState(
      //             nowPlayingMessage: l.message, nowPlayingState: RequestState.error)
      emit(GetNowPlayingErrorState(errorMessage: l.message)
          // state.copyWith(
          // nowPlayingMessage: l.message, nowPlayingState: RequestState.error)

          );
    }, (r) {
      print(r);
      _nowPlayingMovies = r;
      emit(GetNowPlayingMoviesSuccessState(r)
          // state.copyWith(
          // nowPlayingMovies: r, nowPlayingState: RequestState.loaded)
          );
    });
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(LoadingGetTopRatedMoviesState());
    final result = await getTopRatedMoviesUseCase(NoParameter());
    result.fold((l) {
      //MoviesState(
      //             nowPlayingMessage: l.message, nowPlayingState: RequestState.error)
      emit(GetTopRatedErrorState(errorMessage: l.message)
          // state.copyWith(
          // topRatedMessage: l.message, topRatedState: RequestState.error)
          );
    }, (r) {
      print(r);
      _topRatedMovies = r;
      emit(GetTopRatedMoviesSuccessState(r)
          // state.copyWith(
          // topRatedMovies: r, topRatedState: RequestState.loaded)
          );
    });
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(LoadingGetPopularMoviesState());
    final result = await getPopularMoviesUseCase(NoParameter());
    result.fold((l) {
      //MoviesState(
      //             nowPlayingMessage: l.message, nowPlayingState: RequestState.error)
      emit(GetPopularErrorState(errorMessage: l.message)
          // state.copyWith(
          // popularMessage: l.message, popularState: RequestState.error)
          );
    }, (r) {
      print(r);
      _popularMovies = r;
      emit(GetPopularMoviesSuccessState(r)
          // state.copyWith(popularMovies: r, popularState: RequestState.loaded)
          );
    });
  }
}
