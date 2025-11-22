import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'common/internet/cubit/internet_cubit.dart';
import 'common/internet/http_override.dart';
import 'common/internet/internet_banner.dart';
import 'features/bookmarks/cubit/bookmark_cubit.dart';
import 'features/bookmarks/data/repo/bookmark_repo.dart';
import 'features/explore/ui/bloc/explore_bloc.dart';
import 'features/explore/service/explore_service.dart';
import 'features/home/ui/bloc/home_bloc.dart';
import 'core/router/app_router.dart';
import 'core/services/di/injection.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  HttpOverrides.global = MyHttpOverrides();
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => InternetCubit()),
        BlocProvider(create: (context) => di<HomeBloc>()..add(FetchData())),
        BlocProvider(
          create: (context) =>
              ExploreBloc(ExploreApi())..add(FetchInitialEvent()),
        ),
        BlocProvider(
          create: (context) => BookmarkCubit(BookmarkRepo())..load(),
        ),
      ],
      child: MaterialApp.router(
        title: 'DashTv',
        theme: dashTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          return InternetBanner(
            showAtTop: false,
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
