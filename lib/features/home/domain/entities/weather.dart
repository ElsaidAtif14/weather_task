import 'package:weather/features/home/domain/entities/current_weather.dart';
import 'package:weather/features/home/domain/entities/location.dart';

class WeatherEntity {
  final LocationEntity location;
  final CurrentWeatherEntity current;

  const WeatherEntity({
    required this.location,
    required this.current,
  });
}
