import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:watch/modules/movies/domain/entities/movie.dart';
import 'package:watch/modules/movies/domain/entities/movie_detail.dart';
import 'package:watch/modules/movies/domain/usecase/get_movie_detail_ussecase.dart';
import 'package:watch/modules/movies/domain/usecase/get_recommendation_use_case.dart';

import '../../../../core/network/models/failure.dart';

abstract class BaseMovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, MovieDetailed>> getMovieDetail(
      MovieDetailParameter parameter);

  Future<Either<Failure, List<Movie>>> getRecommendationMovies(
      RecommendationParameter parameter);
}
