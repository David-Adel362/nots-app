import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getUserPosition() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }
}
