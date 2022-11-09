const kApiKey = '0f2fa3f84537ad4b53c9e3c913d2e012';
const kBaseUrl = 'https://api.themoviedb.org/3';

/// https://api.themoviedb.org/3/movie/now_playing?api_key=0f2fa3f84537ad4b53c9e3c913d2e012&language=en-US&page=1
//https://api.themoviedb.org/3/movie/663712?api_key=0f2fa3f84537ad4b53c9e3c913d2e012&language=en-US
const kNowPlayingPath =
    '$kBaseUrl/movie/now_playing?api_key=$kApiKey&language=en-US&page=1';
const kTopRatedPath =
    '$kBaseUrl/movie/top_rated?api_key=$kApiKey&language=en-US&page=1';
const kPopularPath =
    '$kBaseUrl/movie/popular?api_key=$kApiKey&language=en-US&page=1';
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
