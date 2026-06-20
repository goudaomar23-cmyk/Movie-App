import 'package:movie_app/features/home/data/models/movie_model.dart';

abstract class SimilarMoviesState {}

class SimilarMoviesInitial extends SimilarMoviesState {}

class SimilarMoviesLoading extends SimilarMoviesState {}

class SimilarMoviesSuccess extends SimilarMoviesState {
  final List<MovieModel> movies;
  SimilarMoviesSuccess(this.movies);
}

class SimilarMoviesFailure extends SimilarMoviesState {
  final String errMessage;
  SimilarMoviesFailure(this.errMessage);
}
