String getWeatherLottieAsset(String? conditionText, int? isDay) {
  if (conditionText == null) return 'assets/lottie/clear-day.json';

  final condition = conditionText.toLowerCase();
  final bool isDayTime = isDay == 1;

  if (condition.contains('rain') || condition.contains('shower')) {
    return 'assets/lottie/rain.json';
  } else if (condition.contains('drizzle')) {
    return 'assets/lottie/drizzle.json';
  } else if (condition.contains('snow') || condition.contains('ice')) {
    return 'assets/lottie/snow.json';
  } else if (condition.contains('sleet')) { 
    return 'assets/lottie/sleet.json';
  } else if (condition.contains('hail')) {
    return 'assets/lottie/hail.json';
  } else if (condition.contains('mist') ||
      condition.contains('fog') ||
      condition.contains('smoke')) {
    return 'assets/lottie/smoke.json';
  } else if (condition.contains('cloud') || condition.contains('overcast')) {
    return 'assets/lottie/cloudy.json';
  } else if (condition.contains('clear') || condition.contains('sunny')) {
    return isDayTime
        ? 'assets/lottie/clear-day.json'
        : 'assets/lottie/clear-night.json';
  }

  return isDayTime
      ? 'assets/lottie/clear-day.json'
      : 'assets/lottie/clear-night.json';
}
