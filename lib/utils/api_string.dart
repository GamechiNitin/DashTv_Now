import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiString {
  static String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  static String apiKey = dotenv.env['API_TOKEN']!;
  static String trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day';
  static String nowPlaying = 'https://api.themoviedb.org/3/movie/now_playing';
  static String search = 'https://api.themoviedb.org/3/search/movie';
  static String explore = 'https://api.themoviedb.org/3/trending/all/day';
  static String details = 'https://api.themoviedb.org/3/movie';
}
