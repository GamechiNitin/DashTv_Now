import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_router.dart';
import '../../../bookmarks/cubit/bookmark_cubit.dart';
import '../../../bookmarks/data/bookmark_movie.dart';
import '../../data/response/now_playing_response.dart';
import 'horizontal_movie_card.dart';
import '../widget/section_header.dart';

class PlayingMovieComponent extends StatelessWidget {
  final List<NowPlaying> data;
  const PlayingMovieComponent(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader("Now Playing"),
        const SizedBox(height: 8),
        SizedBox(
          height: 175,
          child: BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (_, i) {
                  final item = data[i];

                  final bool isFav = state.bookmarks.any(
                    (m) => m.id == item.id,
                  );
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    // margin: const EdgeInsets.all(12),
                    child: HorizontalMovieCard(
                      imageUrl: data[i].posterPath ?? "",
                      title: data[i].title ?? "No Title",
                      rating: data[i].voteAverage?.toStringAsFixed(1) ?? "--",
                      year: (data[i].releaseDate ?? "").split("-").first,
                      isFav: isFav,
                      onTap: () {
                        int? movieId = data[i].id;
                        context.goToDetail(movieId);
                      },
                      onSaveTap: () {
                        context.read<BookmarkCubit>().toggle(
                          BookmarkMovie(
                            id: item.id!,
                            title: item.title ?? "No Title",
                            posterPath: item.posterPath ?? "",
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
