String getFeelsLikeDescription(String? condition, double? tempC, double? feelsLikeC) {
  if (condition == null || tempC == null || feelsLikeC == null) {
    return 'Fetching latest data...';
  }

  final lowerCondition = condition.toLowerCase();

  return switch (lowerCondition) {
    _ when lowerCondition.contains('rain') || lowerCondition.contains('drizzle') =>
      tempC < 15 ? 'Chilly & Wet' : 'Humid & Rainy',

    _ when lowerCondition.contains('snow') || lowerCondition.contains('ice') =>
      'Freezing Cold',

    _ when lowerCondition.contains('sunny') || lowerCondition.contains('clear') => switch (feelsLikeC) {
        >= 35 => 'Extremely Hot',
        >= 28 => 'Warm & Bright',
        >= 18 => 'Pleasant & Sunny',
        _ => 'Crisp & Cool',
      },

    _ when lowerCondition.contains('cloud') || lowerCondition.contains('overcast') => switch (feelsLikeC) {
        >= 30 => 'Muggy & Warm',
        >= 20 => 'Comfortable Mild',
        _ => 'Cool & Breezy',
      },

    _ => switch (feelsLikeC) {
        >= 35 => 'Sweltering Heat',
        >= 25 => 'Pleasantly Warm',
        >= 15 => 'Mild Weather',
        _ => 'Cold Outside',
      },
  };
}