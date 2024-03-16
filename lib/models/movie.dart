class Movie {
  final String id;
  final String title;
  final String posterPath;

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        posterPath = json['poster_path'];
}