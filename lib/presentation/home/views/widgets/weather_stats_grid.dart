import 'package:flutter/material.dart';
import 'package:weather/presentation/home/domain/entities/current_weather.dart';
import 'weather_stat_card.dart';

class WeatherStatsGrid extends StatelessWidget {
  final CurrentWeatherEntity? current;

  const WeatherStatsGrid({super.key, this.current});

  @override
  Widget build(BuildContext context) {
    final cards = weatherStateCardList(current: current);

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) => cards[index],
        );
      },
    );
  }
}

List<WeatherStatCard> weatherStateCardList({CurrentWeatherEntity? current}) {
  return [
    WeatherStatCard(
      icon: Icons.water_drop,
      iconColor: Colors.blue,
      label: 'Humidity',
      value: current != null ? '${current.humidity}%' : '--',
    ),
    WeatherStatCard(
      icon: Icons.air,
      iconColor: Colors.teal,
      label: 'Wind',
      value: current != null
          ? '${current.windKph.toStringAsFixed(1)} km/h'
          : '--',
    ),
    WeatherStatCard(
      icon: Icons.wb_sunny,
      iconColor: Colors.orange,
      label: 'UV Index',
      value: current != null ? current.uv.toStringAsFixed(1) : '--',
    ),
    WeatherStatCard(
      icon: Icons.compress,
      iconColor: Colors.purple,
      label: 'Pressure',
      value: current != null ? '${current.pressureMb} hPa' : '--',
    ),
  ];
}
