import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather/presentation/home/cubit/weather_cubit.dart';
import 'package:weather/presentation/home/cubit/weather_state.dart';
import 'weather_card.dart';
import 'weather_stats_grid.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherError) {
          return Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_off_rounded,
                  color: Colors.red.shade300,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        }

        final isLoading = state is! WeatherSuccess;
        final weather = state is WeatherSuccess ? state.weather : null;

        return Skeletonizer(
          enabled: isLoading,
          effect: ShimmerEffect(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            duration: const Duration(milliseconds: 1200),
          ),
          child: Column(
            children: [
              WeatherCard(weather: weather),
              const SizedBox(height: 20),
              WeatherStatsGrid(current: weather?.current),
            ],
          ),
        );
      },
    );
  }
}
