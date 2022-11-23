import 'package:dartz/dartz.dart';
import 'package:watch/core/network/models/failure.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';

import '../entities/movie.dart';
import '../repository/base_movie_repository.dart';

class GETSearchForMovieUseCase
    extends BaseUseCase<List<Movie>, SearchParameter> {
  BaseMovieRepository baseMovieRepository;
  GETSearchForMovieUseCase(this.baseMovieRepository);
  @override
  Future<Either<Failure, List<Movie>>> call(SearchParameter parameter) {
    return baseMovieRepository.searchForMovie(
        pageIndex: parameter.pageIndex, movieName: parameter.movieName);
  }
}
