import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import '../views/details_view.dart';  
class ReleasesItem extends StatelessWidget {
  final MovieModel movie;
  final int index;

  const ReleasesItem({
    super.key,
    required this.movie,
    required this.index,
    required String imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = movie.posterPath ?? "";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsView(movie: movie)),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: -15,
              child: Text(
                "${index + 1}",
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    // ignore: deprecated_member_use
                    ..color = Colors.blue.withOpacity(0.7),
                ),
              ),
            ),

            Positioned(
              right: 5,
              top: 0,
              bottom: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl.startsWith("http")
                      ? imageUrl
                      : "https://image.tmdb.org/t/p/w500$imageUrl",
                  width: 125,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 125,
                    color: Colors.grey[800],
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
