import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:watch/core/network/models/failure.dart';
import 'package:watch/modules/movies/domain/entities/movie_detail.dart';
import 'package:watch/modules/movies/domain/usecase/base_use_case.dart';

import '../repository/base_movie_repository.dart';

class GetMovieDetailUseCase
    extends BaseUseCase<MovieDetailed, MovieDetailParameter> {
  final BaseMovieRepository movieRepository;

  GetMovieDetailUseCase(
    this.movieRepository,
  );

  @override
  Future<Either<Failure, MovieDetailed>> call(
      MovieDetailParameter parameter) async {
    return await movieRepository.getMovieDetail(parameter);
  }
}

class MovieDetailParameter extends Equatable {
  final int id;
  const MovieDetailParameter({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
