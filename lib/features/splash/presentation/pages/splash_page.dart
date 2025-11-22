import 'package:dash_tv/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:dash_tv/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widget/title_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: SplashBloc()..add(SplashStarted()),
      listener: (context, state) {
        if (state is SplashLoaded) {
          GoRouter.of(context).goNamed(AppRouteEnum.home.name);
        }
      },
      child: const Scaffold(body: Center(child: DashTvTitle())),
    );
  }
}
