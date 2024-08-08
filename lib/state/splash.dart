import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:location_app/model/place.dart';

class SplashScreenProvider with ChangeNotifier {
  PlaceLocation _pickedLocation = PlaceLocation(latitude: 37.422, longitude: -122.084);

  Future getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    double? lat = locationData.latitude;
    double? lng = locationData.longitude;
    if (lat == null || lng == null) {
     return;
    }
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
    
  }

  PlaceLocation get userLocation {
    return _pickedLocation;
  }
}
