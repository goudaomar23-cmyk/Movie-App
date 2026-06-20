import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/presentation/manager/similar_movies_state.dart';
import 'package:movie_app/features/home/data/data_sources/home_remote_data_source.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  final HomeRemoteDataSource homeRemoteDataSource;

  SimilarMoviesCubit(this.homeRemoteDataSource) : super(SimilarMoviesInitial());

  Future<void> getSimilarMovies({required int movieId}) async {
    emit(SimilarMoviesLoading());
    try {
      final movies = await homeRemoteDataSource.getSimilarMovies(
        movieId: movieId,
      );
      emit(SimilarMoviesSuccess(movies));
    } catch (e) {
      emit(SimilarMoviesFailure(e.toString()));
    }
  }
}
