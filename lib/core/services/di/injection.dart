import 'package:get_it/get_it.dart';
import '../../../features/home/ui/bloc/home_bloc.dart';
import '../../../features/home/data/datasources/movie_local_datasource.dart';
import '../../../features/home/data/datasources/movie_remote_datasource.dart';
import '../../../features/home/data/repository/movie_repository_impl.dart';
import '../../../features/home/domain/repository/movie_repository.dart';
import '../../../features/home/domain/usecases/get_now_playing_usecase.dart';
import '../../../features/home/domain/usecases/get_trending_usecase.dart';

final GetIt di = GetIt.instance;

Future<void> initDI() async {
  di.registerLazySingleton(() => MovieRemoteDataSource());
  di.registerLazySingleton(() => MovieLocalDataSource());
  di.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remote: di(), local: di()),
  );
  di.registerLazySingleton(() => GetTrendingUseCase(di()));
  di.registerLazySingleton(() => GetNowPlayingUseCase(di()));
  di.registerFactory(() => HomeBloc(getTrending: di(), getNowPlaying: di()));
}
