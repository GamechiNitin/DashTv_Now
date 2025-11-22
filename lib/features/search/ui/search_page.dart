import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router/app_router.dart';
import '../bloc/search_bloc.dart';
import 'search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();
  Timer? _debounce;

  final List<String> hintMovies = [
    "Mufasa",
    "Avengers",
    "Spider-Man",
    "Joker",
    "Frozen",
    "Moana",
    "Interstellar",
    "Inception",
    "Deadpool",
    "Batman",
  ];

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_pagination);
  }

  void _pagination() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      context.read<SearchBloc>().add(SearchNextPageEvent());
    }
  }

  void _onSearch(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      context.read<SearchBloc>().add(SearchMovieEvent(text));
    });
    setState(() {});
  }

  void _runHintSearch(String query) {
    _controller.text = query;
    _onSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: "Search movies...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: _controller.text.isEmpty
                  ? SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: hintMovies
                            .map(
                              (m) => GestureDetector(
                                onTap: () => _runHintSearch(m),
                                child: Chip(
                                  label: Text(m),
                                  backgroundColor: Colors.grey[200],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case SearchInitial:
                            return const Center(
                              child: Text(
                                "Type to search",
                                textAlign: TextAlign.center,
                              ),
                            );
                          case SearchLoading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case SearchError:
                            return Center(
                              child: Text((state as SearchError).msg),
                            );
                          case SearchLoaded:
                            final list = (state as SearchLoaded).list;
                            return ListView.builder(
                              controller: _scroll,
                              itemCount: list.length + 1,
                              itemBuilder: (_, i) {
                                if (i == list.length) {
                                  return state.isLoadingMore
                                      ? const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : const SizedBox();
                                }
                                final item = list[i];
                                return GestureDetector(
                                  onTap: () => context.goToDetail(item.id),
                                  child: SearchCard(
                                    title: item.title ?? '',
                                    overview: item.overview ?? '',
                                    backdropPath: item.backdropPath ?? '',
                                    releaseDate: (item.releaseDate ?? '')
                                        .split('-')
                                        .first,
                                    rating: (item.voteAverage ?? 0).toDouble(),
                                  ),
                                );
                              },
                            );
                        }
                        return const SizedBox();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
