import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import 'popular_item.dart';

class PopularGridView extends StatelessWidget {
  final List<MovieModel> movies;
  const PopularGridView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, //  ScrollView
      physics: const NeverScrollableScrollPhysics(), // (HomeView)
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return PopularItem(
          movie: movies[index],
          imageUrl: movies[index].posterPath ?? "",
        );
      },
    );
  }
}
