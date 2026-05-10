import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/movie_model.dart';
import '../manager/watchlist_cubit.dart';

class CustomWatchlistItem extends StatelessWidget {
  final MovieModel movie;
  final bool isWatchlistView; 
  const CustomWatchlistItem({
    super.key,
    required this.movie,
    this.isWatchlistView =
        false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3F47),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie.posterPath ?? "",
              width: 95,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 95,
                color: Colors.white24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.star_border,
                  (movie.voteAverage ?? 0.0).toStringAsFixed(1),
                  const Color(0xFFFFBB3B),
                ),
                const SizedBox(height: 4),
                _buildInfoRow(
                  Icons.calendar_month_outlined,
                  movie.releaseDate ?? "N/A",
                  Colors.white70,
                ),
                const SizedBox(height: 4),
                _buildInfoRow(
                  Icons.access_time_outlined,
                  "139 minutes",
                  Colors.white70,
                ),
              ],
            ),
          ),

          if (isWatchlistView)
            IconButton(
              onPressed: () {
                context.read<WatchlistCubit>().toggleWatchlist(movie);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF3A3F47),
                    content: Text("${movie.title} removed"),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(
                Icons.delete_sweep_outlined,
                color: Colors.redAccent,
                size: 26,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: color, fontSize: 14)),
      ],
    );
  }
}
