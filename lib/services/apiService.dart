import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/movieDetail.dart';
import '../models/movie.dart';

class ApiService {
  static const String _baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  static Future<List<Movie>> getPopular() async {
    final url = Uri.parse('$_baseUrl/popular');
    final response = await http.get(url);
    final body = json.decode(response.body);

    List<Movie> movies = [];

    if(response.statusCode == 200) {
      for(var movie in body['results']) {
        final value = Movie.fromJson(movie);
        movies.add(value);
      }
      return movies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Movie>> getNowPlaying() async {
    final url = Uri.parse('$_baseUrl/now-playing');
    final response = await http.get(url);
    final body = json.decode(response.body);

    List<Movie> movies = [];
    if(response.statusCode == 200) {
      for(var movie in body['results']) {
        final value = Movie.fromJson(movie);
        movies.add(value);
      }
      return movies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Movie>> getComingSoon() async {
    final url = Uri.parse('$_baseUrl/coming-soon');
    final response = await http.get(url);
    final body = json.decode(response.body);

    List<Movie> movies = [];
    if(response.statusCode == 200) {
      for(var movie in body['results']) {
        final value = Movie.fromJson(movie);
        movies.add(value);
      }
      return movies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<MovieDetail> getMovieDetail(int id) async {
    final query = Uri(queryParameters: {'id': id.toString()});
    final url = Uri.parse('$_baseUrl/movie$query');
    final response = await http.get(url);
    final body = json.decode(response.body);
    if(response.statusCode == 200) {
      return MovieDetail.fromJson(body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}