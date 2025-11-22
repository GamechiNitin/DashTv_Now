part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class FetchDetailsEvent extends DetailsEvent {
  final int movieId;
  FetchDetailsEvent(this.movieId);
}
