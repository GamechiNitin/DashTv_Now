import '../../data/response/now_playing_response.dart';
import '../../data/response/trending_reponse.dart';

abstract class MovieRepository {
  Future<List<TrendingResultsModel>> fetchTrending();
  Future<List<NowPlaying>> fetchNowPlaying();
}
