import 'package:dartz/dartz.dart';
import 'package:watch/core/network/exceptions/remote_excption.dart';
import 'package:watch/core/network/models/failure.dart';
import 'package:watch/modules/movies/data/datasources/remote_data_sources/movie_remote_data_sources.dart';
import 'package:watch/modules/movies/domain/entities/movie.dart';
import 'package:watch/modules/movies/domain/entities/movie_detail.dart';
import 'package:watch/modules/movies/domain/repository/base_movie_repository.dart';
import 'package:watch/modules/movies/domain/usecase/get_movie_detail_ussecase.dart';
import 'package:watch/modules/movies/domain/usecase/get_recommendation_use_case.dart';

class MovieRepository extends BaseMovieRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;
  MovieRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final movieList = await baseMovieRemoteDataSource.getNowPlayingMovies();
      return right(movieList);
    } on RemoteException catch (failure) {
      return Left(RemoteFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(
      {int pageIndex = 1}) async {
    try {
      final movieList = await baseMovieRemoteDataSource.getPopularMovies(
          pageIndex: pageIndex);
      return right(movieList);
    } on RemoteException catch (failure) {
      return Left(RemoteFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(
      {int pageIndex = 1}) async {
    try {
      final movieList = await baseMovieRemoteDataSource.getTopRatedMovies(
          pageIndex: pageIndex);
      return right(movieList);
    } on RemoteException catch (failure) {
      return Left(RemoteFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetailed>> getMovieDetail(
      MovieDetailParameter parameter) async {
    try {
      final movieDetail =
          await baseMovieRemoteDataSource.getMovieDetails(parameter);
      return right(movieDetail);
    } on RemoteException catch (failure) {
      return left(RemoteFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getRecommendationMovies(
      RecommendationParameter parameter) async {
    try {
      final movieList =
          await baseMovieRemoteDataSource.getRecommendedMovies(parameter.id);
      return right(movieList);
    } on RemoteException catch (failure) {
      return Left(RemoteFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchForMovie(
      {int pageIndex = 1, String movieName = ''}) async {
    try {
      final movieList = await baseMovieRemoteDataSource.searchForMovie(
          movieName: movieName, pageIndex: pageIndex);
      return right(movieList);
    } on RemoteException catch (failure) {
      return Left(RemoteFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
