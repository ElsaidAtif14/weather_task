import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/connection/network_info.dart';
import 'package:weather/core/errors/failure.dart';
import 'package:weather/core/errors/expentions.dart';
import 'package:weather/features/home/data/datasources/weather_local_data_source.dart';
import 'package:weather/features/home/data/datasources/weather_remote_data_source.dart';
import 'package:weather/features/home/domain/entities/weather.dart';
import 'package:weather/features/home/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(String query) async {
    final connected = await networkInfo.isConnected;

    if (connected) {
      try {
        final weatherModel = await remoteDataSource.getCurrentWeather(query);
        await localDataSource.cacheWeather(weatherModel);
        return Right(weatherModel);
      } on ServerException catch (e) {
        return left(Failure(errMessage: e.errorModel.errorMessage));
      } catch (e) {
        debugPrint('❌❌❌❌${e.toString()}');
        return Left(Failure(errMessage: 'Some thing Error in get Weather'));
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      } catch (e) {
        return Left(Failure(errMessage: 'Some thing Error in get Weather'));
      }
    }
  }
}
