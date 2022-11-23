import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:watch/modules/movies/domain/repository/base_movie_repository.dart';

import '../../../../core/network/models/failure.dart';
import '../entities/movie.dart';
import 'base_use_case.dart';

class GetPopularMoviesUseCase
    extends BaseUseCase<List<Movie>, PageIndexParameter> {
  BaseMovieRepository baseMovieRepository;
  GetPopularMoviesUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(
      PageIndexParameter parameter) async {
    return await baseMovieRepository.getPopularMovies(
        pageIndex: parameter.pageIndex);
  }
}
