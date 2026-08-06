import 'package:weather/presentation/home/domain/entities/location.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.name,
    required super.region,
    required super.country,
    required super.lat,
    required super.lon,
    required super.tzId,
    required super.localtimeEpoch,
    required super.localtime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      tzId: json['tz_id'] as String,
      localtimeEpoch: json['localtime_epoch'] as int,
      localtime: json['localtime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'tz_id': tzId,
      'localtime_epoch': localtimeEpoch,
      'localtime': localtime,
    };
  }
}
