import 'dart:convert';
import 'package:dash_tv/features/detail/data/details_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/constant/cache_key.dart';

class CacheHelper {
  static Future<void> saveMovieDetails(
    int id,
    Map<String, dynamic> json,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("$movieCacheKey$id", jsonEncode(json));
  }

  static Future<DetailsResponse?> getMovieDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("$movieCacheKey$id");
    if (data == null) return null;
    return DetailsResponse.fromJson(jsonDecode(data));
  }

  static Future<bool> isMovieCached(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("$movieCacheKey$id");
  }
}
