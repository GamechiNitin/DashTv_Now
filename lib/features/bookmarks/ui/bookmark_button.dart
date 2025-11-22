// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/bookmark_bloc.dart';
// import '../data/bookmark_movie.dart';

// class BookmarkButton extends StatelessWidget {
//   final int id;
//   final String title;
//   final String poster;

//   const BookmarkButton({
//     super.key,
//     required this.id,
//     required this.title,
//     required this.poster,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BookmarkBloc, BookmarkState>(
//       builder: (context, state) {
//         bool marked = false;

//         if (state is BookmarkLoaded) {
//           marked = state.bookmarks.any((b) => b.id == id);
//         }

//         return IconButton(
//           onPressed: () {
//             context.read<BookmarkBloc>().add(
//               ToggleBookmark(
//                 BookmarkMovie(id: id, title: title, posterPath: poster),
//               ),
//             );
//           },
//           icon: Icon(
//             marked ? Icons.bookmark : Icons.bookmark_border,
//             color: marked ? Colors.red : Colors.black,
//           ),
//         );
//       },
//     );
//   }
// }
