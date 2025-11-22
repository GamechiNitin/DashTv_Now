part of 'app_router.dart';

enum AppRouteEnum { splash, home, detail, search }

extension NavigationExt on BuildContext {
  void goToDetail(int? movieId) {
    if (movieId != null) {
      GoRouter.of(this).pushNamed(
        AppRouteEnum.detail.name,
        queryParameters: {"id": movieId.toString()},
      );
    } else {
      Helper.toast(context: this, text: 'Movie ID is missing');
    }
  }
}
