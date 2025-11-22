import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../data/search_response.dart';
import '../../../utils/api_string.dart';

class SearchApi {
  Future<SearchResponse?> searchMovies(String query, {int page = 1}) async {
    try {
      final params = {
        "api_key": ApiString.apiKey,
        "query": query,
        "page": page.toString(),
        "include_adult": "false",
        "language": "en-US",
      };

      final uri = Uri.parse(ApiString.search).replace(queryParameters: params);

      final response = await http.get(uri);

      log(
        "STATUS: ${response.statusCode}\nURL: ${response.request}\nBODY: ${response.body}",
      );

      if (response.statusCode == 200) {
        return SearchResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e, s) {
      log("SEARCH ERROR: $e\n$s");
    }
    return null;
  }
}
