import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/constant/cache_key.dart';

class MovieLocalDataSource {
  Future<void> saveTrendingRaw(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(trendingKey, json);
  }

  Future<void> saveNowPlayingRaw(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(nowPlayingKey, json);
  }

  Future<String?> getTrendingRaw() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(trendingKey);
  }

  Future<String?> getNowPlayingRaw() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nowPlayingKey);
  }
}
