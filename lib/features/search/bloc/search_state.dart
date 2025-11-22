part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SearchModel> list;
  final int page;
  final int totalPages;
  final bool isLoadingMore;

  SearchLoaded(this.list, this.page, this.totalPages, this.isLoadingMore);

  SearchLoaded copyWith({
    List<SearchModel>? list,
    int? page,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return SearchLoaded(
      list ?? this.list,
      page ?? this.page,
      totalPages ?? this.totalPages,
      isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class SearchError extends SearchState {
  final String msg;
  SearchError(this.msg);
}
