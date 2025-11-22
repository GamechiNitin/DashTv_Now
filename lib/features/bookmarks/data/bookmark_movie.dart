class BookmarkMovie {
  final int id;
  final String title;
  final String posterPath;

  BookmarkMovie({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory BookmarkMovie.fromMap(Map<String, dynamic> map) {
    return BookmarkMovie(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "posterPath": posterPath};
  }
}
