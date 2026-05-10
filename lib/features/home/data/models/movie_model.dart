import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  final dynamic id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? overview;
  @HiveField(3)
  final String? posterPath;
  @HiveField(4)
  final double? voteAverage;
  @HiveField(5)
  final String? releaseDate;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    String rawPosterPath =
        json['poster_path'] ?? json['image'] ?? json['backdrop_path'] ?? "";
    String finalPosterPath = "";

    if (rawPosterPath.isNotEmpty) {
      finalPosterPath = rawPosterPath.startsWith('http')
          ? rawPosterPath
          : "https://image.tmdb.org/t/p/w500$rawPosterPath";
    }

    return MovieModel(
      id: json['id'],
      title:
          json['title'] ??
          json['original_title'] ??
          json['name'] ??
          json['original_name'] ??
          "No Title Found",
      overview:
          json['overview'] ??
          json['description'] ??
          "No description available.",
      posterPath: finalPosterPath,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? "N/A",
    );
  }
}
