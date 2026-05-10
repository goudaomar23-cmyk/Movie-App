import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import 'releases_item.dart';

class ReleasesListView extends StatelessWidget {
  final List<MovieModel> movies;
  const ReleasesListView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ReleasesItem(
            index: index,
            imageUrl: movies[index].posterPath ?? "",
            movie: movies[index],
          );
        },
      ),
    );
  }
}
