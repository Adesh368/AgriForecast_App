import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location_app/model/crop_data.dart';

class InputProvider with ChangeNotifier {
  CropData? userRequest;

  Future getForecast(
      {required String crop,
      required String year,
      required String language,
      required String city}) async {
    const String _apiKey = String.fromEnvironment('API_KEY');

    if (_apiKey.isEmpty) {
      print('No \$API_KEY environment variable');
      return;
    }

    // print(_apiKey);
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "text":
                      "Provide crop insight base on  flooding history,drought history,climate requirement,recommended agricultural practices,and {Year} prediction only on {crop} farming in {city} using the following JSON structure:{\"drought_history\":,\"flooding_history\":,\"climate_requirements\":,\"recommended_agricultural_practices\":,\"yearly_predictions\":,}drought_history and flooding_history should be of String type.climate_requirements, yearly_predictions, and recommended_agricultural_practices should be of type List of String.Please deliver the response in {language}."
                },
                {
                  "text":
                      "UserInput: Provide insights  on tomato farming in Los Angeles\n and also prediction for the year 2026. Please deliver the response in English language."
                },
                {
                  "text":
                      "JsonSchema: {\n  \"drought_history\": \"Los Angeles has experienced several severe droughts in recent decades, most notably in the 1970s and 2010s.\",\n  \"flooding_history\": \"Los Angeles is susceptible to flooding, particularly during El Niño events and heavy rainfall.\",\n  \"climate_requirements\": [\n    \"Tomato plants require a minimum of 6 hours of direct sunlight per day.\",\n    \"The ideal temperature range for tomato growth is between 65-85 degrees Fahrenheit.\",\n    \"Well-drained soil with a pH of 6.0-6.8 is optimal for tomato cultivation.\"\n  ],\n  \"recommended_agricultural_practices\": [\n    \"Drip irrigation is recommended to conserve water in the arid climate.\",\n    \"Tomato plants benefit from regular fertilization with nitrogen, phosphorus, and potassium.\",\n    \"Control tomato hornworms and other pests through organic methods like Bacillus thuringiensis.\"\n  ],\n  \"yearly_predictions\": [\n    \"2024 is predicted to have above-average temperatures in Los Angeles.\",\n    \"Rainfall is expected to be below average, potentially leading to drought conditions.\",\n    \"Despite the challenges, tomato yields are expected to be moderately good due to efficient irrigation practices.\"\n  ]\n}"
                },
                {
                  "text":
                      "UserInput: Provide insights  on $crop farming in $city\n and also prediction for the year $year. Please deliver the response in $language language."
                },
                {"text": "JsonSchema: "}
              ]
            }
          ],
          "generationConfig": {
            "temperature": 1,
            "topK": 64,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "text/plain"
          }
        }),
      );

      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);
        String jsonResponse =
            resData['candidates'][0]['content']['parts'][0]['text'];
        final cleanJsonResponse =
            jsonResponse.replaceAll('```json', '').replaceAll('```', '').trim();
        final jsonData = jsonDecode(cleanJsonResponse);

       if(resData != null){
         userRequest = CropData(
            droughtHistory: jsonData['drought_history'],
            floodingHistory: jsonData['flooding_history'],
            climateRequirements:
                List<String>.from(jsonData['climate_requirements']),
            recommendedAgriculturalPractices: List<String>.from(
                jsonData['recommended_agricultural_practices']),
            yearlyPredictions:
                List<String>.from(jsonData['yearly_predictions']));
        //print(jsonData);
       }
      }
      

      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  CropData? get cropData {
    return userRequest;
  }
}
