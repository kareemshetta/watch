import 'package:dio/dio.dart';
import 'package:watch/core/utils/constants.dart';
import 'package:watch/core/network/exceptions/remote_excption.dart';
import 'package:watch/core/network/models/error_model.dart';
import 'package:watch/modules/movies/data/models/movie_model.dart';
import 'package:watch/modules/movies/data/models/movie_detail_model.dart';
import 'package:watch/modules/movies/domain/usecase/get_movie_detail_ussecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getTopRatedMovies({int pageIndex = 1});
  Future<List<MovieModel>> getPopularMovies({int pageIndex = 1});
  Future<List<MovieModel>> getRecommendedMovies(int id);
  Future<List<MovieModel>> searchForMovie(
      {int pageIndex = 1, String movieName = ''});
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
  Future<List<MovieModel>> getPopularMovies({int pageIndex = 1}) async {
    print('movieindex:$pageIndex');
    final response = await Dio().get(getPopularPath(pageIndex: pageIndex));
    if (response.statusCode == 200) {
      final dataList = (response.data['results'] as List<dynamic>);
      print('first:${dataList.first}');
      return dataList.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw RemoteException(ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies({int pageIndex = 1}) async {
    final response = await Dio().get(getTopRatedPath(pageIndex: pageIndex));
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

  @override
  Future<List<MovieModel>> searchForMovie(
      {int pageIndex = 1, String movieName = ''}) async {
    final response = await Dio()
        .get(getSearchPath(pageIndex: pageIndex, movieName: movieName));
    if (response.statusCode == 200) {
      final dataList = (response.data['results'] as List<dynamic>);
      return dataList.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      print('errrorrrrrrr${response.data}');
      throw RemoteException(ErrorMessageModel.fromJson(response.data));
    }
  }
}
