import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/failure.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/features/home/domain/entities/weather.dart';
import 'package:weather/features/home/domain/repositories/weather_repository.dart';

class WeatherParams {
  final String? cityName;

  const WeatherParams({this.cityName});
}

class GetWeatherUseCase {
  final WeatherRepository repository;
  final LocationService locationService;

  const GetWeatherUseCase(this.repository, this.locationService);

  Future<Either<Failure, WeatherEntity>> call(WeatherParams params) async {
    final cityName = params.cityName?.trim();

    if (cityName != null && cityName.isNotEmpty) {
      return await repository.getWeather(cityName);
    }

    try {
      final currentCity = await locationService.getCurrentCityName();
      if (currentCity == null || currentCity.trim().isEmpty) {
        return Left(
          Failure(errMessage: 'Unable to determine the current location.'),
        );
      }
      return await repository.getWeather(currentCity);
    } catch (error) {
      return Left(Failure(errMessage: error.toString()));
    }
  }
}
