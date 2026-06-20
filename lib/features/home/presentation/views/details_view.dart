import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:movie_app/features/home/presentation/manager/watchlist_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/similar_movies_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/similar_movies_state.dart';

class DetailsView extends StatelessWidget {
  final MovieModel movie;

  const DetailsView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SimilarMoviesCubit(HomeRemoteDataSource())
            ..getSimilarMovies(movieId: movie.id),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E262F),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            BlocBuilder<WatchlistCubit, List<MovieModel>>(
              builder: (context, state) {
                bool isAdded = context.read<WatchlistCubit>().isFavorite(
                  movie.id,
                );

                return IconButton(
                  icon: Icon(
                    isAdded ? Icons.bookmark : Icons.bookmark_add_outlined,
                    color: isAdded ? const Color(0xFFFFBB3B) : Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    context.read<WatchlistCubit>().toggleWatchlist(movie);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isAdded
                              ? "Removed from Watchlist"
                              : "Added to Watchlist",
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.network(
                      movie.posterPath != null
                          ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                          : "",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF1E262F).withAlpha(204),
                          const Color(0xFF1E262F),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? "Unknown Title",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie.releaseDate ?? "N/A",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFBB3B),
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie.voteAverage?.toStringAsFixed(1) ?? "0.0",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Storyline",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.overview ?? "No description available.",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Similar Movies",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
                      builder: (context, state) {
                        if (state is SimilarMoviesLoading) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else if (state is SimilarMoviesSuccess) {
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.movies.length,
                              itemBuilder: (context, index) {
                                final similarMovie = state.movies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsView(movie: similarMovie),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 120,
                                    margin: const EdgeInsets.only(right: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              similarMovie.posterPath != null
                                                  ? "https://image.tmdb.org/t/p/w500${similarMovie.posterPath}"
                                                  : "",
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      color: Colors.white30,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          similarMovie.title ?? "Unknown",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is SimilarMoviesFailure) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                state.errMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
