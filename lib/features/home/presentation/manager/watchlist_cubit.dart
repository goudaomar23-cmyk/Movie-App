import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/movie_model.dart';

class WatchlistCubit extends Cubit<List<MovieModel>> {
  WatchlistCubit() : super([]) {
    getWatchlist();
  }

  final String _boxName = 'watchlist_box';

  void getWatchlist() {
    if (Hive.isBoxOpen(_boxName)) {
      var box = Hive.box<MovieModel>(_boxName);
      emit(box.values.toList());
    }
  }

  void toggleWatchlist(MovieModel movie) async {
    var box = Hive.box<MovieModel>(_boxName);

    if (box.containsKey(movie.id)) {
      await box.delete(movie.id);
    } else {
      await box.put(movie.id, movie);
    }

    getWatchlist();
  }

  bool isFavorite(dynamic id) {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<MovieModel>(_boxName).containsKey(id);
    }
    return false;
  }
}
