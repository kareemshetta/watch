import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';
import 'package:watch/modules/movies/domain/usecase/get_search_for_movie_usecase.dart';
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
  GETSearchForMovieUseCase getSearchForMovieUseCase;

  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _searchedMovies = [];
  List<Movie> get topRatedMovies => [..._topRatedMovies];

  List<Movie> get popularMovies => [..._popularMovies];

  List<Movie> get nowPlayingMovies => [..._nowPlayingMovies];

  List<Movie> get searchedMovies => [..._searchedMovies];

  int topRatedPageIndex = 1;
  int popularPageIndex = 1;
  int searchPageIndex = 1;

  MoviesBloc(this.getNowPlayingMoviesUseCase, this.getPopularMoviesUseCase,
      this.getTopRatedMoviesUseCase, this.getSearchForMovieUseCase)
      : super(InitialMoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetSearchForMovieMoviesEvent>(_getSearchedMovies);
    on<GetClearSearchedListEvent>(_getClearSearchedList);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(LoadingGetNowPlayingMoviesState());
    final result = await getNowPlayingMoviesUseCase(NoParameter());
    result.fold((l) {
      emit(GetNowPlayingErrorState(errorMessage: l.message));
    }, (r) {
      print(r);
      _nowPlayingMovies = r;
      emit(GetNowPlayingMoviesSuccessState(r));
    });
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    if (topRatedPageIndex == 1) {
      emit(FirstLoadingGetTopRatedMoviesState());
    } else {
      emit(LoadingGetTopRatedMoviesState());
    }
    emit(LoadingGetTopRatedMoviesState());
    final result =
        await getTopRatedMoviesUseCase(PageIndexParameter(topRatedPageIndex));
    result.fold((l) {
      emit(GetTopRatedErrorState(errorMessage: l.message));
    }, (r) {
      print(r);
      for (var element in r) {
        _topRatedMovies.add(element);
      }
      topRatedPageIndex++;
      emit(GetTopRatedMoviesSuccessState(r));
    });
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    if (popularPageIndex == 1) {
      emit(FirstLoadingGetPopularMoviesState());
    } else {
      emit(LoadingGetPopularMoviesState());
    }

    final result =
        await getPopularMoviesUseCase(PageIndexParameter(popularPageIndex));
    result.fold((l) {
      emit(GetPopularErrorState(errorMessage: l.message));
    }, (r) {
      for (var element in r) {
        _popularMovies.add(element);
      }
      popularPageIndex++;
      print(popularPageIndex);
      emit(GetPopularMoviesSuccessState(r));
    });
  }

  FutureOr<void> _getSearchedMovies(
      GetSearchForMovieMoviesEvent event, Emitter<MoviesState> emit) async {
    if (searchPageIndex == 1 && _searchedMovies.isEmpty) {
      emit(FirstLoadingSearchForMoviesState());
    } else {
      emit(LoadingSearchForMoviesState());
    }
    final result = await getSearchForMovieUseCase(
        SearchParameter(searchPageIndex, event.movieName));
    result.fold((l) {
      emit(GetSearchForErrorState(errorMessage: l.message));
    }, (r) {
      print(result);
      for (var element in r) {
        _searchedMovies.add(element);
      }
      searchPageIndex++;
      emit(GetSearchForMoviesSuccessState(searchedMovies));
    });
  }

  FutureOr<void> _getClearSearchedList(
      GetClearSearchedListEvent event, Emitter<MoviesState> emit) {
    _searchedMovies.clear();
    searchPageIndex = 1;
    emit(GetClearSearchedListState());
  }
}
