import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'details_view.dart';
import '../manager/search_cubit.dart';
import '../widgets/custom_watchlist_item.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                context.read<SearchCubit>().searchMovies(value);
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search movies...",
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF3A3F47),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return _buildNoResults();
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: state.movies.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsView(movie: movie),
                              ),
                            );
                          },
                          child: CustomWatchlistItem(movie: movie),
                        );
                      },
                    );
                  } else if (state is SearchFailure) {
                    return Center(
                      child: Text(
                        state.errMessage,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }

                  return _buildInitialState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Text(
        "Find your favorite movie",
        style: TextStyle(color: Colors.white38, fontSize: 16),
      ),
    );
  }

  Widget _buildNoResults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.search_off, size: 100, color: Colors.white24),
        const SizedBox(height: 20),
        const Text(
          "We Are Sorry, We Can\nNot Find The Movie :(",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Find your movie by Type title,\ncategories, years, etc",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white38, fontSize: 14),
        ),
      ],
    );
  }
}
