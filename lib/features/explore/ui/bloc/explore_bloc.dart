import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/internet/network_utils.dart';
import '../../data/explore_response.dart';
import '../../service/explore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ExploreApi api;

  ExploreBloc(this.api) : super(ExploreInitial()) {
    on<FetchInitialEvent>(_fetchInitial);
    on<ExploreNextPageEvent>(_next);
    on<ExploreRefreshEvent>(_refresh);
  }

  Future<void> _cachePage(int page, ExploreResponse data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('explore_page_$page', jsonEncode(data.toJson()));
  }

  Future<ExploreResponse?> _loadPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('explore_page_$page');
    if (str == null) return null;
    return ExploreResponse.fromJson(jsonDecode(str));
  }

  Future<void> _clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith('explore_page_'));
    for (final k in keys) {
      prefs.remove(k);
    }
  }

  Future<void> _fetchInitial(
    FetchInitialEvent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(ExploreLoading());
    final online = await NetworkUtils.checkInternet();

    if (!online) {
      final cached = await _loadPage(1);
      if (cached != null) {
        emit(
          ExploreLoaded(
            cached.results ?? [],
            cached.page ?? 1,
            cached.totalPages ?? 1,
            false,
          ),
        );
        return;
      }
      emit(ExploreError('No internet'));
      return;
    }

    try {
      final result = await api.explore(page: 1);
      if (result != null) _cachePage(1, result);

      emit(
        ExploreLoaded(
          result?.results ?? [],
          result?.page ?? 1,
          result?.totalPages ?? 1,
          false,
        ),
      );
    } catch (_) {
      emit(ExploreError('Something went wrong'));
    }
  }

  Future<void> _next(
    ExploreNextPageEvent event,
    Emitter<ExploreState> emit,
  ) async {
    if (state is! ExploreLoaded) return;
    final s = state as ExploreLoaded;
    if (s.page >= s.totalPages) return;

    final nextPage = s.page + 1;
    final online = await NetworkUtils.checkInternet();

    if (!online) {
      final cached = await _loadPage(nextPage);
      if (cached == null) return;

      emit(
        s.copyWith(
          list: [...s.list, ...?cached.results],
          page: nextPage,
          isLoadingMore: false,
        ),
      );
      return;
    }

    emit(s.copyWith(isLoadingMore: true));

    final result = await api.explore(page: nextPage);
    if (result != null) _cachePage(nextPage, result);

    emit(
      s.copyWith(
        list: [...s.list, ...?result?.results],
        page: nextPage,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> _refresh(
    ExploreRefreshEvent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(ExploreLoading());
    final online = await NetworkUtils.checkInternet();

    if (!online) {
      final cached = await _loadPage(1);
      if (cached != null) {
        emit(
          ExploreLoaded(
            cached.results ?? [],
            cached.page ?? 1,
            cached.totalPages ?? 1,
            false,
          ),
        );
      }
      return;
    }

    await _clearCache();

    try {
      final result = await api.explore(page: 1);
      if (result != null) _cachePage(1, result);

      emit(
        ExploreLoaded(
          result?.results ?? [],
          result?.page ?? 1,
          result?.totalPages ?? 1,
          false,
        ),
      );
    } catch (_) {}
  }
}
