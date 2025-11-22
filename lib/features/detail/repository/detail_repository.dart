import '../data/details_api.dart';
import '../data/details_response.dart';

class DetailsRepository {
  final DetailsApi apiService;

  DetailsRepository(this.apiService);

  Future<(DetailsResponse?, String)> getMovieDetails(int id) async {
    return await apiService.getMovieDetails(id);
  }
}
