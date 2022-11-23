import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:watch/core/network/models/failure.dart';

abstract class BaseUseCase<T, parameter> {
  Future<Either<Failure, T>> call(parameter parameter);
}

class NoParameter extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PageIndexParameter extends Equatable {
  final int pageIndex;
  const PageIndexParameter(this.pageIndex);

  @override
  // TODO: implement props
  List<Object?> get props => [pageIndex];
}

class SearchParameter extends Equatable {
  final int pageIndex;
  final String movieName;
  const SearchParameter(this.pageIndex, this.movieName);

  @override
  List<Object?> get props => [pageIndex, movieName];
}
