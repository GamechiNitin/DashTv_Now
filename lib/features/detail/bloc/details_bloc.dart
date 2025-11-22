import 'package:dash_tv/features/detail/data/details_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/internet/network_utils.dart';
import '../data/cache_helper.dart';
import '../data/details_response.dart';
import '../repository/detail_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<FetchDetailsEvent>((event, emit) async {
      final repo = DetailsRepository(DetailsApi());
      emit(DetailsLoading());

      try {
        final online = await NetworkUtils.checkInternet();

        if (online) {
          final res = await repo.getMovieDetails(event.movieId);

          if (res.$1 != null) {
            await CacheHelper.saveMovieDetails(event.movieId, res.$1!.toJson());
            emit(DetailsLoaded(res.$1!));
          } else {
            emit(DetailsError(res.$2));
          }
        } else {
          final cached = await CacheHelper.getMovieDetails(event.movieId);

          if (cached != null) {
            emit(DetailsLoaded(cached));
          } else {
            emit(DetailsError("No Internet"));
          }
        }
      } catch (e) {
        emit(DetailsError(e.toString()));
      }
    });
  }
}
