import 'package:weather/core/databases/api/api_consumer.dart';
import 'package:weather/core/databases/api/end_points.dart';
import 'package:weather/presentation/home/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String query);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiConsumer apiConsumer;

  WeatherRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<WeatherModel> getCurrentWeather(String query) async {
    final response = await apiConsumer.get(
      EndPoints.currentWeather,
      queryParameters: {'key': EndPoints.apiKey, 'q': query},
    );

    return WeatherModel.fromJson(response as Map<String, dynamic>);
  }
}
