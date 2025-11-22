import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/response/now_playing_response.dart';
import '../../data/response/trending_reponse.dart';
import '../../domain/usecases/get_now_playing_usecase.dart';
import '../../domain/usecases/get_trending_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrendingUseCase getTrending;
  final GetNowPlayingUseCase getNowPlaying;

  HomeBloc({required this.getTrending, required this.getNowPlaying})
    : super(HomeState()) {
    on<FetchData>(_onFetchData);
    on<RefreshFetchEvent>(_refreshFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true));
    final trending = await getTrending.call();
    final nowPlaying = await getNowPlaying.call();
    emit(
      state.copyWith(
        loading: false,
        trendingList: trending,
        nowPlaying: nowPlaying,
      ),
    );
  }

  FutureOr<void> _refreshFetchData(
    RefreshFetchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeState(isLoading: true));
    final trending = await getTrending.call();
    final nowPlaying = await getNowPlaying.call();
    emit(
      HomeState(
        isLoading: false,
        trendingList: trending,
        nowPlaying: nowPlaying,
      ),
    );
  }
}
