import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/search_response.dart';
import '../service/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchApi api;
  String lastQuery = "";

  SearchBloc(this.api) : super(SearchInitial()) {
    on<SearchMovieEvent>(_search);
    on<SearchNextPageEvent>(_next);
  }

  Future<void> _search(
    SearchMovieEvent event,
    Emitter<SearchState> emit,
  ) async {
    lastQuery = event.query;

    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final result = await api.searchMovies(event.query, page: 1);

      emit(
        SearchLoaded(
          result?.results ?? [],
          result?.page ?? 1,
          result?.totalPages ?? 1,
          false,
        ),
      );
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _next(
    SearchNextPageEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (state is! SearchLoaded) return;

    final s = state as SearchLoaded;
    if (s.page >= s.totalPages) return;

    emit(s.copyWith(isLoadingMore: true));

    final nextPage = s.page + 1;
    final result = await api.searchMovies(lastQuery, page: nextPage);

    emit(
      s.copyWith(
        list: [...s.list, ...result!.results!],
        page: nextPage,
        isLoadingMore: false,
      ),
    );
  }
}
