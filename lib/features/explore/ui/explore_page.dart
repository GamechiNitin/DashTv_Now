import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router/app_router.dart';
import 'bloc/explore_bloc.dart';
import 'explore_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_pagination);
  }

  void _pagination() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      context.read<ExploreBloc>().add(ExploreNextPageEvent());
    }
  }

  Future<void> _onRefresh() async {
    context.read<ExploreBloc>().add(ExploreRefreshEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ExploreInitial:
              return const Center(child: Text("No data"));
            case ExploreLoading:
              return const Center(child: CircularProgressIndicator());
            case ExploreError:
              return Center(child: Text((state as ExploreError).message));
            case ExploreLoaded:
              final loadedState = state as ExploreLoaded;
              final list = loadedState.list;

              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: _scroll,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              // childAspectRatio: ,
                              mainAxisExtent: 220,
                            ),
                        itemCount: list.length,
                        itemBuilder: (_, i) {
                          final item = list[i];
                          return GestureDetector(
                            onTap: () {
                              context.goToDetail(item.id);
                            },
                            child: ExploreCard(
                              title: item.title ?? 'No Title',
                              overview: item.overview ?? '',
                              backdropPath: item.backdropPath ?? '',
                              releaseDate: (item.releaseDate ?? '')
                                  .split('-')
                                  .first,
                              rating: (item.voteAverage ?? 0).toDouble(),
                            ),
                          );
                        },
                      ),
                    ),
                    if (loadedState.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
