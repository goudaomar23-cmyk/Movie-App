import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class HomeRemoteDataSource {
  final Dio dio = Dio();

  final String apiKey = "9d7f94be913eddf2db40e317d2f12f36";
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<MovieModel>> getPopularMovies() async {
    var response = await dio.get("$baseUrl/movie/popular?api_key=$apiKey");

    List<MovieModel> movies = [];
    for (var item in response.data['results']) {
      movies.add(MovieModel.fromJson(item));
    }
    return movies;
  }

  Future<List<MovieModel>> getNewReleases() async {
    var response = await dio.get("$baseUrl/movie/top_rated?api_key=$apiKey");

    List<MovieModel> movies = [];
    for (var item in response.data['results']) {
      movies.add(MovieModel.fromJson(item));
    }
    return movies;
  }

  Future<List<MovieModel>> getRecommendedMovies() async {
    var response = await dio.get("$baseUrl/movie/upcoming?api_key=$apiKey");

    List<MovieModel> movies = [];
    for (var item in response.data['results']) {
      movies.add(MovieModel.fromJson(item));
    }
    return movies;
  }

  Future<List<MovieModel>> searchMovies({required String query}) async {
    var response = await dio.get(
      "$baseUrl/search/movie",
      queryParameters: {'api_key': apiKey, 'query': query},
    );

    List<MovieModel> movies = [];
    if (response.data['results'] != null) {
      for (var item in response.data['results']) {
        movies.add(MovieModel.fromJson(item));
      }
    }
    return movies;
  }

  Future<List<MovieModel>> getSimilarMovies({required int movieId}) async {
    var response = await dio.get(
      "$baseUrl/movie/$movieId/similar?api_key=$apiKey",
    );

    List<MovieModel> movies = [];
    if (response.data['results'] != null) {
      for (var item in response.data['results']) {
        movies.add(MovieModel.fromJson(item));
      }
    }
    return movies;
  }
}
