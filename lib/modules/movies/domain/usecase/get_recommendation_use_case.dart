import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:watch/core/network/models/failure.dart';
import 'package:watch/modules/movies/domain/repository/base_movie_repository.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';

import '../entities/movie.dart';

class GetRecommendationUseCase
    extends BaseUseCase<List<Movie>, RecommendationParameter> {
  BaseMovieRepository baseMovieRepository;
  GetRecommendationUseCase(this.baseMovieRepository);
  @override
  Future<Either<Failure, List<Movie>>> call(
      RecommendationParameter parameter) async {
    return await baseMovieRepository.getRecommendationMovies(parameter);
  }
}

class RecommendationParameter extends Equatable {
  final int id;
  const RecommendationParameter(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
