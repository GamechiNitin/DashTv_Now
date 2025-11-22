import 'package:dash_tv/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bookmarks/cubit/bookmark_cubit.dart';
import '../../../bookmarks/data/bookmark_movie.dart';
import '../../data/response/trending_reponse.dart';
import 'vertical_movie_card.dart';
import '../widget/section_header.dart';

class TrendingMovieComponent extends StatelessWidget {
  final List<TrendingResultsModel> data;

  const TrendingMovieComponent(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader("Trending"),
        const SizedBox(height: 8),

        SizedBox(
          height: 185,
          child: BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),

                itemBuilder: (context, i) {
                  final item = data[i];

                  final bool isFav = state.bookmarks.any(
                    (m) => m.id == item.id,
                  );

                  return VerticalMovieCard(
                    id: item.id ?? 0,
                    imageUrl: item.posterPath ?? "",
                    title: item.title ?? item.name ?? "No Title",
                    rating: (item.voteAverage ?? 0).toStringAsFixed(1),
                    year: (item.releaseDate ?? item.firstAirDate ?? "")
                        .split("-")
                        .first,

                    isFav: isFav,

                    onTap: () {
                      int? movieId = data[i].id;
                      context.goToDetail(movieId);
                    },

                    onSaveTap: () {
                      context.read<BookmarkCubit>().toggle(
                        BookmarkMovie(
                          id: item.id!,
                          title: item.title ?? item.name ?? "",
                          posterPath: item.posterPath ?? "",
                        ),
                      );
                    },
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
