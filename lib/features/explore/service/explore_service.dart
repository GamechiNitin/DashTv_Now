import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../data/explore_response.dart';
import '../../../utils/api_string.dart';

class ExploreApi {
  Future<ExploreResponse?> explore({int page = 1}) async {
    try {
      final params = {
        "api_key": ApiString.apiKey,
        "page": page.toString(),
        "language": "en-US",
      };

      final uri = Uri.parse(ApiString.explore).replace(queryParameters: params);

      final response = await http.get(uri);

      log(
        "STATUS: ${response.statusCode}\nURL: ${response.request}\nBODY: ${response.body}",
      );

      if (response.statusCode == 200) {
        return ExploreResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e, s) {
      log("SEARCH ERROR: $e\n$s");
    }
    return null;
  }
}
