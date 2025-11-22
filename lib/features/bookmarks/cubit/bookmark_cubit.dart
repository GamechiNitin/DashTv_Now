import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bookmark_movie.dart';
import '../data/repo/bookmark_repo.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final BookmarkRepo repo;

  BookmarkCubit(this.repo) : super(BookmarkState.initial()) {
    load();
  }

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    final List<BookmarkMovie> data = await repo.load();
    emit(state.copyWith(bookmarks: data, loading: false));
  }

  Future<void> toggle(BookmarkMovie movie) async {
    final List<BookmarkMovie> list = List<BookmarkMovie>.from(state.bookmarks);

    final bool exists = list.any((x) => x.id == movie.id);

    if (exists) {
      list.removeWhere((x) => x.id == movie.id);
    } else {
      list.add(movie);
    }

    await repo.save(list);
    emit(state.copyWith(bookmarks: list));
  }

  bool isSaved(int id) {
    return state.bookmarks.any((x) => x.id == id);
  }
}
