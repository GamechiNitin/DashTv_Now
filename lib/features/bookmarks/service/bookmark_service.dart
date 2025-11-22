import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/bookmark_movie.dart';

class BookmarkService {
  static const _key = "bookmark_movies";

  Future<List<BookmarkMovie>> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    return list.map((e) => BookmarkMovie.fromMap(jsonDecode(e))).toList();
  }

  Future<void> toggleBookmark(BookmarkMovie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    final movies = list
        .map((e) => BookmarkMovie.fromMap(jsonDecode(e)))
        .toList();

    final exists = movies.any((m) => m.id == movie.id);

    if (exists) {
      movies.removeWhere((m) => m.id == movie.id);
    } else {
      movies.add(movie);
    }

    final encoded = movies.map((m) => jsonEncode(m.toMap())).toList();

    await prefs.setStringList(_key, encoded);
  }

  Future<bool> isBookmarked(int id) async {
    final bookmarks = await loadBookmarks();
    return bookmarks.any((m) => m.id == id);
  }
}
