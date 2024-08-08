import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location_app/model/usermodel.dart';

class SignInProvider with ChangeNotifier {
  Usermodel? userInfo;

  Future userSignIn(String userloginname, String userpassword) async {
    final url = Uri.parse('https://api.tapit.ng/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'id': userloginname,
            'password': userpassword,
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

  // user getter
  Usermodel? get listofname {
    return userInfo;
  }
}
