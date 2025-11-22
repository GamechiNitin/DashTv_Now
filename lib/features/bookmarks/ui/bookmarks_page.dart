import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/widget/image_widget.dart';
import '../../../core/router/app_router.dart';
import '../cubit/bookmark_cubit.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.bookmarks.isEmpty) {
          return const Scaffold(body: Center(child: Text("No bookmarks")));
        }

        return Scaffold(
          body: ListView.separated(
            padding: EdgeInsets.all(16),
            physics: BouncingScrollPhysics(),
            itemCount: state.bookmarks.length,
            separatorBuilder: (context, index) => Divider(height: 20),
            itemBuilder: (_, i) {
              final m = state.bookmarks[i];
              return ListTile(
                dense: true,
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.all(4),
                leading: m.posterPath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ImageWidget(
                          imageUrl: m.posterPath,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      )
                    : const SizedBox(width: 50),
                title: Text(m.title),
                onTap: () {
                  int? movieId = m.id;
                  context.goToDetail(movieId);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () {
                    context.read<BookmarkCubit>().toggle(m);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
