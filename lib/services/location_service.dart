import 'package:geolocator/geolocator.dart';

class LocationService {
  // ------------------------------------------------------
  // Request location permission
  // ------------------------------------------------------
  Future<bool> requestPermission() async {
    LocationPermission permission;

    // Check current permission state
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Ask again
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return false; // user still denied
      }
    }

    // If denied forever → must open app settings manually
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  // ------------------------------------------------------
  // Get current GPS position
  // ------------------------------------------------------
  Future<Position> getLocation() async {
    final allowed = await requestPermission();

    if (!allowed) {
      throw Exception("Location permission denied");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
