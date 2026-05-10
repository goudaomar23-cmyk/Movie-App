import 'package:flutter/material.dart';
import 'package:movie_app/features/home/presentation/views/details_view.dart';
import '../../data/models/movie_model.dart';

class RecommendedMoviesListView extends StatelessWidget {
  final List<MovieModel> movies;

  const RecommendedMoviesListView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: movies.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailsView(movie: movie);
                    },
                  ),
                );
              },
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: const Color(0xFF3A3F47),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.white24),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
