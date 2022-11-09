import 'package:dio/dio.dart';
import 'package:watch/core/utils/constants.dart';
import 'package:watch/core/network/exceptions/remote_excption.dart';
import 'package:watch/core/network/models/error_model.dart';
import 'package:watch/modules/movies/data/models/movie_model.dart';
import 'package:watch/modules/movies/data/models/movie_detail_model.dart';
import 'package:watch/modules/movies/domain/usecase/get_movie_detail_ussecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getRecommendedMovies(int id);
  Future<MovieDetailModel> getMovieDetails(MovieDetailParameter parameter);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    print('starting getting data');
    final response = await Dio().get(kNowPlayingPath);

    if (response.statusCode == 200) {
      final dataList = (response.data['results'] as List<dynamic>);
      print(dataList);
      return dataList.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw RemoteException(ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(kPopularPath);
    if (response.statusCode == 200) {
      final dataList = (response.data['results'] as List<dynamic>);
      return dataList.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw RemoteException(ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(kTopRatedPath);
    if (response.statusCode == 200) {
      final dataList = (response.data['results'] as List<dynamic>);
      return dataList.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw RemoteException(ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetails(
      MovieDetailParameter parameter) async {
    final response = await Dio().get('$kMovieDetailPath${parameter.id}',
        queryParameters: {
          'api_key': '0f2fa3f84537ad4b53c9e3c913d2e012',
          'language': 'en-US'
        });
    if (response.statusCode == 200) {
      final movieDetail = response.data;
      return MovieDetailModel.fromJson(movieDetail);
    } else {
      throw RemoteException(ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getRecommendedMovies(int id) async {
    final response = await Dio().get(getRecommendationPath(id));
    if (response.statusCode == 200) {
      final dataList = (response.data['results'] as List<dynamic>);
      print('datasource recommendation$dataList');
      return dataList.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw RemoteException(ErrorMessageModel.fromJson(response.data));
    }
  }
}
