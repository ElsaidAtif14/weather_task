import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<String?> getCurrentCityName();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<String?> getCurrentCityName() async {
    final position = await _determinePosition();
    final places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isEmpty) return null;

    final place = places.first;
    return place.locality?.trim().isNotEmpty == true
        ? place.locality
        : place.subAdministrativeArea?.trim().isNotEmpty == true
        ? place.subAdministrativeArea
        : place.administrativeArea?.trim().isNotEmpty == true
        ? place.administrativeArea
        : null;
  }

  Future<Position> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
