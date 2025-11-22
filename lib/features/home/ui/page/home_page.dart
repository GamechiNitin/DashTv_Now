import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_tv/features/home/ui/bloc/home_bloc.dart';
import 'package:dash_tv/features/home/ui/widget/home_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widget/image_widget.dart';
import '../../../../core/router/app_router.dart';
import '../../../../utils/dimens.dart';
import '../component/playing_movie_component.dart';
import '../component/trending_movie_component.dart';
import '../widget/section_header.dart';

final List<String> genres = [
  "Action",
  "Drama",
  "Sci-Fi",
  "Comedy",
  "Horror",
  "Romance",
  "Thriller",
  "Fantasy",
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(RefreshFetchEvent());
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: state.isLoading
                    ? const HomePageShimmer()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 210,
                              // viewportFraction: 0.2,
                              aspectRatio: 16 / 9,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: true,
                              autoPlay: true,

                              autoPlayInterval: const Duration(seconds: 10),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,

                              // enlargeFactor: 0.4,
                              // onPageChanged: callbackFunction,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: state.trendingList.map((i) {
                              return GestureDetector(
                                onTap: () {
                                  int? movieId = i.id;
                                  context.goToDetail(movieId);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          kCardBorderRadius,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          kCardBorderRadius,
                                        ),
                                        child: ImageWidget(
                                          imageUrl: i.posterPath,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 30,
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 12.0,
                                          right: 60,
                                          bottom: 12,
                                          top: 12,
                                        ),
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                              kCardBorderRadius,
                                            ),
                                            bottomRight: Radius.circular(
                                              kCardBorderRadius,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          i.originalTitle ?? "",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: size14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 30,
                                      child: Container(
                                        width: 60,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          // color: kDeepOrangeColor,
                                          borderRadius: BorderRadius.circular(
                                            kBorderRadius,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            kBorderRadius,
                                          ),
                                          child: ImageWidget(
                                            imageUrl: i.posterPath,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),

                          TrendingMovieComponent(state.trendingList),
                          const SizedBox(height: 20),
                          PlayingMovieComponent(state.nowPlaying),
                          const SizedBox(height: 20),
                          SectionHeader("Genres"),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              itemBuilder: (_, i) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black12,
                                ),
                                child: Center(child: Text(genres[i])),
                              ),
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 10),
                              itemCount: genres.length,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
