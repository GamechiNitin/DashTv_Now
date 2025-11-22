// go_router setup
import 'package:dash_tv/features/search/ui/search_page.dart';
import 'package:dash_tv/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/detail/detail_page.dart';
import '../../features/navbar/navbar_page.dart';
import '../../features/search/bloc/search_bloc.dart';
import '../../features/search/service/search_service.dart';
import '../../utils/helper.dart';
part 'app_route_enum.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRouteEnum.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/${AppRouteEnum.search.name}',
        name: AppRouteEnum.search.name,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchBloc(SearchApi()),
          child: const SearchPage(),
        ),
      ),
      GoRoute(
        path: '/${AppRouteEnum.home.name}',
        name: AppRouteEnum.home.name,
        builder: (context, state) => const NavBarPage(),
      ),

      // GoRoute(
      //   path: '/${AppRouteEnum.detail.name}',
      //   name: AppRouteEnum.detail.name,
      //   builder: (context, state) {
      //     final int movieId = state.extra as int;
      //     return DetailsPage(movieId: movieId);
      //   },
      // ),
      GoRoute(
        path: '/detail',
        name: AppRouteEnum.detail.name,
        builder: (context, state) {
          final id = int.tryParse(state.uri.queryParameters['id'] ?? '');
          if (id == null) {
            return const SizedBox(); // invalid
          }
          return DetailsPage(movieId: id);
        },
      ),
    ],
  );
}
