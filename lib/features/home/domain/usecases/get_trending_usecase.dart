import '../../data/response/trending_reponse.dart';
import '../repository/movie_repository.dart';

class GetTrendingUseCase {
  final MovieRepository repository;
  GetTrendingUseCase(this.repository);
  Future<List<TrendingResultsModel>> call() async {
    return await repository.fetchTrending();
  }
}
