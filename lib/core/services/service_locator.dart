import 'package:get_it/get_it.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';
import 'package:watch/modules/movies/domain/usecase/get_movie_detail_ussecase.dart';
import 'package:watch/modules/movies/domain/usecase/get_recommendation_use_case.dart';
import 'package:watch/modules/movies/domain/usecase/get_search_for_movie_usecase.dart';
import 'package:watch/modules/movies/presentation/controllers/movie_detail_bloc.dart';
import './../../modules/./movies/data/datasources/remote_data_sources/movie_remote_data_sources.dart';
import './../../modules/./movies/data/repository/movie_repository.dart';
import './../../modules/./movies/domain/repository/base_movie_repository.dart';
import './../../modules/./movies/domain/usecase/get_now_playing_use_case.dart';
import './../../modules/./movies/domain/usecase/get_popular_movies_usecase.dart';
import './../../modules/./movies/domain/usecase/get_top_rated_movies_usecase.dart';
import './../../modules/./movies/presentation/controllers/movies_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    /// bloc every time you call movieBloc new instance will be  created
    sl.registerFactory(() => MoviesBloc(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => MovieDetailBloc(sl(), sl()));

    /// making GetNowPlayingUseCase singleton
    sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GETSearchForMovieUseCase(sl()));

    /// making GetNowPlayingUseCase singleton
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));

    sl.registerLazySingleton(() => GetRecommendationUseCase(sl()));

    /// making GetNowPlayingUseCase singleton
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailUseCase(sl()));

    /// making MovieRepository singleton
    sl.registerLazySingleton<BaseMovieRepository>(() => MovieRepository(sl()));

    /// data source make singleton
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());
  }
}
