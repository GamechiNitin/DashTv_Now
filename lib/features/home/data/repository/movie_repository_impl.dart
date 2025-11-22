import 'dart:convert';
import '../../../../common/internet/network_utils.dart';
import '../../domain/repository/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';
import '../datasources/movie_local_datasource.dart';
import '../response/now_playing_response.dart';
import '../response/trending_reponse.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  final MovieLocalDataSource local;

  MovieRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<TrendingResultsModel>> fetchTrending() async {
    final online = await NetworkUtils.checkInternet();
    if (online) {
      final remoteRes = await remote.getTrending();
      if (remoteRes != null) {
        final raw = jsonEncode(remoteRes.toJson());
        await local.saveTrendingRaw(raw);
        return remoteRes.results ?? [];
      }
    } else {
      final cachedRaw = await local.getTrendingRaw();
      if (cachedRaw != null) {
        final parsed = TrendingResponse.fromJson(jsonDecode(cachedRaw));
        return parsed.results ?? [];
      }
    }
    return [];
  }

  @override
  Future<List<NowPlaying>> fetchNowPlaying() async {
    final online = await NetworkUtils.checkInternet();
    if (online) {
      final remoteRes = await remote.getNowPlaying();
      if (remoteRes != null) {
        final raw = jsonEncode(remoteRes.toJson());
        await local.saveNowPlayingRaw(raw);
        return remoteRes.data ?? [];
      }
    } else {
      final cachedRaw = await local.getNowPlayingRaw();
      if (cachedRaw != null) {
        final parsed = NowPlayingResponse.fromJson(jsonDecode(cachedRaw));
        return parsed.data ?? [];
      }
    }
    return [];
  }
}
