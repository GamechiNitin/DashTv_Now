part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {}

class FetchInitialEvent extends ExploreEvent {}

class ExploreNextPageEvent extends ExploreEvent {}

class ExploreRefreshEvent extends ExploreEvent {}
