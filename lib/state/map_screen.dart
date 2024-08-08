import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MapProvider with ChangeNotifier {
  Future fetchLocation(
      double pickedLocationlat, double pickedLocationlng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$pickedLocationlat,$pickedLocationlng&key=AIzaSyANCcAa09J_M6N_tRRd6_K8cF8mIthUPBw');
    try {
      final response = await http.get(url);
      final resData = jsonDecode(response.body);
      //isSelecting = true;
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
