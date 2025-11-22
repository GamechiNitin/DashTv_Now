part of 'explore_bloc.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<dynamic> list;
  final int page;
  final int totalPages;
  final bool isLoadingMore;

  ExploreLoaded(this.list, this.page, this.totalPages, this.isLoadingMore);

  ExploreLoaded copyWith({
    List<dynamic>? list,
    int? page,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return ExploreLoaded(
      list ?? this.list,
      page ?? this.page,
      totalPages ?? this.totalPages,
      isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ExploreError extends ExploreState {
  final String message;
  ExploreError(this.message);
}
