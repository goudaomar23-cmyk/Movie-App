import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_sources/home_remote_data_source.dart';
import '../../data/models/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieModel> movies;
  SearchSuccess(this.movies);
}

class SearchFailure extends SearchState {
  final String errMessage;
  SearchFailure(this.errMessage);
}

class SearchCubit extends Cubit<SearchState> {
  final HomeRemoteDataSource homeRemoteDataSource;
  SearchCubit(this.homeRemoteDataSource) : super(SearchInitial());

  void searchMovies(String movieName) async {
    if (movieName.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      var result = await homeRemoteDataSource.searchMovies(query: movieName);
      emit(SearchSuccess(result));
    } catch (e) {
      emit(SearchFailure("Something went wrong, please try again."));
    }
  }
}
