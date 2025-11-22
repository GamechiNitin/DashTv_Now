import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../utils/api_string.dart';
import '../response/now_playing_response.dart';
import '../response/trending_reponse.dart';

class MovieRemoteDataSource {
  Future<TrendingResponse?> getTrending() async {
    Map<String, String> requestParams = {'api_key': ApiString.apiKey};

    var uri = Uri.parse(ApiString.trendingUrl);
    uri = uri.replace(queryParameters: requestParams);

    final response = await http.get(uri);

    log(
      ":::::: ${response.statusCode} ${response.request} \n ${response.body}",
    );

    try {
      if (response.statusCode == 200) {
        TrendingResponse trendingResponse = TrendingResponse.fromJson(
          jsonDecode(response.body),
        );
        return trendingResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<NowPlayingResponse?> getNowPlaying() async {
    Map<String, String> requestParams = {'api_key': ApiString.apiKey};

    var uri = Uri.parse(ApiString.nowPlaying);
    uri = uri.replace(queryParameters: requestParams);

    final response = await http.get(uri);

    log(
      ":::::: ${response.statusCode} ${response.request} \n ${response.body}",
    );

    try {
      if (response.statusCode == 200) {
        NowPlayingResponse results = NowPlayingResponse.fromJson(
          jsonDecode(response.body),
        );
        return results;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
