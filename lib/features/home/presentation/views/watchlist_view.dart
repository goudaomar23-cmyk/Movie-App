import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import '../manager/watchlist_cubit.dart';
import 'details_view.dart';  

class WatchListView extends StatelessWidget {
  const WatchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E262F),
      appBar: AppBar(
        title: const Text(
          "My Watchlist",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<WatchlistCubit, List<MovieModel>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(
              child: Text(
                "No movies added yet!",
                style: TextStyle(color: Colors.white60, fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: state.length,
            separatorBuilder: (context, index) => const SizedBox(height: 25),
            itemBuilder: (context, index) {
              final movie = state[index];
              return CustomWatchlistItem(movie: movie, isWatchlistView: true);
            },
          );
        },
      ),
    );
  }
}

class CustomWatchlistItem extends StatelessWidget {
  final MovieModel movie;
  final bool isWatchlistView; 

  const CustomWatchlistItem({
    super.key,
    required this.movie,
    this.isWatchlistView = false,  
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsView(movie: movie)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A333E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.posterPath ?? "",
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 140,
                  color: Colors.white10,
                  child: const Icon(Icons.broken_image, color: Colors.white38),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    movie.title ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 18,  
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border,
                        color: Color(0xFFFFBB3B),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        (movie.voteAverage ?? 0.0).toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFBB3B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.calendar_month_outlined,
                    movie.releaseDate ?? "N/A",
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.access_time_outlined, "139 minutes"),
                ],
              ),
            ),

            if (isWatchlistView)
              IconButton(
                onPressed: () {
                  context.read<WatchlistCubit>().toggleWatchlist(movie);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${movie.title} removed from watchlist"),
                      duration: const Duration(seconds: 1),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete_sweep_outlined,
                  color: Colors.redAccent,
                  size: 28,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white60, size: 16),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 14, color: Colors.white70)),
      ],
    );
  }
}
