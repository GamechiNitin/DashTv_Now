part of 'bookmark_cubit.dart';

class BookmarkState {
  final List<BookmarkMovie> bookmarks;
  final bool loading;

  BookmarkState({required this.bookmarks, required this.loading});

  factory BookmarkState.initial() {
    return BookmarkState(bookmarks: <BookmarkMovie>[], loading: false);
  }

  BookmarkState copyWith({List<BookmarkMovie>? bookmarks, bool? loading}) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      loading: loading ?? this.loading,
    );
  }
}
