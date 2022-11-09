import 'package:dartz/dartz.dart';
import 'package:watch/modules/movies/domain/repository/base_movie_repository.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';

import '../../../../core/network/models/failure.dart';
import '../entities/movie.dart';

class GetTopRatedMoviesUseCase extends BaseUseCase<List<Movie>, NoParameter> {
  BaseMovieRepository baseMovieRepository;
  GetTopRatedMoviesUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameter parameter) async {
    return await baseMovieRepository.getTopRatedMovies();
  }
}
