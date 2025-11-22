import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../data/details_response.dart';
import '../../../utils/api_string.dart';

class DetailsApi {
  Future<(DetailsResponse?, String)> getMovieDetails(int movieId) async {
    try {
      final uri = Uri.parse("${ApiString.details}/$movieId").replace(
        queryParameters: {'api_key': ApiString.apiKey, 'language': 'en-US'},
      );

      final response = await http.get(uri);

      log(
        'STATUS: ${response.statusCode}\n'
        'URL: ${response.request}\n'
        'BODY: ${response.body}',
      );

      if (response.statusCode == 200) {
        return (DetailsResponse.fromJson(jsonDecode(response.body)), 'success');
      } else {
        final err = jsonDecode(response.body);
        return (null, err['status_message']?.toString() ?? 'Unknown error');
      }
    } catch (e, s) {
      log('DETAILS ERROR: $e\n$s');
      return (null, 'DETAILS ERROR: $e\n$s');
    }
  }
}
