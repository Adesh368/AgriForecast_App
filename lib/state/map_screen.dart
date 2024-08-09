import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MapProvider with ChangeNotifier {
  Future fetchLocation(
      double pickedLocationlat, double pickedLocationlng) async {
        final apiKey = dotenv.env['GOOGLE_API_KEY'];
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$pickedLocationlat,$pickedLocationlng&key=$apiKey');
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
