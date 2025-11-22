import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bookmarks/cubit/bookmark_cubit.dart';
import '../bookmarks/data/bookmark_movie.dart';
import '../navbar/drawer/drawer_menu_service.dart';
import 'bloc/details_bloc.dart';

class DetailsPage extends StatelessWidget {
  final int movieId;
  const DetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsBloc()..add(FetchDetailsEvent(movieId)),
      child: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leadingWidth: 70,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.keyboard_backspace_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    DrawerMenuService.shareMovie(movieId);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.share, color: Colors.blue, size: 18),
                  ),
                ),
                BlocBuilder<BookmarkCubit, BookmarkState>(
                  builder: (context, bookstate) {
                    if (state is DetailsLoaded) {
                      final bool isFav = bookstate.bookmarks.any(
                        (m) => m.id == movieId,
                      );
                      final data = state.data;
                      return GestureDetector(
                        onTap: () {
                          context.read<BookmarkCubit>().toggle(
                            BookmarkMovie(
                              id: movieId,
                              title: data.title ?? "",
                              posterPath: data.posterPath ?? "",
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(right: 20),
                          // padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.redAccent : Colors.white,
                            size: 18,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state is DetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DetailsError) {
                  return Center(child: Text(state.message));
                }

                if (state is DetailsLoaded) {
                  final data = state.data;

                  return Column(
                    children: [
                      // const SizedBox(height: 50),
                      Stack(
                        children: [
                          Image.network(
                            "https://image.tmdb.org/t/p/w780${data.backdropPath}",
                            height: 260,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: 260,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.95),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w300${data.posterPath}",
                                    height: 150,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.title ?? "",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (data.tagline != null &&
                                        data.tagline!.isNotEmpty)
                                      Text(
                                        data.tagline!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title("Overview"),
                              text(data.overview),
                              const SizedBox(height: 20),
                              title("Genres"),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 8,
                                children:
                                    data.genres
                                        ?.map(
                                          (g) => Chip(
                                            label: Text(g.name ?? ""),
                                            backgroundColor: Colors.grey[200],
                                          ),
                                        )
                                        .toList() ??
                                    [],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  info("Release", data.releaseDate),
                                  info("Runtime", "${data.runtime} min"),
                                  info("Rating", "${data.voteAverage} ⭐"),
                                ],
                              ),
                              const SizedBox(height: 20),
                              title("Original Info"),
                              info("Original Title", data.originalTitle),
                              info("Language", data.originalLanguage),
                              const SizedBox(height: 12),
                              subSection(
                                "Spoken Languages",
                                data.spokenLanguages
                                    ?.map((e) => e.englishName)
                                    .toList(),
                              ),
                              const SizedBox(height: 20),
                              title("Production Companies"),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      data.productionCompanies?.length ?? 0,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 16),
                                  itemBuilder: (_, i) {
                                    final pc = data.productionCompanies![i];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (pc.logoPath != null)
                                          Image.network(
                                            "https://image.tmdb.org/t/p/w200${pc.logoPath}",
                                            height: 40,
                                          ),
                                        const SizedBox(height: 6),
                                        Text(
                                          pc.name ?? "",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              title("Production Countries"),
                              Wrap(
                                spacing: 8,
                                children:
                                    data.productionCountries
                                        ?.map(
                                          (e) => Chip(
                                            label: Text(e.name ?? ""),
                                            backgroundColor: Colors.grey[200],
                                          ),
                                        )
                                        .toList() ??
                                    [],
                              ),
                              const SizedBox(height: 20),
                              title("Collection"),
                              if (data.belongsToCollection != null) ...[
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Image.network(
                                      "https://image.tmdb.org/t/p/w200${data.belongsToCollection!.posterPath}",
                                      height: 100,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      data.belongsToCollection!.name ?? "",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  info("Budget", "\$${data.budget}"),
                                  info("Revenue", "\$${data.revenue}"),
                                  info("Popularity", "${data.popularity}"),
                                ],
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }

  Widget title(String t) => Text(
    t,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  );

  Widget text(String? v) => Text(v ?? "-", style: const TextStyle(height: 1.4));

  Widget info(String t, String? v) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(t, style: const TextStyle(color: Colors.black54, fontSize: 12)),
      const SizedBox(height: 2),
      Text(v ?? "-", style: const TextStyle(fontSize: 14)),
    ],
  );

  Widget subSection(String t, List<dynamic>? values) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(t, style: const TextStyle(fontSize: 16)),
      const SizedBox(height: 6),
      Wrap(
        spacing: 8,
        children:
            values
                ?.map(
                  (e) => Chip(
                    label: Text(e ?? ""),
                    backgroundColor: Colors.grey[200],
                  ),
                )
                .toList() ??
            [],
      ),
    ],
  );
}
