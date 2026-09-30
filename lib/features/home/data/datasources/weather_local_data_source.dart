import 'dart:convert';

import 'package:weather/core/databases/cache/cache_helper.dart';
import 'package:weather/core/errors/expentions.dart';
import 'package:weather/features/home/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeather();
  Future<void> cacheWeather(WeatherModel cachedWeather);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final CacheHelper cacheHelper;
  static const String cachedWeatherKey = 'CACHED_WEATHER';

  WeatherLocalDataSourceImpl({required this.cacheHelper});

  @override
  Future<void> cacheWeather(WeatherModel cachedWeather) async {
    final jsonString = jsonEncode(cachedWeather.toJson());
    await cacheHelper.saveData(key: cachedWeatherKey, value: jsonString);
  }

  @override
  Future<WeatherModel> getLastWeather() async {
    final jsonString = cacheHelper.getDataString(key: cachedWeatherKey);
    if (jsonString == null) {
      throw CacheException(errorMessage: 'No cached weather found');
    }

    return WeatherModel.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }
}
