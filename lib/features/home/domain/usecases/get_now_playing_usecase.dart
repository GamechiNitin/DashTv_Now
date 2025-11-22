import '../../data/response/now_playing_response.dart';
import '../repository/movie_repository.dart';

class GetNowPlayingUseCase {
  final MovieRepository repository;
  GetNowPlayingUseCase(this.repository);
  Future<List<NowPlaying>> call() async {
    return await repository.fetchNowPlaying();
  }
}
