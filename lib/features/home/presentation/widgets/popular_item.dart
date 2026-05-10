import 'package:flutter/material.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/presentation/views/details_view.dart';

class PopularItem extends StatelessWidget {
  final MovieModel movie;

  const PopularItem({super.key, required this.movie, required String imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsView(movie: movie)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          movie.posterPath ?? "",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[900],
            child: const Icon(Icons.broken_image, color: Colors.white24),
          ),
        ),
      ),
    );
  }
}
