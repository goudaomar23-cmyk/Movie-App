import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_sources/home_remote_data_source.dart';
import '../../data/models/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieModel> popular;
  final List<MovieModel> topRated;
  final List<MovieModel> recommended;

  HomeSuccess({
    required this.popular,
    required this.topRated,
    required this.recommended,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}

class HomeCubit extends Cubit<HomeState> {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeCubit(this.homeRemoteDataSource) : super(HomeInitial());

  void fetchHomeData() async {
    emit(HomeLoading());
    try {
      final popularList = await homeRemoteDataSource.getPopularMovies();
      final newReleasesList = await homeRemoteDataSource.getNewReleases();

      final recommendedList = await homeRemoteDataSource.getRecommendedMovies();

      emit(
        HomeSuccess(
          popular: popularList,
          topRated: newReleasesList,
          recommended: recommendedList,
        ),
      );
    } catch (e) {
      emit(
        HomeError(message: "error when fetching home data: ${e.toString()}"),
      );
    }
  }
}
