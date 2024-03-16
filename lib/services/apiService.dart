import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  Future<List> getPopular() async {
    final url = Uri.parse('$_baseUrl/popular');
    final response = await http.get(url);
    final body = json.decode(response.body);
    return body['data'];
  }

  Future<List> getNowPlaying() async {
    final url = Uri.parse('$_baseUrl/now-playing');
    final response = await http.get(url);
    final body = json.decode(response.body);
    return body['data'];
  }

  Future<List> getCommingSoon() async {
    final url = Uri.parse('$_baseUrl/comming-soon');
    final response = await http.get(url);
    final body = json.decode(response.body);
    return body['data'];
  }

  Future<List> getMovieDetail(int id) async {
    final query = Uri(queryParameters: {'id': id.toString()});
    final url = Uri.parse('$_baseUrl/movie?$query');
    final response = await http.get(url);
    final body = json.decode(response.body);
    return body['data'];
  }
}