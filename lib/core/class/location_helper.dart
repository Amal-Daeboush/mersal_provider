import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Get.snackbar('alert', 'Please turn on location services');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.snackbar('alert', 'Please give a location permission');
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Get.snackbar(
            'error', 'you can not use application without location');
      }
    }
  }
}
