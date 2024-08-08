import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:location_app/model/usermodel.dart';

class SignUpProvider with ChangeNotifier {
  Usermodel? userInfo;

  // Sign Up Request Method
  Future signUp({required String mail, required String password,required String username}) async {
    final url = Uri.parse('https://api.tapit.ng/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'fname': 'firstnamed',
            'lname': 'lastname',
            'email': mail,
            'username': username,
            'phone': 'phonenumberd',
            'password': password,
            'm': 'app',
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userInfo = Usermodel(
          email: responsedata['data']['email'],
        );
      }

      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // User Getter
  Usermodel? get listofname {
    return userInfo;
  }
}
