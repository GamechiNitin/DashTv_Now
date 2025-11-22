import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../bookmark_movie.dart';

class BookmarkRepo {
  static const key = "bookmarks";

  Future<List<BookmarkMovie>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => BookmarkMovie.fromMap(e))
        .toList();
  }

  Future<void> save(List<BookmarkMovie> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(list.map((e) => e.toMap()).toList()));
  }
}
