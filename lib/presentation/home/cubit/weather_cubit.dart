import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/home/domain/usecases/get_weather_usecase.dart';
import 'package:weather/presentation/home/cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherCubit({required this.getWeatherUseCase}) : super(const WeatherInitial());

  Future<void> getWeather({String? cityName}) async {
    emit(const WeatherLoading());

    final result = await getWeatherUseCase(
      WeatherParams(cityName: cityName),
    );

    result.fold(
      (failure) => emit(WeatherError(failure.errMessage)),
      (weather) => emit(WeatherSuccess(weather)),
    );
  }
}
