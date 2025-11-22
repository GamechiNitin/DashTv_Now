part of 'home_bloc.dart';

class HomeState {
  final bool isLoading;
  final List<TrendingResultsModel> trendingList;
  final List<NowPlaying> nowPlaying;

  HomeState({
    this.isLoading = false,
    this.trendingList = const [],
    this.nowPlaying = const [],
  });

  HomeState copyWith({
    bool? loading,
    List<TrendingResultsModel>? trendingList,
    List<NowPlaying>? nowPlaying,
  }) {
    return HomeState(
      isLoading: loading ?? isLoading,
      trendingList: trendingList ?? this.trendingList,
      nowPlaying: nowPlaying ?? this.nowPlaying,
    );
  }
}
