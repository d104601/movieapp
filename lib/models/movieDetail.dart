class MovieDetail {
  final String title;
  final double vote_average;
  final List<Genre> genres;
  final int runtime;
  final String overview;
  final String homepage;

  MovieDetail.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        vote_average = json['vote_average'],
        genres = (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
        runtime = json['runtime'],
        overview = json['overview'],
        homepage = json['homepage'];
}

class Genre {
  final int id;
  final String name;

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
