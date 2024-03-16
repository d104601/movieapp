class MovieDetail {
  final String title;
  final String vote_average;
  final List<Genre> genres;
  final String runtime;
  final String overview;

  MovieDetail.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        vote_average = json['vote_average'],
        genres = (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
        runtime = json['runtime'],
        overview = json['overview'];
}

class Genre {
  final int id;
  final String name;

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
