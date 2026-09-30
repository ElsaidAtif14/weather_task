import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/connection/network_info.dart';
import 'package:weather/core/connection/network_status_checker.dart';
import 'package:weather/core/databases/api/api_consumer.dart';
import 'package:weather/core/databases/api/dio_consumer.dart';
import 'package:weather/core/databases/cache/cache_helper.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/features/home/presentation/cubit/weather_cubit.dart';
import 'package:weather/features/home/data/datasources/weather_local_data_source.dart';
import 'package:weather/features/home/data/datasources/weather_remote_data_source.dart';
import 'package:weather/features/home/data/repositories/weather_repository_impl.dart';
import 'package:weather/features/home/domain/usecases/get_weather_usecase.dart';

final sl = GetIt.instance;

Future<void> initDebendency() async {
  // Core
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(checker: NetworkStatusChecker()),
  );
  sl.registerLazySingleton<LocationService>(() => LocationServiceImpl());

  // External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiConsumer>((() => DioConsumer(dio: sl<Dio>())));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(apiConsumer: sl<ApiConsumer>()),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(cacheHelper: sl<CacheHelper>()),
  );

  // Repository
  sl.registerLazySingleton<WeatherRepositoryImpl>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl<WeatherRemoteDataSource>(),
      localDataSource: sl<WeatherLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use case
  sl.registerLazySingleton<GetWeatherUseCase>(
    () => GetWeatherUseCase(sl<WeatherRepositoryImpl>(), sl<LocationService>()),
  );

  // Cubit
  sl.registerFactory<WeatherCubit>(
    () => WeatherCubit(getWeatherUseCase: sl<GetWeatherUseCase>()),
  );

  await sl<CacheHelper>().init();
}
