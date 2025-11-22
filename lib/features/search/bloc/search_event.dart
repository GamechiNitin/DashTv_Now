part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchMovieEvent extends SearchEvent {
  final String query;
  SearchMovieEvent(this.query);
}

class SearchNextPageEvent extends SearchEvent {}
