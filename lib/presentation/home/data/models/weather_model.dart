import 'package:weather/presentation/home/domain/entities/weather.dart';
import 'package:weather/presentation/home/data/models/current_weather_model.dart';
import 'package:weather/presentation/home/data/models/location_model.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.location,
    required super.current,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      current: CurrentWeatherModel.fromJson(json['current'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': (location as LocationModel).toJson(),
      'current': (current as CurrentWeatherModel).toJson(),
    };
  }
}
