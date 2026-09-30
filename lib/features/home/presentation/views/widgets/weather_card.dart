import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/core/helper/get_feels.dart';
import 'package:weather/core/helper/get_weather_lottie.dart';
import 'package:weather/features/home/domain/entities/weather.dart';
import 'package:weather/features/home/presentation/views/widgets/weather_image_placeholder.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity? weather;

  const WeatherCard({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    final city = weather?.location.name ?? 'City Name';
    final status = weather?.current.condition.text ?? 'Loading weather';

    final temperature = weather != null
        ? '${weather!.current.tempC.toStringAsFixed(1)}°'
        : '--°';

    final description = getFeelsLikeDescription(
      weather?.current.condition.text,
      weather?.current.tempC,
      weather?.current.feelsLikeC,
    );
    final lottieAsset = getWeatherLottieAsset(
      weather?.current.condition.text,
      weather?.current.isDay,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        final weatherInfo = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.black87),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    city,
                    style: TextStyle(
                      fontSize: isWide ? 24 : 20,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              temperature,
              style: TextStyle(
                fontSize: isWide ? 64 : 56,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Feels like $description',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        );

        final weatherImage = Lottie.asset(
          lottieAsset,
          width: isWide ? 150 : constraints.maxWidth * 0.4,
          height: isWide ? 150 : 140,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => WeatherImagePlaceholder(
            width: isWide ? 150 : constraints.maxWidth * 0.4,
            icon: Icons.cloud_off_rounded,
          ),
        );
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(isWide ? 32 : 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFF8A71).withOpacity(0.02),
                const Color(0xFFFFC9A8).withOpacity(0.55),
                const Color(0xFFFFF6EA),
                Colors.white,
              ],
              stops: const [0.0, 0.35, 0.7, 1.0],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: isWide
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: weatherInfo),
                    const SizedBox(width: 24),
                    weatherImage,
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    weatherInfo,
                    const SizedBox(height: 16),
                    Center(child: weatherImage),
                  ],
                ),
        );
      },
    );
  }
}
