const kApiKey = '0f2fa3f84537ad4b53c9e3c913d2e012';
const kBaseUrl = 'https://api.themoviedb.org/3';
const kBaseSearchUrl = 'https://api.themoviedb.org/3/search/movie';

/// https://api.themoviedb.org/3/movie/now_playing?api_key=0f2fa3f84537ad4b53c9e3c913d2e012&language=en-US&page=1
//https://api.themoviedb.org/3/movie/663712?api_key=0f2fa3f84537ad4b53c9e3c913d2e012&language=en-US

const kNowPlayingPath =
    '$kBaseUrl/movie/now_playing?api_key=$kApiKey&language=en-US&page=1';

String getTopRatedPath({int pageIndex = 1}) {
  String kTopRatedPath =
      '$kBaseUrl/movie/top_rated?api_key=$kApiKey&language=en-US&page=$pageIndex';
  return kTopRatedPath;
}
/*
* https://api.themoviedb.org/3/search/movie?api_key=0f2fa3f84537ad4b53c9e3c913d2e012&language=en-US&query=thor&page=1&include_adult=false
*
* */
// const kTopRatedPath =
//     '$kBaseUrl/movie/top_rated?api_key=$kApiKey&language=en-US&page=1';

const kPopularPath =
    '$kBaseUrl/movie/popular?api_key=$kApiKey&language=en-US&page=1';

String getSearchPath({int pageIndex = 1, String? movieName}) {
  https: //api.themoviedb.org/3/search/movie?api_key=0f2fa3f84537ad4b53c9e3c913d2e012&language=en-US&query=thor&page=1&include_adult=false

  String kPopularPath =
      '$kBaseSearchUrl?api_key=$kApiKey&language=en-US&page=$pageIndex&query=$movieName&include_adult=false';
  return kPopularPath;
}

String getPopularPath({int pageIndex = 1}) {
  String kPopularPath =
      '$kBaseUrl/movie/popular?api_key=$kApiKey&language=en-US&page=$pageIndex';
  return kPopularPath;
}

const kMovieDetailPath = '$kBaseUrl/movie/';
const kMovieDBImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
//https://api.themoviedb.org/3/movie/663712/recommendations?api_key=0f2fa3f84537ad4b53c9e3c913d2e012&language=en-US&page=1
String getRecommendationPath(int id) {
  String recommendedPath =
      '$kBaseUrl/movie/$id/recommendations?api_key=$kApiKey&language=en-US&page=1';
  return recommendedPath;
}

String concatImagePath(String path) {
  return '$kMovieDBImageBaseUrl/$path';
}
