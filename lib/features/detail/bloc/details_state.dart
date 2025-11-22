part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final DetailsResponse data;
  DetailsLoaded(this.data);
}

class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}
