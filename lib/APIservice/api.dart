import 'dart:convert';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=$apikey";
  static const _nowPlayingUrl =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey";
  static const _horrorMovies =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apikey&with_genres=27";
  static const _comedyMovies =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apikey&with_genres=35";
  static const _malayalamMovies =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apikey&with_original_language=ml&sort_by=popularity.desc";
  static const _top10Movies =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apikey&sort_by=popularity.desc";

  String _getComingSoonUrl() {
    final today = DateTime.now().toIso8601String().split('T').first;
    final endDate =
        DateTime.now().add(Duration(days: 30)).toIso8601String().split('T').first;
    return "https://api.themoviedb.org/3/discover/movie?api_key=$apikey&sort_by=release_date.asc&primary_release_date.gte=$today&primary_release_date.lte=$endDate";
  }

  Future<List<Movie>> getTopTenMovies() async {
    try {
      final response = await http.get(Uri.parse(_top10Movies));
      return _processResponse(response);
    } catch (e) {
      print('Error fetching top 10 movies: $e');
      return [];
    }
  }

  Future<List<Movie>> getMalayalamMovies() async {
    try {
      final response = await http.get(Uri.parse(_malayalamMovies));
      return _processResponse(response);
    } catch (e) {
      print('Error fetching Malayalam movies: $e');
      return [];
    }
  }

  Future<List<Movie>> getHorrorMovies() async {
    try {
      final response = await http.get(Uri.parse(_horrorMovies));
      return _processResponse(response);
    } catch (e) {
      print('Error fetching horror movies: $e');
      return [];
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final response = await http.get(Uri.parse(_nowPlayingUrl));
      return _processResponse(response);
    } catch (e) {
      print('Error fetching now playing movies: $e');
      return [];
    }
  }

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse(_trendingUrl));
      return _processResponse(response);
    } catch (e) {
      print('Error fetching trending movies: $e');
      return [];
    }
  }

  Future<List<Movie>> getComedyMovies() async {
    try {
      final response = await http.get(Uri.parse(_comedyMovies));
      return _processResponse(response);
    } catch (e) {
      print('Error fetching comedy movies: $e');
      return [];
    }
  }

  Future<List<Movie>> getComingSoonMovies() async {
    final url = _getComingSoonUrl();
    try {
      final response = await http.get(Uri.parse(url));
      return _processResponse(response);
    } catch (e) {
      print('Error fetching coming soon movies: $e');
      return [];
    }
  }

  List<Movie> _processResponse(http.Response response) {
    try {
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['results'] as List;
        print(decodedData);
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error processing response: $e');
      return [];
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=$apikey&query=$query"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Movie> movies = (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
        return movies;
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error searching movies: $e');
      return [];
    }
  }
}
